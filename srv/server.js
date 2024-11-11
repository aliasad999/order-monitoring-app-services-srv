const tracer = require('@sap/xotel-agent-ext-js/dist/common/tracer');
const proxy = require("@cap-js-community/odata-v2-adapter");
const cds = require('@sap/cds')
const express = require('express')()
var bodyParser = require('body-parser');
require('hdb/lib/protocol/common/Constants').MAX_PACKET_SIZE = Math.pow(4,15);
const xsenv = require('@sap/xsenv');
const passport = require('passport');
const { JWTStrategy } = require('@sap/xssec');

xsenv.loadEnv();
const xsuaaCredentials = xsenv.serviceCredentials({ tag: 'xsuaa' });
passport.use(new JWTStrategy(xsuaaCredentials));

const fesr = require("@sap/fesr-to-otel-js");

function isEmpty(obj) {
    for (var prop in obj) {
        if (Object.prototype.hasOwnProperty.call(obj, prop)) {
        return false;
        }
    }

    return true
}

async function upsertVariant(req, res, body) {
    const { Variants } = await cds.entities("srvOpenOrders");
	// var body = req.body[0];
    var userId = req.user.id;
    var generator = '';
    var service = '';
    var variantName = '';

    if (typeof body.support !== 'undefined') {
        generator = body.support.generator;
        service = body.support.service;
    }
    if (typeof body.texts !== 'undefined') {
        if (typeof body.texts.variantName !== 'undefined') {
            variantName = body.texts.variantName.value;
        }
    }
    let variantData = [{
        fileName: body.fileName,
        fileType: body.fileType,
        changeType: body.changeType,
        reference: body.reference,
        packageName: body.packageName,
        content: JSON.stringify(body.content),
        namespace: body.namespace,
        originalLanguage: body.originalLanguage,
        conditions: JSON.stringify(body.conditions),
        contexts: JSON.stringify(body.contexts),
        supportGenerator: generator,
        supportService: service,
        supportUser: userId,
        layer: body.layer,
        selector: JSON.stringify(body.selector),
        texts: JSON.stringify(body.texts),
        variantName: variantName,
        variantId: body.variantId,
        projectId: body.projectId,
        standardVariant: body.standardVariant,
        favorite: body.favorite,
        executeOnSelection: body.executeOnSelection
    }];
    try {
        if(body.fileName.indexOf("_updateVariant") < 0){
            await UPSERT.into(Variants).entries(variantData);
        }else{
            var updateObject = {};
            if(body.content.favorite !== undefined){
                updateObject.favorite = body.content.favorite;
            }
            if(body.content.executeOnSelection !== undefined){
                updateObject.executeOnSelection = body.content.executeOnSelection;
            }
            if(!isEmpty(updateObject)){
                await UPDATE(Variants, body.selector.variantId).with(updateObject)
            }  
        }
        res.type('application/json').status(200).send(body);
    } catch (err) {
        res.type('text/plain').status(500).send(`ERROR: ${err.toString()}`);
		return;
    }

}


module.exports = cds.server;

cds.on('bootstrap', (app) => {
    app.use(proxy());
    app.use(passport.initialize());
    app.use(passport.authenticate('JWT', { session: false }));  
    fesr.registerFesrEndpoint(app);

    var bodyParser = require('body-parser');
	app.use(bodyParser.json());

	app.get('/actions/getcsrftoken/', (req, res) => {
		res.type('text/html').status(200).send('');
	});

	app.post('/variants/', async(req, res) => {
		await upsertVariant(req, res, req.body[0]);
	});

    app.post('/changes/', async(req, res) => {
		await upsertVariant(req, res, req.body[0]);
	});

    app.put('/changes/:fileName', async (req, res) => {
        await upsertVariant(req, res, req.body);
    });

    app.put('/variants/:fileName', async (req, res) => {
        await upsertVariant(req, res, req.body);
	});

    app.get('/flex/data/:app?', async (req, res) => {
        const { Variants } = await cds.entities("srvOpenOrders");
        var appInput = req.params.app;
        var userId = req.user.id;
        var userVariants = await SELECT.from(Variants).where `reference = ${appInput}
            and (( supportUser = ${userId} and layer = 'USER' ) or
                layer = 'CUSTOMER' )`;
  
		var outer = {
			'changes': [],
			'settings': {
				"isKeyUser": true,
                "isAtoAvailable": true,
                "isAtoEnabled": false,
                "isProductiveSystem": true,
                "isVariantSharingEnabled": true,
                "isZeroDowntimeUpgradeRunning": false
			}
		};

        userVariants.forEach(function(variant){
            var body = {};
            body.fileName = variant.fileName;
            body.fileType = variant.fileType;
            body.changeType = variant.changeType;
            body.conditions = JSON.parse(variant.conditions);
            body.content = JSON.parse(variant.content);
            body.contexts = JSON.parse(variant.contexts);
            body.creation = variant.creation;
            body.layer = variant.layer;
            body.namespace = variant.namespace;
            body.originalLanguage = variant.originalLanguage;
            body.packageName = variant.packageName;
            body.reference = variant.reference;
            body.selector = JSON.parse(variant.selector);
            body.texts = JSON.parse(variant.texts);
            body.support = {};
            body.support.generator = variant.supportGenerator;
            body.support.service = variant.supportService;
            body.support.user = variant.supportUser;
            body.variantId = variant.variantId;
            body.projectId = variant.projectId; //"ordermonitoring.openorders";
            body.standardVariant = variant.standardVariant; //false; 
            body.favorite = variant.favorite; //true; 
            body.executeOnSelection = variant.executeOnSelection; //false; 
            outer.changes.push(body);
        })
        res.type('application/json').status(200).send(outer);
	});

    app.delete('/variants/:fileName', async (req, res) => {
        const { Variants } = await cds.entities("srvOpenOrders");
		var body = req.body;
		var fileNameInput = req.params.fileName;
        try{
            await DELETE.from(Variants).where `fileName = ${fileNameInput}`; 
         res.type('application/json').status(200).send(body);
        }catch(err){
            res.type('text/plain').status(500).send(`ERROR: ${err.toString()}`);
           return;
        }
        
	});

})
module.exports = cds.server