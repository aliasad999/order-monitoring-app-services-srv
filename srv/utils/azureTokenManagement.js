const axios = require('axios');
const { azureTokenSessionCache, azureRefreshTokenSessionCache } = require('../auth/azureTokenCache');
const jwt = require('jsonwebtoken');
const msal = require('@azure/msal-node');
const credentialHelper = require('basf-cf-credential-store-helper');
const { getPca } = require('../auth/msalConfig');

const isLoggedIn = async (req, res) => {
    try {
        const username = req.query.username;
        if (!username) {
            return res.status(400).json({ error: "Username is required as a query parameter." });
        }

        if(await getAccessToken(username)){
            res.status(200).json({ loggedIn: true });
        } else {
            res.status(200).json({ loggedIn: false });
        }
    } catch (error) {
        console.error("Error checking login status: ", error);
        res.status(500).json({ error: "An internal server error occurred." });
    }
}

const login = async (req, res) => {
    try {
        const chatbotRedirectUrl = await credentialHelper.getPasswordByName("order-monitoring", "chatbotRedirectUrl");
        const chatbotScope = await credentialHelper.getPasswordByName("order-monitoring", "chatbotScope");
        const cryptoProvider = new msal.CryptoProvider();
        const { verifier, challenge } = await cryptoProvider.generatePkceCodes();

        req.session.pkceCodes = {
            challengeMethod: 'S256',
            verifier: verifier,
            challenge: challenge,
        };

        const pca = await getPca();
        const authCodeUrl = await pca.getAuthCodeUrl({
            scopes: [chatbotScope.value],
            redirectUri: chatbotRedirectUrl.value,
            codeChallenge: challenge,
            codeChallengeMethod: 'S256'
        });

        console.log("AuthCodeUrl:", authCodeUrl);

        res.redirect(authCodeUrl);
    } catch (error) {
        console.error("Error generating auth code URL: ", error.message);
        res.status(500).send("Error generating auth code URL");
    }
}

const redirect = async (req, res) => {
    try {
        const chatbotTenantId = await credentialHelper.getPasswordByName("order-monitoring", "chatbotTenantId");
        const chatbotClientId = await credentialHelper.getPasswordByName("order-monitoring", "chatbotClientId");
        const chatbotRedirectUrl = await credentialHelper.getPasswordByName("order-monitoring", "chatbotRedirectUrl");
        const chatbotScope = await credentialHelper.getPasswordByName("order-monitoring", "chatbotScope");

        const tokenRequestBody = new URLSearchParams({
            client_id: chatbotClientId.value,
            code: req.query.code,
            redirect_uri: chatbotRedirectUrl.value,
            code_verifier: req.session.pkceCodes.verifier,
            scopes: chatbotScope.value,
            grant_type: "authorization_code",
        });

        // Request access token from Microsoft OAuth
        const response = await axios.post(
            `https://login.microsoftonline.com/${chatbotTenantId.value}/oauth2/v2.0/token`,
            tokenRequestBody,
            {
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                    "Origin": "http://localhost",
                },
            }
        );

        const accessToken = response.data.access_token;
        const refreshToken = response.data.refresh_token;
        const decodedToken = jwt.decode(accessToken);
        const username = decodedToken.upn.split('@')[0].toUpperCase();

        console.log("Access token acquired:", accessToken);
        console.log("Username:", username);

        azureTokenSessionCache.set(username, accessToken);
        azureRefreshTokenSessionCache.set(username, refreshToken);

        res.send(`
            <html>
                <body>
                    <h1>Login successful!</h1>
                    <p>Token acquired. This window will close automatically. Please go back and make your first question to our bot!</p>
                    <script>
                        setTimeout(() => {
                            window.close();
                        }, 3000); // Close window after 3 seconds
                    </script>
                </body>
            </html>
        `);
    } catch (error) {
        console.error("Error acquiring token:", error.message);
        res.status(500).send("Error acquiring token");
    }
}

async function getAccessToken(username) {
    try {
        if (!username) {
            return null;
        }

        var accessToken = azureTokenSessionCache.get(username);
        console.log("Access token old: ", accessToken);
        const refreshToken = azureRefreshTokenSessionCache.get(username);
        console.log("Refresh token: ", refreshToken);

        if (accessToken && !hasTokenExpired(accessToken)) {
            return accessToken;
        } else if (refreshToken) {
            console.log("Refresh token still valid but not access token.");
            return await refreshAccessToken(refreshToken);
        }
    } catch (error) {
        console.error("Error getting access token: ", error);
    }
    return null;
}

function hasTokenExpired(token) {
    if (!token) return true;

    const decoded = jwt.decode(token);
    if (!decoded || !decoded.exp) return true;

    const now = Math.floor(Date.now() / 1000);
    return decoded.exp < now; // Return true if expired, false otherwise
}

async function refreshAccessToken(refreshToken) {
    try {
        const chatbotTenantId = await credentialHelper.getPasswordByName("order-monitoring", "chatbotTenantId"); 
        const chatbotClientId = await credentialHelper.getPasswordByName("order-monitoring", "chatbotClientId");
        const chatbotScope = await credentialHelper.getPasswordByName("order-monitoring", "chatbotScope");

        console.log("Refresh access token now.");
        const response = await axios.post(
            "https://login.microsoftonline.com/" + chatbotTenantId.value + "/oauth2/v2.0/token",
            new URLSearchParams({
                client_id: chatbotClientId.value,
                grant_type: "refresh_token",
                refresh_token: refreshToken,
                scope: chatbotScope.value,
            }),
            {
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                    "Origin": "http://localhost",
                },
            }
        );

        const accessToken = response.data.access_token;

        console.log("accessToken new (refreshed): ", accessToken);

        const decodedToken = jwt.decode(accessToken);
        const username = decodedToken.upn.split('@')[0].toUpperCase();

        azureTokenSessionCache.set(username, accessToken);
        return accessToken;
    } catch (error) {
        console.error("Error refreshing access token: ", error);
        return null;
    }
}

module.exports = {
    isLoggedIn,
    login,
    redirect,
    getAccessToken
};