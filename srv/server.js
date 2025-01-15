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
// const authProvider = require('./auth/AuthProvider');
// const { REDIRECT_URI, POST_LOGOUT_REDIRECT_URI } = require('./utils/authConfig');
const path = require('path');
const { cca } = require('./utils/msalConfig');
require('hdb/lib/protocol/common/Constants').MAX_PACKET_SIZE = Math.pow(4,15);
const azureTokenSessionCache = require('./utils/azureTokenSessionCache');
const { log } = require('console');

xsenv.loadEnv();
const xsuaaCredentials = xsenv.serviceCredentials({ tag: 'xsuaa' });
passport.use(new JWTStrategy(xsuaaCredentials));

module.exports = cds.server;

cds.on('bootstrap', (app) => {
    // app.use(proxy());
    // app.use(passport.initialize());
    // app.use(passport.authenticate('JWT', { session: false }));  

    const authCodeUrlParameters = {
        scopes: ["user.read"],
        redirectUri: process.env.REDIRECT_URI
    };

    fesr.registerFesrEndpoint(app);
	app.use(bodyParser.json());

    // CLOUD Variant Management implementation
	app.get('/actions/getcsrftoken/', (req, res) => {
		res.type('text/html').status(200).send('');
	});

	app.post(['/variants/', '/changes/'], async(req, res) => {
		await variantManager.upsertVariant(req, res, req.body[0]);
	});

    app.put(['/changes/:fileName' , '/variants/:fileName'], async (req, res) => {
        await variantManager.upsertVariant(req, res, req.body);
    });

    app.get('/flex/data/:app?', async (req, res) => {
        await variantManager.getUserVariants(req,res);
	});

    app.delete('/variants/:fileName', async (req, res) => {
        await variantManager.deleteVariant(req,res);
	});
    // END OF CLOUD Variant Management implementation

    // app.get('/auth/signin', authProvider.login({
    //     scopes: [],
    //     redirectUri: REDIRECT_URI,
    //     successRedirect: '/'
    // }));
    
    // app.get('/auth/acquireToken', authProvider.acquireToken({
    //     scopes: ['User.Read'],
    //     redirectUri: REDIRECT_URI,
    //     successRedirect: '/users/profile'
    // }));
    
    // app.post('/auth/redirect', authProvider.handleRedirect());
    
    // app.get('/signout', authProvider.logout({
    //     postLogoutRedirectUri: POST_LOGOUT_REDIRECT_URI
    // }));

    // app.get('/test_chatbot', function (req, res, next) {
    //     res.sendFile(path.join(__dirname, 'views', 'index.html'));
    // });

    app.get('/login', async (req, res) => {
        try {
            const authCodeUrl = await cca.getAuthCodeUrl(authCodeUrlParameters);
            res.redirect(authCodeUrl);
        } catch (error) {
            console.error("Error generating auth code URL:", error);
            res.status(500).send("Error generating auth code URL");
        }
    });

    // Handle redirect (Azure AD sends the user back here after login)
    app.get('/redirect', async (req, res) => {
        const tokenRequest = {
            code: req.query.code,
            scopes: ["user.read"],
            redirectUri: process.env.REDIRECT_URI,
        };

        try {
            const response = await cca.acquireTokenByCode(tokenRequest);
            const username = response.account.username.split('@')[0].toUpperCase();
            const accessToken = response.accessToken;

            console.log("Access token acquired:", accessToken);
            console.log("Username: ",  username);

            // res.send("Login successful! Token acquired. Please go back and make your first question to our bot!");
            res.send(`
                <html>
                    <body>
                        <h1>Login successful!</h1>
                        <p>Token acuqired. This window will close automatically. Please go back and make your first question to our bot!</p>
                        <script>
                            // Display message for a short time, then close the tab
                            setTimeout(() => {
                                window.close();
                            }, 3000); // Adjust delay (3 seconds) if needed
                        </script>
                    </body>
                </html>
            `);

            azureTokenSessionCache.set(username, accessToken);
            
        } catch (error) {
            console.error("Error acquiring token:", error);
            res.status(500).send("Error acquiring token");
        }
    });
    

})
module.exports = cds.server