const tracer = require('@sap/xotel-agent-ext-js/dist/common/tracer');
const proxy = require("@cap-js-community/odata-v2-adapter");
const cds = require('@sap/cds')
const express = require('express')()

var bodyParser = require('body-parser');
const fesr = require("@sap/fesr-to-otel-js");
const xsenv = require('@sap/xsenv');
const passport = require('passport');
const { JWTStrategy } = require('@sap/xssec');
const variantManager = require('./utils/variantManagement');
const path = require('path');
const { getPca } = require('./auth/msalConfig');
require('hdb/lib/protocol/common/Constants').MAX_PACKET_SIZE = Math.pow(4, 15);
const { azureTokenSessionCache, azureRefreshTokenSessionCache } = require('./auth/azureTokenCache');
const jwt = require('jsonwebtoken');
const { log } = require('console');
const msal = require('@azure/msal-node');
const session = require("express-session");
const axios = require('axios');
const credentialHelper = require('basf-cf-credential-store-helper');

xsenv.loadEnv();
const xsuaaCredentials = xsenv.serviceCredentials({ tag: 'xsuaa' });
passport.use(new JWTStrategy(xsuaaCredentials));

module.exports = cds.server;

cds.on('bootstrap', async (app) => {
    app.use(proxy());
    app.use(passport.initialize());
    app.use(passport.authenticate('JWT', { session: false }));
    fesr.registerFesrEndpoint(app);
    app.use(bodyParser.json());

    const sessionSecret = await credentialHelper.getPasswordByName("order-monitoring", "chatbotSessionSecret");

    app.use(session({
        secret: sessionSecret.value,
        resave: false,
        saveUninitialized: true,
        cookie: { secure: false }
    }));

    // CLOUD Variant Management implementation
    app.get('/actions/getcsrftoken/', (req, res) => {
        res.type('text/html').status(200).send('');
    });

    app.post(['/variants/', '/changes/'], async (req, res) => {
        await variantManager.upsertVariant(req, res, req.body[0]);
    });

    app.put(['/changes/:fileName', '/variants/:fileName'], async (req, res) => {
        await variantManager.upsertVariant(req, res, req.body);
    });

    app.get('/flex/data/:app?', async (req, res) => {
        await variantManager.getUserVariants(req, res);
    });

    app.delete('/variants/:fileName', async (req, res) => {
        await variantManager.deleteVariant(req, res);
    });
    // END OF CLOUD Variant Management implementation

    app.get('/login/status', (req, res) => {
        try {
            const username = req.query.username;
            if (!username) {
                return res.status(400).json({ error: "Username is required as a query parameter." });
            }

            var accessToken = azureTokenSessionCache.get(username);
            console.log("Access token old: ", accessToken);
            const refreshToken = azureRefreshTokenSessionCache.get(username);
            console.log("Refresh token: ", refreshToken);

            if (accessToken && !hasTokenExpired(accessToken)) {
                console.log("Access token still valid.");
                res.status(200).json({ loggedIn: true });

            } else if (refreshToken) {
                console.log("Refresh token still valid but not access token.");
                refreshAccessToken(refreshToken);
                res.status(200).json({ loggedIn: true });

            } else {
                console.log("Neither access token nor refresh token valid.", accessToken, refreshToken);
                res.status(200).json({ loggedIn: false });
            }
        } catch (error) {
            console.error("Error checking login status: ", error);
            res.status(500).json({ error: "An internal server error occurred." });
        }
    });

    function hasTokenExpired(token) {
        if (!token) return true;

        const decoded = jwt.decode(token);
        if (!decoded || !decoded.exp) return true;

        const now = Math.floor(Date.now() / 1000);
        return decoded.exp < now; // Return true if expired, false otherwise
    }

    async function refreshAccessToken(refreshToken) {
        try {
            const chatbotTenantId = await readCredential("order-monitoring", "password", "chatbotTenantId");
            const chatbotClientId = await readCredential("order-monitoring", "password", "chatbotClientId");
            const chatbotScope = await readCredential("order-monitoring", "password", "chatbotScope");

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
            const decodedToken = jwt.decode(accessToken);
            const username = decodedToken.upn.split('@')[0].toUpperCase();
            azureTokenSessionCache.set(username, accessToken);
        } catch (error) {
            console.error("Error refreshing access token: ", error);
        }
    }

    app.get('/login', async (req, res) => {
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
    });

    // Redirect Route (Handles Azure AD Login Response)
    app.get('/redirect', async (req, res) => {
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
    });
})
module.exports = cds.server