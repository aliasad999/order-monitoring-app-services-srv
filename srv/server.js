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
const { getCca } = require('./utils/msalConfig');
const chatbotArgusConfig =  require('./lib/chatbotArgusConfig.json');
require('hdb/lib/protocol/common/Constants').MAX_PACKET_SIZE = Math.pow(4,15);
const azureTokenSessionCache = require('./utils/azureTokenSessionCache');
const { log } = require('console');

xsenv.loadEnv();
const xsuaaCredentials = xsenv.serviceCredentials({ tag: 'xsuaa' });
passport.use(new JWTStrategy(xsuaaCredentials));

module.exports = cds.server;

const cfEnvironment = process.env.CF_ENV; // get environment from User provided variables
const chatbotConfig = chatbotArgusConfig["cfEnvironment"]; 

cds.on('bootstrap', (app) => {
    // app.use(proxy());
    // app.use(passport.initialize());
    // app.use(passport.authenticate('JWT', { session: false }));  

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

    app.get('/login', (req, res) => {
        const authCodeUrlParameters = {
            scopes: ["api://829b8c1c-c15c-43d3-853f-348c7fafa0fb/User.Read"],
            redirectUri: "https://port4004-workspaces-ws-lqndl.eu10.applicationstudio.cloud.sap/redirect", // TODO: Replace with chatbotConfig.redirectUrl 
        };

        getCca()
            .then(cca => {
                return cca.getAuthCodeUrl(authCodeUrlParameters);
            })
            .then(authCodeUrl => {
                console.log("AuthCodeUrl:", authCodeUrl);
                res.redirect(authCodeUrl);
            })
            .catch(error => {
                console.error("Error generating auth code URL:", error);
                res.status(500).send("Error generating auth code URL");
            });
    });

    // Redirect Route (Handles Azure AD Login Response)
    app.get('/redirect', async (req, res) => {
        const tokenRequest = {
            code: req.query.code,
            scopes: ["api://829b8c1c-c15c-43d3-853f-348c7fafa0fb/User.Read"],
            redirectUri: "https://port4004-workspaces-ws-lqndl.eu10.applicationstudio.cloud.sap/redirect", // TODO: Replace
        };

        try {
            const cca = await getCca();
            const response = await cca.acquireTokenByCode(tokenRequest);
            const username = response.account.username.split('@')[0].toUpperCase();
            const accessToken = response.accessToken;

            console.log("Access token acquired:", accessToken);
            console.log("Username:", username);

            azureTokenSessionCache.set(username, accessToken);

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
            console.error("Error acquiring token:", error);
            res.status(500).send("Error acquiring token");
        }
    });
})
module.exports = cds.server