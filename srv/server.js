const tracer = require('@sap/xotel-agent-ext-js/dist/common/tracer');
const proxy = require("@cap-js-community/odata-v2-adapter");
const cds = require('@sap/cds')
const express = require('express')()

var bodyParser = require('body-parser');
const fesr = require("@sap/fesr-to-otel-js");
const xsenv = require('@sap/xsenv');
const passport = require('passport');
const { JWTStrategy } = require("@sap/xssec").v3;
const variantManager = require('./utils/variantManagement');
const azureTokenManager = require('./utils/azureTokenManagement');
const path = require('path');
require('hdb/lib/protocol/common/Constants').MAX_PACKET_SIZE = Math.pow(4, 15);
const session = require("express-session");
const credentialHelper = require('basf-cf-credential-store-helper');

xsenv.loadEnv();
//todo
const xsuaaCredentials = xsenv.serviceCredentials({ tag: 'xsuaa' });
passport.use(new JWTStrategy(xsuaaCredentials));
//todo
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

    app.get('/login/status', async (req, res) => {
        await azureTokenManager.isLoggedIn(req, res);
    });

    app.get('/login', async (req, res) => {
        await azureTokenManager.login(req, res);
    });

    app.get('/redirect', async (req, res) => {
        await azureTokenManager.redirect(req, res);
    });
})
module.exports = cds.server