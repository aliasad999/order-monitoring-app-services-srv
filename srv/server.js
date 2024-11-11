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
require('hdb/lib/protocol/common/Constants').MAX_PACKET_SIZE = Math.pow(4,15);

xsenv.loadEnv();
const xsuaaCredentials = xsenv.serviceCredentials({ tag: 'xsuaa' });
passport.use(new JWTStrategy(xsuaaCredentials));

module.exports = cds.server;

cds.on('bootstrap', (app) => {
    app.use(proxy());
    app.use(passport.initialize());
    app.use(passport.authenticate('JWT', { session: false }));  
    fesr.registerFesrEndpoint(app);
	app.use(bodyParser.json());

	app.get('/actions/getcsrftoken/', (req, res) => {
		res.type('text/html').status(200).send('');
	});

	app.post('/variants/', async(req, res) => {
		await variantManager.upsertVariant(req, res, req.body[0]);
	});

    app.post('/changes/', async(req, res) => {
		await variantManager.upsertVariant(req, res, req.body[0]);
	});

    app.put('/changes/:fileName', async (req, res) => {
        await variantManager.upsertVariant(req, res, req.body);
    });

    app.put('/variants/:fileName', async (req, res) => {
        await variantManager.upsertVariant(req, res, req.body);
	});

    app.get('/flex/data/:app?', async (req, res) => {
        await variantManager.getUserVariants(req,res);
	});

    app.delete('/variants/:fileName', async (req, res) => {
        await variantManager.deleteVariant(req,res);
	});

})
module.exports = cds.server