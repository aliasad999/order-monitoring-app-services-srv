const tracer = require('@sap/xotel-agent-ext-js/dist/common/tracer');
const proxy = require("@cap-js-community/odata-v2-adapter");
const cds = require('@sap/cds')
const express = require('express')()
var bodyParser = require('body-parser');
require('hdb/lib/protocol/common/Constants').MAX_PACKET_SIZE = Math.pow(4,15);

const fesr = require("@sap/fesr-to-otel-js");

async function upsertVariant(req, res) {
    const { Variants } = await cds.entities("srvOpenOrders");
	var body = req.body[0];
    var userId = "GARCID42" //req.user.id;
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
        contexts: body.contexts,
        supportGenerator: generator,
        supportService: service,
        supportUser: userId,
        layer: body.layer,
        selector: JSON.stringify(body.selector),
        texts: JSON.stringify(body.texts),
        variantName: variantName,
        variantId: body.variantId
    }];
    try {
        var entry = await SELECT.from(Variants).where `changeType = ${body.changeType} 
            and fileType = ${body.fileType} 
            and layer = ${body.layer} 
            and supportUser = ${userId} 
            and variantName = ${variantName}`;
        if(entry.length > 0){
            variantData[0].id = entry[0].id;
            await UPSERT.into(Variants).entries(variantData);
            res.type('application/json').status(200).send(body);
        }else{
            await INSERT.into(Variants).entries(variantData);
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
    fesr.registerFesrEndpoint(app);

    var bodyParser = require('body-parser');
	app.use(bodyParser.json());

	app.get('/actions/getcsrftoken/', (req, res) => {
		res.type('text/html').status(200).send('');
	});

	app.post('/variants/', async(req, res) => {
		await upsertVariant(req, res);
	});

    app.post('/changes/', async(req, res) => {
		await upsertVariant(req, res);
	});

    app.get('/flex/data/:app?', async (req, res) => {
        const { Variants } = await cds.entities("srvOpenOrders");
        var appInput = req.params.app;
        var userId = "GARCID42" //req.user.id;
        var userVariants = await SELECT.from(Variants).where `reference = ${appInput}
            and supportUser = ${userId}`;

        var test = {
            "loadModules": false,
            "changes": [
                {
                    "changeType": "page",
                    "reference": "ordermonitoring.openorders",
                    "namespace": "apps/ordermonitoring.openorders/changes/",
                    "creation": "2024-07-22T13:42:00.8806900Z",
                    "projectId": "ordermonitoring.openorders",
                    "support": {
                        "generator": "FlexObjectFactory.createCompVariant",
                        "user": "GIFONNVD"
                    },
                    "originalLanguage": "EN",
                    "layer": "CUSTOMER",
                    "fileType": "variant",
                    "fileName": "id_1721655719463_306_page",
                    "content": {
                        "allIssuesKey": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_LAND1",
                                        "index": 0
                                    },
                                    {
                                        "columnKey": "SO_BSTKD",
                                        "visible": true,
                                        "index": 1
                                    },
                                    {
                                        "columnKey": "SO_AUART",
                                        "visible": true,
                                        "index": 2
                                    },
                                    {
                                        "columnKey": "SO_VBELN",
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_POSNR",
                                        "index": 4,
                                        "width": "81.56px"
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "DL_POSNR",
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "DL_WADAT_IST",
                                        "visible": false,
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "SO_F_ZZ0S2MATUG",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "SO_AM_PARTNER",
                                        "index": 9
                                    },
                                    {
                                        "columnKey": "SO_AS_PARTNER",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "SO_F_AS_PARTNER",
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "TM_DATEN",
                                        "visible": false,
                                        "index": 12
                                    },
                                    {
                                        "columnKey": "TM_DATBG",
                                        "visible": false,
                                        "index": 13
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "index": 14
                                    },
                                    {
                                        "columnKey": "DL_ZZ0S2BLNR",
                                        "index": 15
                                    },
                                    {
                                        "columnKey": "SO_F_DGLTP",
                                        "index": 16
                                    },
                                    {
                                        "columnKey": "DL_CHARG",
                                        "index": 17
                                    },
                                    {
                                        "columnKey": "SO_FAKSP",
                                        "index": 18
                                    },
                                    {
                                        "columnKey": "BL_VBELN_INV_LAST",
                                        "index": 19
                                    },
                                    {
                                        "columnKey": "BL_VBELN_INV_FIRST",
                                        "index": 20
                                    },
                                    {
                                        "columnKey": "BL_POSNR_INV_FIRST",
                                        "index": 21
                                    },
                                    {
                                        "columnKey": "BL_POSNR_INV_LAST",
                                        "index": 22
                                    },
                                    {
                                        "columnKey": "TM_AR_DATE",
                                        "index": 23
                                    },
                                    {
                                        "columnKey": "SO_CO_PARTNER",
                                        "index": 24
                                    },
                                    {
                                        "columnKey": "SO_EDATU_CONFIRMED",
                                        "visible": false,
                                        "index": 25
                                    },
                                    {
                                        "columnKey": "SO_KBMENG",
                                        "visible": false,
                                        "index": 26
                                    },
                                    {
                                        "columnKey": "DL_TRAID",
                                        "index": 27
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ORDER",
                                        "index": 28
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ITEM",
                                        "visible": false,
                                        "index": 29
                                    },
                                    {
                                        "columnKey": "SO_ZZ0S2REVG2",
                                        "index": 30
                                    },
                                    {
                                        "columnKey": "SO_KDMAT",
                                        "visible": false,
                                        "index": 31
                                    },
                                    {
                                        "columnKey": "SO_KNREF_HEAD",
                                        "index": 32
                                    },
                                    {
                                        "columnKey": "DL_LFIMG",
                                        "index": 33
                                    },
                                    {
                                        "columnKey": "DL_LFART",
                                        "index": 34
                                    },
                                    {
                                        "columnKey": "SO_DEV_CONF_DATE",
                                        "index": 35
                                    },
                                    {
                                        "columnKey": "SO_VTWEG",
                                        "visible": false,
                                        "index": 36
                                    },
                                    {
                                        "columnKey": "SO_DUE_DATE",
                                        "visible": false,
                                        "index": 37
                                    },
                                    {
                                        "columnKey": "SO_EMAIL_SENT_ON",
                                        "index": 38
                                    },
                                    {
                                        "columnKey": "TM_DPTEN",
                                        "visible": false,
                                        "index": 39
                                    },
                                    {
                                        "columnKey": "TM_DPTBG",
                                        "visible": false,
                                        "index": 40
                                    },
                                    {
                                        "columnKey": "SO_F_VBELN",
                                        "index": 41
                                    },
                                    {
                                        "columnKey": "SO_I_VBELN",
                                        "index": 42
                                    },
                                    {
                                        "columnKey": "TM_TDLNR",
                                        "visible": false,
                                        "index": 43
                                    },
                                    {
                                        "columnKey": "SO_REQ_TEXT",
                                        "index": 44
                                    },
                                    {
                                        "columnKey": "SO_EMAIL_SEND_DATE_F",
                                        "index": 45
                                    },
                                    {
                                        "columnKey": "SO_VBUND",
                                        "index": 46
                                    },
                                    {
                                        "columnKey": "SO_GUSCON_LEVEL",
                                        "index": 47
                                    },
                                    {
                                        "columnKey": "SO_HTEXT",
                                        "index": 48
                                    },
                                    {
                                        "columnKey": "SO_INCO1",
                                        "index": 49
                                    },
                                    {
                                        "columnKey": "SO_INCO2",
                                        "index": 50
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "index": 51
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION_ITEM",
                                        "index": 52
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "visible": false,
                                        "index": 53
                                    },
                                    {
                                        "columnKey": "SO_PSTYV",
                                        "index": 54
                                    },
                                    {
                                        "columnKey": "SO_F_PSMNG",
                                        "index": 55
                                    },
                                    {
                                        "columnKey": "SO_BASF_LOFCR",
                                        "index": 56
                                    },
                                    {
                                        "columnKey": "LAST_NOTE",
                                        "index": 57
                                    },
                                    {
                                        "columnKey": "SO_FOLLOWUP_NOTES_LANG",
                                        "index": 58
                                    },
                                    {
                                        "columnKey": "SO_LEVEL_TYPE",
                                        "index": 59
                                    },
                                    {
                                        "columnKey": "SO_F_LDDAT",
                                        "visible": false,
                                        "index": 60
                                    },
                                    {
                                        "columnKey": "SO_MATNR",
                                        "visible": false,
                                        "index": 61
                                    },
                                    {
                                        "columnKey": "SO_DISPO",
                                        "index": 62
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 63
                                    },
                                    {
                                        "columnKey": "SO_N_VBELN",
                                        "index": 64
                                    },
                                    {
                                        "columnKey": "SO_NPS",
                                        "visible": false,
                                        "index": 65
                                    },
                                    {
                                        "columnKey": "BL_XBLNR",
                                        "index": 66
                                    },
                                    {
                                        "columnKey": "SO_NY_PARTNER",
                                        "index": 67
                                    },
                                    {
                                        "columnKey": "TM_STTRG",
                                        "index": 68
                                    },
                                    {
                                        "columnKey": "SO_ZTERM",
                                        "index": 69
                                    },
                                    {
                                        "columnKey": "DL_PEND_DEL_QUAN",
                                        "index": 70
                                    },
                                    {
                                        "columnKey": "DL_LFDAT",
                                        "index": 71
                                    },
                                    {
                                        "columnKey": "DL_WADAT",
                                        "index": 72
                                    },
                                    {
                                        "columnKey": "SO_WERKS",
                                        "visible": false,
                                        "index": 73
                                    },
                                    {
                                        "columnKey": "SO_F_WERKS",
                                        "index": 74
                                    },
                                    {
                                        "columnKey": "SO_BSARK",
                                        "index": 75
                                    },
                                    {
                                        "columnKey": "SO_F_VKORG",
                                        "index": 76
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 77
                                    },
                                    {
                                        "columnKey": "SO_PRSDT",
                                        "index": 78
                                    },
                                    {
                                        "columnKey": "SO_KOSCH",
                                        "index": 80
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_04_LANG",
                                        "index": 81
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_03_LANG",
                                        "index": 82
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_01_LANG",
                                        "index": 83
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_05_LANG",
                                        "index": 84
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_02_LANG",
                                        "index": 85
                                    },
                                    {
                                        "columnKey": "SO_ABGRU",
                                        "index": 86
                                    },
                                    {
                                        "columnKey": "SO_EDATU_REQUESTED",
                                        "visible": false,
                                        "index": 87
                                    },
                                    {
                                        "columnKey": "SO_KWMENG",
                                        "visible": false,
                                        "index": 88
                                    },
                                    {
                                        "columnKey": "SO_ROUTE",
                                        "visible": false,
                                        "index": 89
                                    },
                                    {
                                        "columnKey": "SO_VKGRP",
                                        "index": 90
                                    },
                                    {
                                        "columnKey": "SO_VKBUR",
                                        "index": 91
                                    },
                                    {
                                        "columnKey": "SO_VKORG",
                                        "visible": false,
                                        "index": 92
                                    },
                                    {
                                        "columnKey": "SO_ZZDKPPRODB",
                                        "visible": false,
                                        "index": 93
                                    },
                                    {
                                        "columnKey": "SO_WE_PARTNER",
                                        "index": 94
                                    },
                                    {
                                        "columnKey": "SO_ORT01",
                                        "visible": false,
                                        "index": 95
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "visible": false,
                                        "index": 96
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 97
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "visible": false,
                                        "index": 98
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "visible": false,
                                        "index": 99
                                    },
                                    {
                                        "columnKey": "SO_F_VSBED",
                                        "index": 100
                                    },
                                    {
                                        "columnKey": "TM_VSART",
                                        "index": 101
                                    },
                                    {
                                        "columnKey": "SO_AG_PARTNER",
                                        "index": 102
                                    },
                                    {
                                        "columnKey": "SO_F_LGORT",
                                        "index": 103
                                    },
                                    {
                                        "columnKey": "SO_SUPPLY_SITUATION",
                                        "index": 104
                                    },
                                    {
                                        "columnKey": "SO_TRAGR",
                                        "index": 105
                                    },
                                    {
                                        "columnKey": "SO_F_TDDAT",
                                        "index": 106
                                    },
                                    {
                                        "columnKey": "SO_UNCONFIRMED_QTY",
                                        "index": 107
                                    },
                                    {
                                        "columnKey": "SO_VE_PARTNER",
                                        "index": 108
                                    },
                                    {
                                        "columnKey": "TM_EXTI1",
                                        "index": 109
                                    }
                                ]
                            }
                        },
                        "nps10Key": {
                            "executeOnSelection": false
                        },
                        "nps20Key": {
                            "executeOnSelection": false
                        },
                        "nps30Key": {
                            "executeOnSelection": false
                        },
                        "nps40Key": {
                            "executeOnSelection": false
                        },
                        "nps50Key": {
                            "executeOnSelection": false
                        },
                        "nps60Key": {
                            "executeOnSelection": false
                        },
                        "nps70Key": {
                            "executeOnSelection": false
                        },
                        "nps80Key": {
                            "executeOnSelection": false
                        },
                        "nps90Key": {
                            "executeOnSelection": false
                        },
                        "nps95Key": {
                            "executeOnSelection": false
                        },
                        "nps99Key": {
                            "executeOnSelection": false
                        },
                        "nps00Key": {
                            "executeOnSelection": false
                        },
                        "filterBarKey": {
                            "version": "V3",
                            "filterbar": [
                                {
                                    "group": "allIssues",
                                    "name": "SO_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ORDER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AUART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_MATNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KDMAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LAND1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ORT01",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_CO_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NY_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VE_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AM_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KNREF_HEAD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VBUND",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KWMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EDATU_CONFIRMED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_UNCONFIRMED_QTY",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REQ_TEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FAKSP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_SUPPLY_SITUATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBETR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NETWR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_HTEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PSTYV",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DISPO",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KOSCH",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKBUR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ABGRU",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZTERM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PRSDT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZ0S2REVG2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZDKPPRODB",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSARK",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BASF_LOFCR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_GUSCON_LEVEL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_I_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LEVEL_TYPE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_N_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSTKD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_TRAGR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKGRP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ROUTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VKORG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LGORT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_TDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_ZZ0S2MATUG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AUFNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_DGLTP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_PSMNG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VSBED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "LAST_NOTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_CHARG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFIMG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_TRAID",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_ZZ0S2BLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_PEND_DEL_QUAN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT_IST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TKNUM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_VSART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_EXTI1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_AR_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TDLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ALERT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_STTRG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NPS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DUE_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ETA_UPDATED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_XBLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FOLLOWUP_NOTES_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_01_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_02_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_03_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_04_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_05_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DEV_CONF_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SEND_DATE_F",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SENT_ON",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_CURRENT_STATUS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                }
                            ],
                            "orderedFilterItems": "[{\"name\":\"SO_VBELN\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VKORG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VTWEG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_EDATU_REQUESTED\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_AG_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_WE_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"criticalityDueDate\",\"group\":\"__$INTERNAL$\"},{\"name\":\"shipmentEtaUpdated\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_ISSUE\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_POSNR\",\"group\":\"allIssues\"},{\"name\":\"SO_ERDAT_ORDER\",\"group\":\"allIssues\"},{\"name\":\"SO_ERDAT_ITEM\",\"group\":\"allIssues\"},{\"name\":\"SO_AUART\",\"group\":\"allIssues\"},{\"name\":\"SO_WERKS\",\"group\":\"allIssues\"},{\"name\":\"SO_MATNR\",\"group\":\"allIssues\"},{\"name\":\"SO_KDMAT\",\"group\":\"allIssues\"},{\"name\":\"SO_LAND1\",\"group\":\"allIssues\"},{\"name\":\"SO_ORT01\",\"group\":\"allIssues\"},{\"name\":\"SO_CO_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_NY_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_AS_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_VE_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_AM_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_KNREF_HEAD\",\"group\":\"allIssues\"},{\"name\":\"SO_VBUND\",\"group\":\"allIssues\"},{\"name\":\"SO_KWMENG\",\"group\":\"allIssues\"},{\"name\":\"SO_EDATU_CONFIRMED\",\"group\":\"allIssues\"},{\"name\":\"SO_KBMENG\",\"group\":\"allIssues\"},{\"name\":\"SO_UNCONFIRMED_QTY\",\"group\":\"allIssues\"},{\"name\":\"SO_REQ_TEXT\",\"group\":\"allIssues\"},{\"name\":\"SO_FAKSP\",\"group\":\"allIssues\"},{\"name\":\"SO_SUPPLY_SITUATION\",\"group\":\"allIssues\"},{\"name\":\"SO_KBETR\",\"group\":\"allIssues\"},{\"name\":\"SO_NETWR\",\"group\":\"allIssues\"},{\"name\":\"SO_HTEXT\",\"group\":\"allIssues\"},{\"name\":\"SO_PSTYV\",\"group\":\"allIssues\"},{\"name\":\"SO_DISPO\",\"group\":\"allIssues\"},{\"name\":\"SO_KOSCH\",\"group\":\"allIssues\"},{\"name\":\"SO_VKBUR\",\"group\":\"allIssues\"},{\"name\":\"SO_ABGRU\",\"group\":\"allIssues\"},{\"name\":\"SO_INCO1\",\"group\":\"allIssues\"},{\"name\":\"SO_INCO2\",\"group\":\"allIssues\"},{\"name\":\"SO_ZTERM\",\"group\":\"allIssues\"},{\"name\":\"SO_PRSDT\",\"group\":\"allIssues\"},{\"name\":\"SO_ZZ0S2REVG2\",\"group\":\"allIssues\"},{\"name\":\"SO_ZZDKPPRODB\",\"group\":\"allIssues\"},{\"name\":\"SO_BSARK\",\"group\":\"allIssues\"},{\"name\":\"SO_BASF_LOFCR\",\"group\":\"allIssues\"},{\"name\":\"SO_GUSCON_LEVEL\",\"group\":\"allIssues\"},{\"name\":\"SO_I_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_LEVEL_TYPE\",\"group\":\"allIssues\"},{\"name\":\"SO_N_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_BSTKD\",\"group\":\"allIssues\"},{\"name\":\"SO_TRAGR\",\"group\":\"allIssues\"},{\"name\":\"SO_VKGRP\",\"group\":\"allIssues\"},{\"name\":\"SO_ROUTE\",\"group\":\"allIssues\"},{\"name\":\"SO_F_WERKS\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VKORG\",\"group\":\"allIssues\"},{\"name\":\"SO_F_AS_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_F_LDDAT\",\"group\":\"allIssues\"},{\"name\":\"SO_F_LGORT\",\"group\":\"allIssues\"},{\"name\":\"SO_F_TDDAT\",\"group\":\"allIssues\"},{\"name\":\"SO_F_ZZ0S2MATUG\",\"group\":\"allIssues\"},{\"name\":\"SO_F_AUFNR\",\"group\":\"allIssues\"},{\"name\":\"SO_F_DGLTP\",\"group\":\"allIssues\"},{\"name\":\"SO_F_PSMNG\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VSBED\",\"group\":\"allIssues\"},{\"name\":\"LAST_NOTE\",\"group\":\"allIssues\"},{\"name\":\"DL_VBELN\",\"group\":\"allIssues\"},{\"name\":\"DL_POSNR\",\"group\":\"allIssues\"},{\"name\":\"DL_CHARG\",\"group\":\"allIssues\"},{\"name\":\"DL_LFIMG\",\"group\":\"allIssues\"},{\"name\":\"DL_LFART\",\"group\":\"allIssues\"},{\"name\":\"DL_LFDAT\",\"group\":\"allIssues\"},{\"name\":\"DL_TRAID\",\"group\":\"allIssues\"},{\"name\":\"DL_ZZ0S2BLNR\",\"group\":\"allIssues\"},{\"name\":\"DL_PEND_DEL_QUAN\",\"group\":\"allIssues\"},{\"name\":\"DL_WADAT\",\"group\":\"allIssues\"},{\"name\":\"DL_WADAT_IST\",\"group\":\"allIssues\"},{\"name\":\"TM_TKNUM\",\"group\":\"allIssues\"},{\"name\":\"TM_VSART\",\"group\":\"allIssues\"},{\"name\":\"TM_EXTI1\",\"group\":\"allIssues\"},{\"name\":\"TM_DPTBG\",\"group\":\"allIssues\"},{\"name\":\"TM_DATBG\",\"group\":\"allIssues\"},{\"name\":\"TM_DPTEN\",\"group\":\"allIssues\"},{\"name\":\"TM_DATEN\",\"group\":\"allIssues\"},{\"name\":\"TM_AR_DATE\",\"group\":\"allIssues\"},{\"name\":\"TM_TDLNR\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_ALERT\",\"group\":\"allIssues\"},{\"name\":\"TM_STTRG\",\"group\":\"allIssues\"},{\"name\":\"SO_NPS\",\"group\":\"allIssues\"},{\"name\":\"SO_DUE_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_ISSUE_LOCATION\",\"group\":\"allIssues\"},{\"name\":\"SO_ISSUE_LOCATION_ITEM\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_ETA_UPDATED\",\"group\":\"allIssues\"},{\"name\":\"BL_VBELN_INV_FIRST\",\"group\":\"allIssues\"},{\"name\":\"BL_VBELN_INV_LAST\",\"group\":\"allIssues\"},{\"name\":\"BL_XBLNR\",\"group\":\"allIssues\"},{\"name\":\"BL_POSNR_INV_LAST\",\"group\":\"allIssues\"},{\"name\":\"BL_POSNR_INV_FIRST\",\"group\":\"allIssues\"},{\"name\":\"SO_FOLLOWUP_NOTES_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_01_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_02_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_03_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_04_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_05_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_DEV_CONF_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL_SEND_DATE_F\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL_SENT_ON\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_CURRENT_STATUS\",\"group\":\"allIssues\"}]",
                            "filterBarVariant": "{\"SO_EDATU_REQUESTED\":{\"conditionTypeInfo\":{\"name\":\"sap.ui.comp.config.condition.DateRangeType\",\"data\":{\"operation\":\"TODAY\",\"value1\":null,\"value2\":null,\"key\":\"SO_EDATU_REQUESTED\",\"calendarType\":\"Gregorian\"}},\"ranges\":[{\"operation\":\"BT\",\"value1\":\"2024-07-22T00:00:00.000\",\"value2\":\"2024-07-22T23:59:59.999\",\"exclude\":false,\"keyField\":\"SO_EDATU_REQUESTED\",\"tokenText\":null}],\"items\":[]},\"_CUSTOM\":{\"soIssue\":\"[]\",\"soNps\":\"[]\",\"shipmentEta\":\"\",\"soDueDate\":\"red\"}}",
                            "singleInputsTextArrangementData": "{}"
                        }
                    },
                    "texts": {
                        "variantName": {
                            "value": "Testing Columns",
                            "type": "XFLD"
                        }
                    },
                    "favorite": true,
                    "executeOnSelection": false,
                    "contexts": {},
                    "selector": {
                        "persistencyKey": "pageVariantKey"
                    },
                    "standardVariant": false,
                    "variantId": "id_1721655719463_306_page"
                },
                {
                    "changeType": "page",
                    "reference": "ordermonitoring.openorders",
                    "namespace": "apps/ordermonitoring.openorders/changes/",
                    "projectId": "ordermonitoring.openorders",
                    "support": {
                        "generator": "FlexObjectFactory.createCompVariant",
                        "user": "GIFONNVD"
                    },
                    "originalLanguage": "EN",
                    "layer": "CUSTOMER",
                    "fileType": "variant",
                    "fileName": "id_1721658904977_243_page",
                    "content": {
                        "allIssuesKey": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_FAKSP",
                                        "visible": true,
                                        "index": 0,
                                        "width": "112.44px"
                                    },
                                    {
                                        "columnKey": "SO_LAND1",
                                        "index": 1
                                    },
                                    {
                                        "columnKey": "DL_POSNR",
                                        "index": 4
                                    },
                                    {
                                        "columnKey": "SO_POSNR",
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "DL_ZZ0S2BLNR",
                                        "visible": true,
                                        "index": 9,
                                        "width": "130.12px"
                                    },
                                    {
                                        "columnKey": "SO_VBELN",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "SO_BSTKD",
                                        "visible": true,
                                        "index": 12,
                                        "width": "151.32px"
                                    },
                                    {
                                        "columnKey": "SO_AUART",
                                        "visible": true,
                                        "index": 14
                                    },
                                    {
                                        "columnKey": "SO_F_ZZ0S2MATUG",
                                        "visible": true,
                                        "index": 15
                                    },
                                    {
                                        "columnKey": "SO_AM_PARTNER",
                                        "visible": true,
                                        "index": 17
                                    },
                                    {
                                        "columnKey": "TM_DATBG",
                                        "index": 18
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "visible": true,
                                        "index": 20
                                    },
                                    {
                                        "columnKey": "SO_F_DGLTP",
                                        "visible": true,
                                        "index": 22
                                    },
                                    {
                                        "columnKey": "DL_CHARG",
                                        "visible": true,
                                        "index": 23
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "index": 25
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "index": 2
                                    },
                                    {
                                        "columnKey": "SO_DUE_DATE",
                                        "visible": false,
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_NPS",
                                        "visible": false,
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "visible": false,
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 13
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ITEM",
                                        "visible": false,
                                        "index": 16
                                    },
                                    {
                                        "columnKey": "SO_ORT01",
                                        "visible": false,
                                        "index": 19
                                    },
                                    {
                                        "columnKey": "SO_WERKS",
                                        "visible": false,
                                        "index": 21
                                    },
                                    {
                                        "columnKey": "SO_MATNR",
                                        "visible": false,
                                        "index": 24
                                    },
                                    {
                                        "columnKey": "SO_KDMAT",
                                        "visible": false,
                                        "index": 26
                                    },
                                    {
                                        "columnKey": "SO_EDATU_REQUESTED",
                                        "visible": false,
                                        "index": 27
                                    },
                                    {
                                        "columnKey": "SO_EDATU_CONFIRMED",
                                        "visible": false,
                                        "index": 28
                                    },
                                    {
                                        "columnKey": "SO_ZZDKPPRODB",
                                        "visible": false,
                                        "index": 29
                                    },
                                    {
                                        "columnKey": "DL_WADAT_IST",
                                        "visible": false,
                                        "index": 30
                                    },
                                    {
                                        "columnKey": "TM_TDLNR",
                                        "visible": false,
                                        "index": 31
                                    },
                                    {
                                        "columnKey": "SO_VKORG",
                                        "visible": false,
                                        "index": 32
                                    },
                                    {
                                        "columnKey": "SO_VTWEG",
                                        "visible": false,
                                        "index": 33
                                    },
                                    {
                                        "columnKey": "SO_KWMENG",
                                        "visible": false,
                                        "index": 34
                                    },
                                    {
                                        "columnKey": "SO_KBMENG",
                                        "visible": false,
                                        "index": 35
                                    },
                                    {
                                        "columnKey": "SO_ROUTE",
                                        "visible": false,
                                        "index": 36
                                    },
                                    {
                                        "columnKey": "SO_F_LDDAT",
                                        "visible": false,
                                        "index": 37
                                    },
                                    {
                                        "columnKey": "TM_DPTBG",
                                        "visible": false,
                                        "index": 38
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "visible": false,
                                        "index": 39
                                    },
                                    {
                                        "columnKey": "TM_DPTEN",
                                        "visible": false,
                                        "index": 40
                                    },
                                    {
                                        "columnKey": "TM_DATEN",
                                        "visible": false,
                                        "index": 41
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 42
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "visible": false,
                                        "index": 43
                                    },
                                    {
                                        "columnKey": "SO_ZZ0S2REVG2",
                                        "index": 44
                                    },
                                    {
                                        "columnKey": "SO_I_VBELN",
                                        "index": 45
                                    },
                                    {
                                        "columnKey": "SO_N_VBELN",
                                        "index": 46
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ORDER",
                                        "index": 47
                                    },
                                    {
                                        "columnKey": "SO_AG_PARTNER",
                                        "index": 48
                                    },
                                    {
                                        "columnKey": "SO_WE_PARTNER",
                                        "index": 49
                                    },
                                    {
                                        "columnKey": "SO_CO_PARTNER",
                                        "index": 50
                                    },
                                    {
                                        "columnKey": "SO_NY_PARTNER",
                                        "index": 51
                                    },
                                    {
                                        "columnKey": "SO_AS_PARTNER",
                                        "index": 52
                                    },
                                    {
                                        "columnKey": "SO_VE_PARTNER",
                                        "index": 53
                                    },
                                    {
                                        "columnKey": "SO_KNREF_HEAD",
                                        "index": 54
                                    },
                                    {
                                        "columnKey": "SO_VBUND",
                                        "index": 55
                                    },
                                    {
                                        "columnKey": "SO_UNCONFIRMED_QTY",
                                        "index": 56
                                    },
                                    {
                                        "columnKey": "SO_REQ_TEXT",
                                        "index": 57
                                    },
                                    {
                                        "columnKey": "SO_SUPPLY_SITUATION",
                                        "index": 58
                                    },
                                    {
                                        "columnKey": "SO_HTEXT",
                                        "index": 59
                                    },
                                    {
                                        "columnKey": "SO_PSTYV",
                                        "index": 60
                                    },
                                    {
                                        "columnKey": "SO_DISPO",
                                        "index": 61
                                    },
                                    {
                                        "columnKey": "SO_KOSCH",
                                        "index": 62
                                    },
                                    {
                                        "columnKey": "SO_VKBUR",
                                        "index": 63
                                    },
                                    {
                                        "columnKey": "SO_ABGRU",
                                        "index": 64
                                    },
                                    {
                                        "columnKey": "SO_INCO1",
                                        "index": 65
                                    },
                                    {
                                        "columnKey": "SO_INCO2",
                                        "index": 66
                                    },
                                    {
                                        "columnKey": "SO_ZTERM",
                                        "index": 67
                                    },
                                    {
                                        "columnKey": "SO_PRSDT",
                                        "index": 68
                                    },
                                    {
                                        "columnKey": "SO_BSARK",
                                        "index": 69
                                    },
                                    {
                                        "columnKey": "SO_BASF_LOFCR",
                                        "index": 70
                                    },
                                    {
                                        "columnKey": "SO_GUSCON_LEVEL",
                                        "index": 71
                                    },
                                    {
                                        "columnKey": "SO_LEVEL_TYPE",
                                        "index": 72
                                    },
                                    {
                                        "columnKey": "SO_F_VBELN",
                                        "index": 73
                                    },
                                    {
                                        "columnKey": "SO_TRAGR",
                                        "index": 74
                                    },
                                    {
                                        "columnKey": "SO_VKGRP",
                                        "index": 75
                                    },
                                    {
                                        "columnKey": "SO_F_WERKS",
                                        "index": 76
                                    },
                                    {
                                        "columnKey": "SO_F_VKORG",
                                        "index": 77
                                    },
                                    {
                                        "columnKey": "SO_F_AS_PARTNER",
                                        "index": 78
                                    },
                                    {
                                        "columnKey": "SO_F_LGORT",
                                        "index": 79
                                    },
                                    {
                                        "columnKey": "SO_F_TDDAT",
                                        "index": 80
                                    },
                                    {
                                        "columnKey": "SO_F_AUFNR",
                                        "index": 81
                                    },
                                    {
                                        "columnKey": "SO_F_PSMNG",
                                        "index": 82
                                    },
                                    {
                                        "columnKey": "SO_F_VSBED",
                                        "index": 83
                                    },
                                    {
                                        "columnKey": "LAST_NOTE",
                                        "index": 84
                                    },
                                    {
                                        "columnKey": "DL_LFIMG",
                                        "index": 85
                                    },
                                    {
                                        "columnKey": "DL_LFART",
                                        "index": 86
                                    },
                                    {
                                        "columnKey": "DL_LFDAT",
                                        "index": 87
                                    },
                                    {
                                        "columnKey": "DL_TRAID",
                                        "index": 88
                                    }
                                ]
                            },
                            "sort": {
                                "sortItems": [
                                    {
                                        "columnKey": "DL_VBELN",
                                        "operation": "Descending"
                                    }
                                ]
                            }
                        },
                        "nps10Key": {
                            "executeOnSelection": false
                        },
                        "nps20Key": {
                            "executeOnSelection": false
                        },
                        "nps30Key": {
                            "executeOnSelection": false
                        },
                        "nps40Key": {
                            "executeOnSelection": false
                        },
                        "nps50Key": {
                            "executeOnSelection": false
                        },
                        "nps60Key": {
                            "executeOnSelection": false
                        },
                        "nps70Key": {
                            "executeOnSelection": false
                        },
                        "nps80Key": {
                            "executeOnSelection": false
                        },
                        "nps90Key": {
                            "executeOnSelection": false
                        },
                        "nps95Key": {
                            "executeOnSelection": false
                        },
                        "nps99Key": {
                            "executeOnSelection": false
                        },
                        "nps00Key": {
                            "executeOnSelection": false
                        },
                        "filterBarKey": {
                            "version": "V3",
                            "filterbar": [
                                {
                                    "group": "allIssues",
                                    "name": "SO_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ORDER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AUART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_MATNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KDMAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LAND1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ORT01",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_CO_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NY_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VE_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AM_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KNREF_HEAD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VBUND",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KWMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EDATU_CONFIRMED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_UNCONFIRMED_QTY",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REQ_TEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FAKSP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_SUPPLY_SITUATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBETR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NETWR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_HTEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PSTYV",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DISPO",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KOSCH",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKBUR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ABGRU",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZTERM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PRSDT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZ0S2REVG2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZDKPPRODB",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSARK",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BASF_LOFCR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_GUSCON_LEVEL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_I_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LEVEL_TYPE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_N_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSTKD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_TRAGR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKGRP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ROUTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VKORG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LGORT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_TDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_ZZ0S2MATUG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AUFNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_DGLTP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_PSMNG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VSBED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "LAST_NOTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_CHARG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFIMG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_TRAID",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_ZZ0S2BLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_PEND_DEL_QUAN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT_IST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TKNUM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_VSART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_EXTI1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_AR_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TDLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ALERT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_STTRG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NPS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DUE_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ETA_UPDATED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_XBLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FOLLOWUP_NOTES_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_01_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_02_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_03_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_04_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_05_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DEV_CONF_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SEND_DATE_F",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SENT_ON",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_CURRENT_STATUS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                }
                            ],
                            "orderedFilterItems": "[{\"name\":\"SO_VBELN\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VKORG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VTWEG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_EDATU_REQUESTED\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_AG_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_WE_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"criticalityDueDate\",\"group\":\"__$INTERNAL$\"},{\"name\":\"shipmentEtaUpdated\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_ISSUE\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_POSNR\",\"group\":\"allIssues\"},{\"name\":\"SO_ERDAT_ORDER\",\"group\":\"allIssues\"},{\"name\":\"SO_ERDAT_ITEM\",\"group\":\"allIssues\"},{\"name\":\"SO_AUART\",\"group\":\"allIssues\"},{\"name\":\"SO_WERKS\",\"group\":\"allIssues\"},{\"name\":\"SO_MATNR\",\"group\":\"allIssues\"},{\"name\":\"SO_KDMAT\",\"group\":\"allIssues\"},{\"name\":\"SO_LAND1\",\"group\":\"allIssues\"},{\"name\":\"SO_ORT01\",\"group\":\"allIssues\"},{\"name\":\"SO_CO_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_NY_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_AS_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_VE_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_AM_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_KNREF_HEAD\",\"group\":\"allIssues\"},{\"name\":\"SO_VBUND\",\"group\":\"allIssues\"},{\"name\":\"SO_KWMENG\",\"group\":\"allIssues\"},{\"name\":\"SO_EDATU_CONFIRMED\",\"group\":\"allIssues\"},{\"name\":\"SO_KBMENG\",\"group\":\"allIssues\"},{\"name\":\"SO_UNCONFIRMED_QTY\",\"group\":\"allIssues\"},{\"name\":\"SO_REQ_TEXT\",\"group\":\"allIssues\"},{\"name\":\"SO_FAKSP\",\"group\":\"allIssues\"},{\"name\":\"SO_SUPPLY_SITUATION\",\"group\":\"allIssues\"},{\"name\":\"SO_KBETR\",\"group\":\"allIssues\"},{\"name\":\"SO_NETWR\",\"group\":\"allIssues\"},{\"name\":\"SO_HTEXT\",\"group\":\"allIssues\"},{\"name\":\"SO_PSTYV\",\"group\":\"allIssues\"},{\"name\":\"SO_DISPO\",\"group\":\"allIssues\"},{\"name\":\"SO_KOSCH\",\"group\":\"allIssues\"},{\"name\":\"SO_VKBUR\",\"group\":\"allIssues\"},{\"name\":\"SO_ABGRU\",\"group\":\"allIssues\"},{\"name\":\"SO_INCO1\",\"group\":\"allIssues\"},{\"name\":\"SO_INCO2\",\"group\":\"allIssues\"},{\"name\":\"SO_ZTERM\",\"group\":\"allIssues\"},{\"name\":\"SO_PRSDT\",\"group\":\"allIssues\"},{\"name\":\"SO_ZZ0S2REVG2\",\"group\":\"allIssues\"},{\"name\":\"SO_ZZDKPPRODB\",\"group\":\"allIssues\"},{\"name\":\"SO_BSARK\",\"group\":\"allIssues\"},{\"name\":\"SO_BASF_LOFCR\",\"group\":\"allIssues\"},{\"name\":\"SO_GUSCON_LEVEL\",\"group\":\"allIssues\"},{\"name\":\"SO_I_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_LEVEL_TYPE\",\"group\":\"allIssues\"},{\"name\":\"SO_N_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_BSTKD\",\"group\":\"allIssues\"},{\"name\":\"SO_TRAGR\",\"group\":\"allIssues\"},{\"name\":\"SO_VKGRP\",\"group\":\"allIssues\"},{\"name\":\"SO_ROUTE\",\"group\":\"allIssues\"},{\"name\":\"SO_F_WERKS\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VKORG\",\"group\":\"allIssues\"},{\"name\":\"SO_F_AS_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_F_LDDAT\",\"group\":\"allIssues\"},{\"name\":\"SO_F_LGORT\",\"group\":\"allIssues\"},{\"name\":\"SO_F_TDDAT\",\"group\":\"allIssues\"},{\"name\":\"SO_F_ZZ0S2MATUG\",\"group\":\"allIssues\"},{\"name\":\"SO_F_AUFNR\",\"group\":\"allIssues\"},{\"name\":\"SO_F_DGLTP\",\"group\":\"allIssues\"},{\"name\":\"SO_F_PSMNG\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VSBED\",\"group\":\"allIssues\"},{\"name\":\"LAST_NOTE\",\"group\":\"allIssues\"},{\"name\":\"DL_VBELN\",\"group\":\"allIssues\"},{\"name\":\"DL_POSNR\",\"group\":\"allIssues\"},{\"name\":\"DL_CHARG\",\"group\":\"allIssues\"},{\"name\":\"DL_LFIMG\",\"group\":\"allIssues\"},{\"name\":\"DL_LFART\",\"group\":\"allIssues\"},{\"name\":\"DL_LFDAT\",\"group\":\"allIssues\"},{\"name\":\"DL_TRAID\",\"group\":\"allIssues\"},{\"name\":\"DL_ZZ0S2BLNR\",\"group\":\"allIssues\"},{\"name\":\"DL_PEND_DEL_QUAN\",\"group\":\"allIssues\"},{\"name\":\"DL_WADAT\",\"group\":\"allIssues\"},{\"name\":\"DL_WADAT_IST\",\"group\":\"allIssues\"},{\"name\":\"TM_TKNUM\",\"group\":\"allIssues\"},{\"name\":\"TM_VSART\",\"group\":\"allIssues\"},{\"name\":\"TM_EXTI1\",\"group\":\"allIssues\"},{\"name\":\"TM_DPTBG\",\"group\":\"allIssues\"},{\"name\":\"TM_DATBG\",\"group\":\"allIssues\"},{\"name\":\"TM_DPTEN\",\"group\":\"allIssues\"},{\"name\":\"TM_DATEN\",\"group\":\"allIssues\"},{\"name\":\"TM_AR_DATE\",\"group\":\"allIssues\"},{\"name\":\"TM_TDLNR\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_ALERT\",\"group\":\"allIssues\"},{\"name\":\"TM_STTRG\",\"group\":\"allIssues\"},{\"name\":\"SO_NPS\",\"group\":\"allIssues\"},{\"name\":\"SO_DUE_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_ISSUE_LOCATION\",\"group\":\"allIssues\"},{\"name\":\"SO_ISSUE_LOCATION_ITEM\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_ETA_UPDATED\",\"group\":\"allIssues\"},{\"name\":\"BL_VBELN_INV_FIRST\",\"group\":\"allIssues\"},{\"name\":\"BL_VBELN_INV_LAST\",\"group\":\"allIssues\"},{\"name\":\"BL_XBLNR\",\"group\":\"allIssues\"},{\"name\":\"BL_POSNR_INV_LAST\",\"group\":\"allIssues\"},{\"name\":\"BL_POSNR_INV_FIRST\",\"group\":\"allIssues\"},{\"name\":\"SO_FOLLOWUP_NOTES_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_01_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_02_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_03_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_04_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_05_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_DEV_CONF_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL_SEND_DATE_F\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL_SENT_ON\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_CURRENT_STATUS\",\"group\":\"allIssues\"}]",
                            "filterBarVariant": "{\"SO_EDATU_REQUESTED\":{\"conditionTypeInfo\":{\"name\":\"sap.ui.comp.config.condition.DateRangeType\",\"data\":{\"operation\":\"TODAY\",\"value1\":null,\"value2\":null,\"key\":\"SO_EDATU_REQUESTED\",\"calendarType\":\"Gregorian\"}},\"ranges\":[{\"operation\":\"BT\",\"value1\":\"2024-07-22T00:00:00.000\",\"value2\":\"2024-07-22T23:59:59.999\",\"exclude\":false,\"keyField\":\"SO_EDATU_REQUESTED\",\"tokenText\":null}],\"items\":[]},\"_CUSTOM\":{\"soIssue\":\"[]\",\"soNps\":\"[]\",\"shipmentEta\":\"\",\"soDueDate\":\"red\"}}",
                            "singleInputsTextArrangementData": "{}"
                        }
                    },
                    "texts": {
                        "variantName": {
                            "value": "testin_col",
                            "type": "XFLD"
                        }
                    },
                    "favorite": true,
                    "executeOnSelection": false,
                    "contexts": {},
                    "selector": {
                        "persistencyKey": "pageVariantKey"
                    },
                    "standardVariant": false,
                    "variantId": "id_1721658904977_243_page",
                    "creation": "2024-07-22T14:35:06.2472090Z"
                },
                {
                    "changeType": "page",
                    "reference": "ordermonitoring.openorders",
                    "namespace": "apps/ordermonitoring.openorders/changes/",
                    "creation": "2024-07-26T07:28:57.8532790Z",
                    "projectId": "ordermonitoring.openorders",
                    "support": {
                        "generator": "FlexObjectFactory.createCompVariant",
                        "user": "RAKSHIP",
                        "sapui5Version": "1.126.0"
                    },
                    "originalLanguage": "EN",
                    "layer": "CUSTOMER",
                    "fileType": "variant",
                    "fileName": "id_1721978936837_2545_page",
                    "content": {
                        "allIssuesKey": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_ERDAT_ORDER",
                                        "index": 41
                                    }
                                ],
                                "fixedColumnCount": 2
                            }
                        },
                        "nps10Key": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_NPS",
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "index": 4
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "SO_AUART",
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "SO_VTWEG",
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "DL_CHARG",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "SO_WERKS",
                                        "index": 9
                                    },
                                    {
                                        "columnKey": "SO_ZZDKPPRODB",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "SO_KDMAT",
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 12
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ORDER",
                                        "index": 13
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ITEM",
                                        "index": 14
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 15
                                    },
                                    {
                                        "columnKey": "SO_MATNR",
                                        "index": 16
                                    },
                                    {
                                        "columnKey": "SO_AG_PARTNER",
                                        "index": 17
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "index": 18
                                    },
                                    {
                                        "columnKey": "SO_EDATU_REQUESTED",
                                        "index": 25
                                    },
                                    {
                                        "columnKey": "SO_KWMENG",
                                        "index": 26
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "index": 27
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "visible": true
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 29
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "index": 30
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 31
                                    }
                                ],
                                "fixedColumnCount": 2
                            }
                        },
                        "nps20Key": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_NPS",
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "index": 4
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "DL_CHARG",
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "SO_WERKS",
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "SO_KDMAT",
                                        "index": 9
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ORDER",
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "index": 12
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "index": 35
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "visible": true
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 37
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "index": 38
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 39
                                    }
                                ],
                                "fixedColumnCount": 2
                            }
                        },
                        "nps30Key": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_NPS",
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "index": 4
                                    },
                                    {
                                        "columnKey": "SO_WERKS",
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "DL_CHARG",
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "SO_KDMAT",
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ORDER",
                                        "index": 9
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ITEM",
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "index": 12
                                    },
                                    {
                                        "columnKey": "SO_AUART",
                                        "index": 13
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "index": 14
                                    },
                                    {
                                        "columnKey": "SO_VTWEG",
                                        "index": 15
                                    },
                                    {
                                        "columnKey": "SO_MATNR",
                                        "index": 16
                                    },
                                    {
                                        "columnKey": "SO_AG_PARTNER",
                                        "index": 17
                                    },
                                    {
                                        "columnKey": "SO_WE_PARTNER",
                                        "index": 18
                                    },
                                    {
                                        "columnKey": "SO_LAND1",
                                        "index": 19
                                    },
                                    {
                                        "columnKey": "SO_ORT01",
                                        "index": 20
                                    },
                                    {
                                        "columnKey": "SO_VKORG",
                                        "index": 21
                                    },
                                    {
                                        "columnKey": "SO_EDATU_REQUESTED",
                                        "index": 22
                                    },
                                    {
                                        "columnKey": "SO_KWMENG",
                                        "index": 23
                                    },
                                    {
                                        "columnKey": "SO_BSTKD",
                                        "index": 24
                                    },
                                    {
                                        "columnKey": "SO_F_WERKS",
                                        "index": 25
                                    },
                                    {
                                        "columnKey": "SO_ZZ0S2REVG2",
                                        "index": 26
                                    },
                                    {
                                        "columnKey": "SO_ZZDKPPRODB",
                                        "index": 27
                                    },
                                    {
                                        "columnKey": "SO_ZTERM",
                                        "index": 28
                                    },
                                    {
                                        "columnKey": "SO_PRSDT",
                                        "index": 29
                                    },
                                    {
                                        "columnKey": "SO_GUSCON_LEVEL",
                                        "index": 30
                                    },
                                    {
                                        "columnKey": "SO_LEVEL_TYPE",
                                        "index": 31
                                    },
                                    {
                                        "columnKey": "SO_F_VBELN",
                                        "index": 32
                                    },
                                    {
                                        "columnKey": "SO_I_VBELN",
                                        "index": 33
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "index": 34
                                    },
                                    {
                                        "columnKey": "SO_N_VBELN",
                                        "index": 35
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "visible": true
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 37
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "index": 38
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 39
                                    }
                                ],
                                "fixedColumnCount": 2
                            }
                        },
                        "nps40Key": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_WERKS",
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_KDMAT",
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "SO_NPS",
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ORDER",
                                        "index": 9
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ITEM",
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "SO_AUART",
                                        "index": 13
                                    },
                                    {
                                        "columnKey": "SO_VTWEG",
                                        "index": 14
                                    },
                                    {
                                        "columnKey": "SO_MATNR",
                                        "index": 15
                                    },
                                    {
                                        "columnKey": "SO_AG_PARTNER",
                                        "index": 16
                                    },
                                    {
                                        "columnKey": "SO_WE_PARTNER",
                                        "index": 17
                                    },
                                    {
                                        "columnKey": "SO_LAND1",
                                        "index": 18
                                    },
                                    {
                                        "columnKey": "SO_ORT01",
                                        "index": 19
                                    },
                                    {
                                        "columnKey": "SO_VKORG",
                                        "index": 20
                                    },
                                    {
                                        "columnKey": "SO_EDATU_CONFIRMED",
                                        "index": 21
                                    },
                                    {
                                        "columnKey": "SO_EDATU_REQUESTED",
                                        "index": 22
                                    },
                                    {
                                        "columnKey": "SO_KWMENG",
                                        "index": 23
                                    },
                                    {
                                        "columnKey": "SO_BSTKD",
                                        "index": 24
                                    },
                                    {
                                        "columnKey": "SO_ZZ0S2REVG2",
                                        "index": 25
                                    },
                                    {
                                        "columnKey": "SO_F_WERKS",
                                        "index": 26
                                    },
                                    {
                                        "columnKey": "SO_ZZDKPPRODB",
                                        "index": 27
                                    },
                                    {
                                        "columnKey": "SO_GUSCON_LEVEL",
                                        "index": 28
                                    },
                                    {
                                        "columnKey": "SO_LEVEL_TYPE",
                                        "index": 29
                                    },
                                    {
                                        "columnKey": "SO_F_VBELN",
                                        "index": 30
                                    },
                                    {
                                        "columnKey": "SO_ZTERM",
                                        "index": 31
                                    },
                                    {
                                        "columnKey": "SO_PRSDT",
                                        "index": 32
                                    },
                                    {
                                        "columnKey": "SO_I_VBELN",
                                        "index": 33
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "index": 34
                                    },
                                    {
                                        "columnKey": "SO_N_VBELN",
                                        "index": 35
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "visible": true,
                                        "index": 36
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "index": 37
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "index": 12
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 38
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "index": 39
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 40
                                    }
                                ],
                                "fixedColumnCount": 2
                            }
                        },
                        "nps50Key": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "index": 4
                                    },
                                    {
                                        "columnKey": "SO_MATNR",
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "DL_CHARG",
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "SO_NPS",
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "SO_WERKS",
                                        "index": 9
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "DL_POSNR",
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "index": 12
                                    },
                                    {
                                        "columnKey": "DL_LFDAT",
                                        "index": 13
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "index": 14
                                    },
                                    {
                                        "columnKey": "SO_EDATU_CONFIRMED",
                                        "index": 15
                                    },
                                    {
                                        "columnKey": "SO_KWMENG",
                                        "index": 16
                                    },
                                    {
                                        "columnKey": "SO_KBMENG",
                                        "index": 17
                                    },
                                    {
                                        "columnKey": "DL_PEND_DEL_QUAN",
                                        "index": 18
                                    },
                                    {
                                        "columnKey": "DL_WADAT",
                                        "index": 19
                                    },
                                    {
                                        "columnKey": "SO_LAND1",
                                        "index": 20
                                    },
                                    {
                                        "columnKey": "SO_ORT01",
                                        "index": 21
                                    },
                                    {
                                        "columnKey": "SO_ROUTE",
                                        "index": 22
                                    },
                                    {
                                        "columnKey": "SO_INCO1",
                                        "index": 23
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "index": 24
                                    },
                                    {
                                        "columnKey": "SO_ZZDKPPRODB",
                                        "index": 25
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "visible": true,
                                        "index": 26
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "index": 27
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 28
                                    }
                                ],
                                "fixedColumnCount": 2
                            }
                        },
                        "nps60Key": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_NPS",
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "index": 4
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "DL_CHARG",
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "SO_MATNR",
                                        "index": 9
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "SO_WERKS",
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "index": 12
                                    },
                                    {
                                        "columnKey": "DL_WADAT",
                                        "index": 23
                                    },
                                    {
                                        "columnKey": "SO_FAKSP",
                                        "index": 24
                                    },
                                    {
                                        "columnKey": "DL_ZZ0S2BLNR",
                                        "index": 25
                                    },
                                    {
                                        "columnKey": "TM_AR_DATE",
                                        "index": 26
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "index": 27
                                    },
                                    {
                                        "columnKey": "DL_POSNR",
                                        "visible": true,
                                        "index": 28
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 29
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "index": 30
                                    }
                                ],
                                "fixedColumnCount": 2
                            }
                        },
                        "nps70Key": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_LAND1",
                                        "index": 14
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 15
                                    },
                                    {
                                        "columnKey": "SO_WE_PARTNER",
                                        "index": 16
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "index": 29
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 30
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "index": 31
                                    },
                                    {
                                        "columnKey": "SO_ZZ0S2REVG2",
                                        "index": 32
                                    },
                                    {
                                        "columnKey": "SO_ROUTE",
                                        "index": 33
                                    },
                                    {
                                        "columnKey": "SO_I_VBELN",
                                        "index": 34
                                    },
                                    {
                                        "columnKey": "SO_N_VBELN",
                                        "index": 35
                                    }
                                ],
                                "fixedColumnCount": 2
                            }
                        },
                        "nps80Key": {},
                        "nps90Key": {},
                        "nps95Key": {},
                        "nps99Key": {},
                        "nps00Key": {},
                        "filterBarKey": {
                            "version": "V3",
                            "filterbar": [
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT_IST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_ZZ0S2MATUG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AM_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_ZZ0S2BLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_DGLTP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_CHARG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FAKSP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_AR_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_CO_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EDATU_CONFIRMED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_TRAID",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ORDER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZ0S2REVG2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KDMAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KNREF_HEAD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFIMG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DEV_CONF_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DUE_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SENT_ON",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_I_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TDLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REQ_TEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SEND_DATE_F",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VBUND",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_GUSCON_LEVEL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_HTEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PSTYV",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_PSMNG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BASF_LOFCR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "LAST_NOTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FOLLOWUP_NOTES_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LEVEL_TYPE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_MATNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DISPO",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NETWR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_N_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NPS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_XBLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NY_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AUART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_STTRG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZTERM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_PEND_DEL_QUAN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSARK",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VKORG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBETR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PRSDT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AUFNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KOSCH",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSTKD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_04_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_03_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_01_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_05_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_02_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ABGRU",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KWMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ROUTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKGRP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKBUR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZDKPPRODB",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ORT01",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LAND1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TKNUM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ALERT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_CURRENT_STATUS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ETA_UPDATED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VSBED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_VSART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LGORT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_SUPPLY_SITUATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_TRAGR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_TDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_UNCONFIRMED_QTY",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VE_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_EXTI1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                }
                            ],
                            "orderedFilterItems": "[{\"name\":\"SO_VBELN\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VKORG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VTWEG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_EDATU_REQUESTED\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_AG_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_WE_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"criticalityDueDate\",\"group\":\"__$INTERNAL$\"},{\"name\":\"shipmentEtaUpdated\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_ISSUE\",\"group\":\"allIssues\"},{\"name\":\"DL_WADAT_IST\",\"group\":\"allIssues\"},{\"name\":\"SO_F_ZZ0S2MATUG\",\"group\":\"allIssues\"},{\"name\":\"SO_AM_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_AS_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_F_AS_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"TM_DATEN\",\"group\":\"allIssues\"},{\"name\":\"TM_DATBG\",\"group\":\"allIssues\"},{\"name\":\"DL_ZZ0S2BLNR\",\"group\":\"allIssues\"},{\"name\":\"SO_F_DGLTP\",\"group\":\"allIssues\"},{\"name\":\"DL_CHARG\",\"group\":\"allIssues\"},{\"name\":\"SO_FAKSP\",\"group\":\"allIssues\"},{\"name\":\"BL_VBELN_INV_LAST\",\"group\":\"allIssues\"},{\"name\":\"BL_VBELN_INV_FIRST\",\"group\":\"allIssues\"},{\"name\":\"BL_POSNR_INV_FIRST\",\"group\":\"allIssues\"},{\"name\":\"BL_POSNR_INV_LAST\",\"group\":\"allIssues\"},{\"name\":\"TM_AR_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_CO_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_EDATU_CONFIRMED\",\"group\":\"allIssues\"},{\"name\":\"SO_KBMENG\",\"group\":\"allIssues\"},{\"name\":\"DL_TRAID\",\"group\":\"allIssues\"},{\"name\":\"SO_ERDAT_ORDER\",\"group\":\"allIssues\"},{\"name\":\"SO_ERDAT_ITEM\",\"group\":\"allIssues\"},{\"name\":\"SO_ZZ0S2REVG2\",\"group\":\"allIssues\"},{\"name\":\"SO_KDMAT\",\"group\":\"allIssues\"},{\"name\":\"SO_KNREF_HEAD\",\"group\":\"allIssues\"},{\"name\":\"DL_VBELN\",\"group\":\"allIssues\"},{\"name\":\"DL_POSNR\",\"group\":\"allIssues\"},{\"name\":\"DL_LFIMG\",\"group\":\"allIssues\"},{\"name\":\"DL_LFART\",\"group\":\"allIssues\"},{\"name\":\"SO_DEV_CONF_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_DUE_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL_SENT_ON\",\"group\":\"allIssues\"},{\"name\":\"TM_DPTEN\",\"group\":\"allIssues\"},{\"name\":\"TM_DPTBG\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_I_VBELN\",\"group\":\"allIssues\"},{\"name\":\"TM_TDLNR\",\"group\":\"allIssues\"},{\"name\":\"SO_REQ_TEXT\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL_SEND_DATE_F\",\"group\":\"allIssues\"},{\"name\":\"SO_VBUND\",\"group\":\"allIssues\"},{\"name\":\"SO_GUSCON_LEVEL\",\"group\":\"allIssues\"},{\"name\":\"SO_HTEXT\",\"group\":\"allIssues\"},{\"name\":\"SO_INCO1\",\"group\":\"allIssues\"},{\"name\":\"SO_INCO2\",\"group\":\"allIssues\"},{\"name\":\"SO_ISSUE_LOCATION\",\"group\":\"allIssues\"},{\"name\":\"SO_ISSUE_LOCATION_ITEM\",\"group\":\"allIssues\"},{\"name\":\"SO_PSTYV\",\"group\":\"allIssues\"},{\"name\":\"SO_F_PSMNG\",\"group\":\"allIssues\"},{\"name\":\"SO_BASF_LOFCR\",\"group\":\"allIssues\"},{\"name\":\"LAST_NOTE\",\"group\":\"allIssues\"},{\"name\":\"SO_FOLLOWUP_NOTES_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_LEVEL_TYPE\",\"group\":\"allIssues\"},{\"name\":\"SO_F_LDDAT\",\"group\":\"allIssues\"},{\"name\":\"SO_MATNR\",\"group\":\"allIssues\"},{\"name\":\"SO_DISPO\",\"group\":\"allIssues\"},{\"name\":\"SO_NETWR\",\"group\":\"allIssues\"},{\"name\":\"SO_N_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_NPS\",\"group\":\"allIssues\"},{\"name\":\"BL_XBLNR\",\"group\":\"allIssues\"},{\"name\":\"SO_NY_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_POSNR\",\"group\":\"allIssues\"},{\"name\":\"SO_AUART\",\"group\":\"allIssues\"},{\"name\":\"TM_STTRG\",\"group\":\"allIssues\"},{\"name\":\"SO_ZTERM\",\"group\":\"allIssues\"},{\"name\":\"DL_PEND_DEL_QUAN\",\"group\":\"allIssues\"},{\"name\":\"DL_LFDAT\",\"group\":\"allIssues\"},{\"name\":\"DL_WADAT\",\"group\":\"allIssues\"},{\"name\":\"SO_WERKS\",\"group\":\"allIssues\"},{\"name\":\"SO_F_WERKS\",\"group\":\"allIssues\"},{\"name\":\"SO_BSARK\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VKORG\",\"group\":\"allIssues\"},{\"name\":\"SO_KBETR\",\"group\":\"allIssues\"},{\"name\":\"SO_PRSDT\",\"group\":\"allIssues\"},{\"name\":\"SO_F_AUFNR\",\"group\":\"allIssues\"},{\"name\":\"SO_KOSCH\",\"group\":\"allIssues\"},{\"name\":\"SO_BSTKD\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_04_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_03_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_01_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_05_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_02_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_ABGRU\",\"group\":\"allIssues\"},{\"name\":\"SO_KWMENG\",\"group\":\"allIssues\"},{\"name\":\"SO_ROUTE\",\"group\":\"allIssues\"},{\"name\":\"SO_VKGRP\",\"group\":\"allIssues\"},{\"name\":\"SO_VKBUR\",\"group\":\"allIssues\"},{\"name\":\"SO_ZZDKPPRODB\",\"group\":\"allIssues\"},{\"name\":\"SO_ORT01\",\"group\":\"allIssues\"},{\"name\":\"SO_LAND1\",\"group\":\"allIssues\"},{\"name\":\"TM_TKNUM\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_ALERT\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_CURRENT_STATUS\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_ETA_UPDATED\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VSBED\",\"group\":\"allIssues\"},{\"name\":\"TM_VSART\",\"group\":\"allIssues\"},{\"name\":\"SO_F_LGORT\",\"group\":\"allIssues\"},{\"name\":\"SO_SUPPLY_SITUATION\",\"group\":\"allIssues\"},{\"name\":\"SO_TRAGR\",\"group\":\"allIssues\"},{\"name\":\"SO_F_TDDAT\",\"group\":\"allIssues\"},{\"name\":\"SO_UNCONFIRMED_QTY\",\"group\":\"allIssues\"},{\"name\":\"SO_VE_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"TM_EXTI1\",\"group\":\"allIssues\"}]",
                            "filterBarVariant": "{\"SO_VTWEG\":{\"value\":null,\"ranges\":[],\"items\":[{\"key\":\"50\",\"text\":\"50\"}]},\"SO_EDATU_REQUESTED\":{\"conditionTypeInfo\":{\"name\":\"sap.ui.comp.config.condition.DateRangeType\",\"data\":{\"operation\":\"THISYEAR\",\"value1\":null,\"value2\":null,\"key\":\"SO_EDATU_REQUESTED\",\"calendarType\":\"Gregorian\"}},\"ranges\":[{\"operation\":\"BT\",\"value1\":\"2024-01-01T00:00:00.000\",\"value2\":\"2024-12-31T23:59:59.999\",\"exclude\":false,\"keyField\":\"SO_EDATU_REQUESTED\",\"tokenText\":null}],\"items\":[]},\"_CUSTOM\":{\"shipmentEta\":\"\"}}",
                            "singleInputsTextArrangementData": "{}"
                        }
                    },
                    "texts": {
                        "variantName": {
                            "value": "Nps_test",
                            "type": "XFLD"
                        }
                    },
                    "favorite": true,
                    "executeOnSelection": false,
                    "contexts": {},
                    "selector": {
                        "persistencyKey": "pageVariantKey"
                    },
                    "standardVariant": false,
                    "variantId": "id_1721978936837_2545_page"
                },
                {
                    "changeType": "page",
                    "reference": "ordermonitoring.openorders",
                    "namespace": "apps/ordermonitoring.openorders/changes/",
                    "projectId": "ordermonitoring.openorders",
                    "support": {
                        "generator": "FlexObjectFactory.createCompVariant",
                        "user": "RAKSHIP"
                    },
                    "originalLanguage": "EN",
                    "layer": "CUSTOMER",
                    "fileType": "variant",
                    "fileName": "id_1722521842541_527_page",
                    "content": {
                        "allIssuesKey": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_MATNR",
                                        "index": 14
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 15
                                    }
                                ],
                                "fixedColumnCount": 2
                            }
                        },
                        "nps10Key": {
                            "executeOnSelection": false
                        },
                        "nps20Key": {
                            "executeOnSelection": false
                        },
                        "nps30Key": {
                            "executeOnSelection": false
                        },
                        "nps40Key": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_VBELN",
                                        "index": -1
                                    },
                                    {
                                        "columnKey": "SO_POSNR",
                                        "index": 0
                                    },
                                    {
                                        "columnKey": "SO_DUE_DATE",
                                        "index": 1
                                    },
                                    {
                                        "columnKey": "SO_NPS",
                                        "index": 2
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_WERKS",
                                        "index": 4
                                    },
                                    {
                                        "columnKey": "SO_KDMAT",
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ORDER",
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ITEM",
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "SO_AUART",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "SO_VTWEG",
                                        "index": 9
                                    },
                                    {
                                        "columnKey": "SO_MATNR",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "SO_AG_PARTNER",
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "SO_WE_PARTNER",
                                        "index": 12
                                    },
                                    {
                                        "columnKey": "SO_LAND1",
                                        "index": 13
                                    },
                                    {
                                        "columnKey": "SO_ORT01",
                                        "index": 14
                                    },
                                    {
                                        "columnKey": "SO_VKORG",
                                        "index": 15
                                    },
                                    {
                                        "columnKey": "SO_EDATU_CONFIRMED",
                                        "index": 16
                                    },
                                    {
                                        "columnKey": "SO_EDATU_REQUESTED",
                                        "index": 17
                                    },
                                    {
                                        "columnKey": "SO_KWMENG",
                                        "index": 18
                                    },
                                    {
                                        "columnKey": "SO_BSTKD",
                                        "index": 19
                                    },
                                    {
                                        "columnKey": "SO_ZZ0S2REVG2",
                                        "index": 20
                                    },
                                    {
                                        "columnKey": "SO_F_WERKS",
                                        "index": 21
                                    },
                                    {
                                        "columnKey": "SO_ZZDKPPRODB",
                                        "index": 22
                                    },
                                    {
                                        "columnKey": "SO_GUSCON_LEVEL",
                                        "index": 23
                                    },
                                    {
                                        "columnKey": "SO_LEVEL_TYPE",
                                        "index": 24
                                    },
                                    {
                                        "columnKey": "SO_F_VBELN",
                                        "index": 25
                                    },
                                    {
                                        "columnKey": "SO_ZTERM",
                                        "index": 26
                                    },
                                    {
                                        "columnKey": "SO_PRSDT",
                                        "index": 27
                                    },
                                    {
                                        "columnKey": "SO_I_VBELN",
                                        "index": 28
                                    },
                                    {
                                        "columnKey": "SO_N_VBELN",
                                        "index": 29
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "index": 30
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "visible": true,
                                        "index": 31
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "visible": true,
                                        "index": 32
                                    },
                                    {
                                        "columnKey": "DL_POSNR",
                                        "visible": true,
                                        "index": 33
                                    },
                                    {
                                        "columnKey": "DL_LFIMG",
                                        "visible": true,
                                        "index": 34
                                    },
                                    {
                                        "columnKey": "SO_MDB",
                                        "index": 35
                                    },
                                    {
                                        "columnKey": "DL_WADAT_IST",
                                        "index": 36
                                    },
                                    {
                                        "columnKey": "SO_F_ZZ0S2MATUG",
                                        "index": 37
                                    },
                                    {
                                        "columnKey": "SO_AM_PARTNER",
                                        "index": 38
                                    },
                                    {
                                        "columnKey": "SO_AS_PARTNER",
                                        "index": 39
                                    },
                                    {
                                        "columnKey": "SO_F_AS_PARTNER",
                                        "index": 40
                                    },
                                    {
                                        "columnKey": "TM_DATEN",
                                        "index": 41
                                    },
                                    {
                                        "columnKey": "TM_DATBG",
                                        "index": 42
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "index": 43
                                    },
                                    {
                                        "columnKey": "DL_ZZ0S2BLNR",
                                        "index": 44
                                    },
                                    {
                                        "columnKey": "SO_F_DGLTP",
                                        "index": 45
                                    },
                                    {
                                        "columnKey": "DL_CHARG",
                                        "index": 46
                                    },
                                    {
                                        "columnKey": "SO_FAKSP",
                                        "index": 47
                                    },
                                    {
                                        "columnKey": "BL_VBELN_INV_LAST",
                                        "index": 48
                                    },
                                    {
                                        "columnKey": "BL_VBELN_INV_FIRST",
                                        "index": 49
                                    },
                                    {
                                        "columnKey": "BL_POSNR_INV_FIRST",
                                        "index": 50
                                    },
                                    {
                                        "columnKey": "BL_POSNR_INV_LAST",
                                        "index": 51
                                    },
                                    {
                                        "columnKey": "TM_AR_DATE",
                                        "index": 52
                                    },
                                    {
                                        "columnKey": "SO_CO_PARTNER",
                                        "index": 53
                                    },
                                    {
                                        "columnKey": "SO_KBMENG",
                                        "index": 54
                                    },
                                    {
                                        "columnKey": "DL_TRAID",
                                        "index": 55
                                    },
                                    {
                                        "columnKey": "SO_KNREF_HEAD",
                                        "index": 56
                                    },
                                    {
                                        "columnKey": "DL_LFART",
                                        "index": 57
                                    },
                                    {
                                        "columnKey": "SO_DEV_CONF_DATE",
                                        "index": 58
                                    },
                                    {
                                        "columnKey": "SO_EMAIL_SENT_ON",
                                        "index": 59
                                    },
                                    {
                                        "columnKey": "TM_DPTEN",
                                        "index": 60
                                    },
                                    {
                                        "columnKey": "TM_DPTBG",
                                        "index": 61
                                    },
                                    {
                                        "columnKey": "TM_TDLNR",
                                        "index": 62
                                    },
                                    {
                                        "columnKey": "SO_REQ_TEXT",
                                        "index": 63
                                    },
                                    {
                                        "columnKey": "SO_EMAIL_SEND_DATE_F",
                                        "index": 64
                                    },
                                    {
                                        "columnKey": "SO_VBUND",
                                        "index": 65
                                    },
                                    {
                                        "columnKey": "SO_HTEXT",
                                        "index": 66
                                    },
                                    {
                                        "columnKey": "SO_INCO1",
                                        "index": 67
                                    },
                                    {
                                        "columnKey": "SO_INCO2",
                                        "index": 68
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "index": 69
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION_ITEM",
                                        "index": 70
                                    },
                                    {
                                        "columnKey": "SO_PSTYV",
                                        "index": 71
                                    },
                                    {
                                        "columnKey": "SO_F_PSMNG",
                                        "index": 72
                                    },
                                    {
                                        "columnKey": "SO_BASF_LOFCR",
                                        "index": 73
                                    },
                                    {
                                        "columnKey": "LAST_NOTE",
                                        "index": 74
                                    },
                                    {
                                        "columnKey": "SO_FOLLOWUP_NOTES_LANG",
                                        "index": 75
                                    },
                                    {
                                        "columnKey": "SO_F_LDDAT",
                                        "index": 76
                                    },
                                    {
                                        "columnKey": "SO_DISPO",
                                        "index": 77
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 78
                                    },
                                    {
                                        "columnKey": "BL_XBLNR",
                                        "index": 79
                                    },
                                    {
                                        "columnKey": "SO_NY_PARTNER",
                                        "index": 80
                                    },
                                    {
                                        "columnKey": "TM_STTRG",
                                        "index": 81
                                    },
                                    {
                                        "columnKey": "DL_PEND_DEL_QUAN",
                                        "index": 82
                                    },
                                    {
                                        "columnKey": "DL_LFDAT",
                                        "index": 83
                                    },
                                    {
                                        "columnKey": "SO_BSARK",
                                        "index": 85
                                    },
                                    {
                                        "columnKey": "SO_F_VKORG",
                                        "index": 86
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 87
                                    },
                                    {
                                        "columnKey": "SO_F_AUFNR",
                                        "index": 88
                                    },
                                    {
                                        "columnKey": "SO_KOSCH",
                                        "index": 89
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_04_LANG",
                                        "index": 90
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_03_LANG",
                                        "index": 91
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_01_LANG",
                                        "index": 92
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_05_LANG",
                                        "index": 93
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_02_LANG",
                                        "index": 94
                                    },
                                    {
                                        "columnKey": "SO_ABGRU",
                                        "index": 95
                                    },
                                    {
                                        "columnKey": "SO_ROUTE",
                                        "index": 96
                                    },
                                    {
                                        "columnKey": "SO_VKGRP",
                                        "index": 97
                                    },
                                    {
                                        "columnKey": "SO_VKBUR",
                                        "index": 98
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 99
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "index": 100
                                    },
                                    {
                                        "columnKey": "SO_F_VSBED",
                                        "index": 101
                                    },
                                    {
                                        "columnKey": "TM_VSART",
                                        "index": 102
                                    },
                                    {
                                        "columnKey": "SO_F_LGORT",
                                        "index": 103
                                    },
                                    {
                                        "columnKey": "SO_SUPPLY_SITUATION",
                                        "index": 104
                                    },
                                    {
                                        "columnKey": "SO_TRAGR",
                                        "index": 105
                                    },
                                    {
                                        "columnKey": "SO_F_TDDAT",
                                        "index": 106
                                    },
                                    {
                                        "columnKey": "SO_UNCONFIRMED_QTY",
                                        "index": 107
                                    },
                                    {
                                        "columnKey": "SO_VE_PARTNER",
                                        "index": 108
                                    },
                                    {
                                        "columnKey": "TM_EXTI1",
                                        "index": 109
                                    }
                                ],
                                "fixedColumnCount": 2
                            }
                        },
                        "nps50Key": {
                            "executeOnSelection": false
                        },
                        "nps60Key": {
                            "executeOnSelection": false
                        },
                        "nps70Key": {
                            "executeOnSelection": false
                        },
                        "nps80Key": {
                            "executeOnSelection": false
                        },
                        "nps90Key": {
                            "executeOnSelection": false
                        },
                        "nps95Key": {
                            "executeOnSelection": false
                        },
                        "nps99Key": {
                            "executeOnSelection": false
                        },
                        "nps00Key": {
                            "executeOnSelection": false
                        },
                        "filterBarKey": {
                            "version": "V3",
                            "filterbar": [
                                {
                                    "group": "allIssues",
                                    "name": "SO_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ORDER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AUART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_MATNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KDMAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LAND1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ORT01",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_CO_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NY_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VE_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AM_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KNREF_HEAD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VBUND",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KWMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EDATU_CONFIRMED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_UNCONFIRMED_QTY",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REQ_TEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FAKSP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_SUPPLY_SITUATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBETR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NETWR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_HTEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PSTYV",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DISPO",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KOSCH",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKBUR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ABGRU",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZTERM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PRSDT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZ0S2REVG2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZDKPPRODB",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSARK",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BASF_LOFCR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_GUSCON_LEVEL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_I_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LEVEL_TYPE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_N_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSTKD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_TRAGR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKGRP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ROUTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VKORG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LGORT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_TDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_ZZ0S2MATUG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AUFNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_DGLTP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_PSMNG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VSBED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "LAST_NOTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_CHARG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFIMG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_TRAID",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_ZZ0S2BLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_PEND_DEL_QUAN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT_IST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TKNUM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_VSART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_EXTI1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_AR_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TDLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ALERT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_STTRG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NPS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DUE_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ETA_UPDATED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_XBLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FOLLOWUP_NOTES_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_01_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_02_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_03_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_04_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_05_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DEV_CONF_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SEND_DATE_F",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SENT_ON",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_MDB",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_CURRENT_STATUS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                }
                            ],
                            "orderedFilterItems": "[{\"name\":\"SO_VBELN\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VKORG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VTWEG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_EDATU_REQUESTED\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_AG_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_WE_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_ISSUE\",\"group\":\"__$INTERNAL$\"},{\"name\":\"criticalityDueDate\",\"group\":\"__$INTERNAL$\"},{\"name\":\"shipmentEtaUpdated\",\"group\":\"__$INTERNAL$\"}]",
                            "filterBarVariant": "{\"SO_VBELN\":{\"value\":null,\"ranges\":[{\"exclude\":false,\"operation\":\"EQ\",\"value1\":\"6012040664\",\"keyField\":\"SO_VBELN\",\"tokenText\":\"=6012040664\"}],\"items\":[]},\"SO_EDATU_REQUESTED\":{\"conditionTypeInfo\":{\"name\":\"sap.ui.comp.config.condition.DateRangeType\",\"data\":{\"operation\":\"THISYEAR\",\"value1\":null,\"value2\":null,\"key\":\"SO_EDATU_REQUESTED\",\"calendarType\":\"Gregorian\"}},\"ranges\":[{\"operation\":\"BT\",\"value1\":\"2024-01-01T00:00:00.000\",\"value2\":\"2024-12-31T23:59:59.999\",\"exclude\":false,\"keyField\":\"SO_EDATU_REQUESTED\",\"tokenText\":null}],\"items\":[]},\"_CUSTOM\":{\"shipmentEta\":\"\"}}",
                            "singleInputsTextArrangementData": "{}"
                        }
                    },
                    "texts": {
                        "variantName": {
                            "value": "2024_rakshit",
                            "type": "XFLD"
                        }
                    },
                    "favorite": true,
                    "executeOnSelection": false,
                    "contexts": {},
                    "selector": {
                        "persistencyKey": "pageVariantKey"
                    },
                    "standardVariant": false,
                    "variantId": "id_1722521842541_527_page",
                    "creation": "2024-08-01T14:17:24.2963610Z"
                },
                {
                    "changeType": "page",
                    "reference": "ordermonitoring.openorders",
                    "namespace": "apps/ordermonitoring.openorders/changes/",
                    "projectId": "ordermonitoring.openorders",
                    "support": {
                        "generator": "FlexObjectFactory.createCompVariant",
                        "sapui5Version": "1.126.0",
                        "user": "GIFONNVD"
                    },
                    "originalLanguage": "EN",
                    "layer": "CUSTOMER",
                    "fileType": "variant",
                    "fileName": "id_1724143937544_720_page",
                    "content": {
                        "allIssuesKey": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_I_VBELN",
                                        "visible": true,
                                        "index": 2
                                    },
                                    {
                                        "columnKey": "SO_N_VBELN",
                                        "visible": true,
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_F_VBELN",
                                        "visible": true,
                                        "index": 4
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "visible": true,
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "SO_DUE_DATE",
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "SO_NPS",
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "index": 9
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "SO_AUART",
                                        "visible": true,
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "DL_POSNR",
                                        "index": 12
                                    },
                                    {
                                        "columnKey": "SO_KBMENG",
                                        "index": 13
                                    },
                                    {
                                        "columnKey": "DL_LFIMG",
                                        "visible": true,
                                        "index": 14
                                    },
                                    {
                                        "columnKey": "DL_PEND_DEL_QUAN",
                                        "visible": true,
                                        "index": 15
                                    },
                                    {
                                        "columnKey": "SO_UNCONFIRMED_QTY",
                                        "visible": true,
                                        "index": 16
                                    },
                                    {
                                        "columnKey": "SO_MDB",
                                        "index": 17
                                    },
                                    {
                                        "columnKey": "DL_WADAT_IST",
                                        "visible": false,
                                        "index": 18
                                    },
                                    {
                                        "columnKey": "SO_F_ZZ0S2MATUG",
                                        "index": 19
                                    },
                                    {
                                        "columnKey": "SO_AM_PARTNER",
                                        "index": 20
                                    },
                                    {
                                        "columnKey": "SO_AS_PARTNER",
                                        "index": 21
                                    },
                                    {
                                        "columnKey": "SO_F_AS_PARTNER",
                                        "index": 22
                                    },
                                    {
                                        "columnKey": "TM_DATEN",
                                        "visible": false,
                                        "index": 23
                                    },
                                    {
                                        "columnKey": "TM_DATBG",
                                        "visible": false,
                                        "index": 24
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "index": 25
                                    },
                                    {
                                        "columnKey": "DL_ZZ0S2BLNR",
                                        "index": 26
                                    },
                                    {
                                        "columnKey": "SO_F_DGLTP",
                                        "index": 27
                                    },
                                    {
                                        "columnKey": "DL_CHARG",
                                        "index": 28
                                    },
                                    {
                                        "columnKey": "SO_FAKSP",
                                        "index": 29
                                    },
                                    {
                                        "columnKey": "BL_VBELN_INV_LAST",
                                        "index": 30
                                    },
                                    {
                                        "columnKey": "BL_VBELN_INV_FIRST",
                                        "index": 31
                                    },
                                    {
                                        "columnKey": "BL_POSNR_INV_FIRST",
                                        "index": 32
                                    },
                                    {
                                        "columnKey": "BL_POSNR_INV_LAST",
                                        "index": 33
                                    },
                                    {
                                        "columnKey": "TM_AR_DATE",
                                        "index": 34
                                    },
                                    {
                                        "columnKey": "SO_CO_PARTNER",
                                        "index": 35
                                    },
                                    {
                                        "columnKey": "SO_EDATU_CONFIRMED",
                                        "visible": false,
                                        "index": 36
                                    },
                                    {
                                        "columnKey": "DL_TRAID",
                                        "index": 37
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ORDER",
                                        "index": 38
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ITEM",
                                        "visible": false,
                                        "index": 39
                                    },
                                    {
                                        "columnKey": "SO_ZZ0S2REVG2",
                                        "index": 40
                                    },
                                    {
                                        "columnKey": "SO_KDMAT",
                                        "visible": false,
                                        "index": 41
                                    },
                                    {
                                        "columnKey": "SO_KNREF_HEAD",
                                        "index": 42
                                    },
                                    {
                                        "columnKey": "DL_LFART",
                                        "index": 43
                                    },
                                    {
                                        "columnKey": "SO_DEV_CONF_DATE",
                                        "index": 44
                                    },
                                    {
                                        "columnKey": "SO_VTWEG",
                                        "visible": false,
                                        "index": 45
                                    },
                                    {
                                        "columnKey": "SO_EMAIL_SENT_ON",
                                        "index": 46
                                    },
                                    {
                                        "columnKey": "TM_DPTEN",
                                        "visible": false,
                                        "index": 47
                                    },
                                    {
                                        "columnKey": "TM_DPTBG",
                                        "visible": false,
                                        "index": 48
                                    },
                                    {
                                        "columnKey": "TM_TDLNR",
                                        "visible": false,
                                        "index": 49
                                    },
                                    {
                                        "columnKey": "SO_REQ_TEXT",
                                        "index": 50
                                    },
                                    {
                                        "columnKey": "SO_EMAIL_SEND_DATE_F",
                                        "index": 51
                                    },
                                    {
                                        "columnKey": "SO_VBUND",
                                        "index": 52
                                    },
                                    {
                                        "columnKey": "SO_GUSCON_LEVEL",
                                        "index": 53
                                    },
                                    {
                                        "columnKey": "SO_HTEXT",
                                        "index": 54
                                    },
                                    {
                                        "columnKey": "SO_INCO1",
                                        "index": 55
                                    },
                                    {
                                        "columnKey": "SO_INCO2",
                                        "index": 56
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION_ITEM",
                                        "index": 57
                                    },
                                    {
                                        "columnKey": "SO_PSTYV",
                                        "index": 58
                                    },
                                    {
                                        "columnKey": "SO_F_PSMNG",
                                        "index": 59
                                    },
                                    {
                                        "columnKey": "SO_BASF_LOFCR",
                                        "index": 60
                                    },
                                    {
                                        "columnKey": "LAST_NOTE",
                                        "index": 61
                                    },
                                    {
                                        "columnKey": "SO_FOLLOWUP_NOTES_LANG",
                                        "index": 62
                                    },
                                    {
                                        "columnKey": "SO_LEVEL_TYPE",
                                        "index": 63
                                    },
                                    {
                                        "columnKey": "SO_F_LDDAT",
                                        "visible": false,
                                        "index": 64
                                    },
                                    {
                                        "columnKey": "SO_MATNR",
                                        "visible": false,
                                        "index": 65
                                    },
                                    {
                                        "columnKey": "SO_DISPO",
                                        "index": 66
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 67
                                    },
                                    {
                                        "columnKey": "BL_XBLNR",
                                        "index": 68
                                    },
                                    {
                                        "columnKey": "SO_NY_PARTNER",
                                        "index": 69
                                    },
                                    {
                                        "columnKey": "TM_STTRG",
                                        "index": 70
                                    },
                                    {
                                        "columnKey": "SO_ZTERM",
                                        "index": 71
                                    },
                                    {
                                        "columnKey": "DL_LFDAT",
                                        "index": 72
                                    },
                                    {
                                        "columnKey": "DL_WADAT",
                                        "index": 73
                                    },
                                    {
                                        "columnKey": "SO_WERKS",
                                        "visible": false,
                                        "index": 74
                                    },
                                    {
                                        "columnKey": "SO_F_WERKS",
                                        "index": 75
                                    },
                                    {
                                        "columnKey": "SO_BSARK",
                                        "index": 76
                                    },
                                    {
                                        "columnKey": "SO_F_VKORG",
                                        "index": 77
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 78
                                    },
                                    {
                                        "columnKey": "SO_PRSDT",
                                        "index": 79
                                    },
                                    {
                                        "columnKey": "SO_F_AUFNR",
                                        "index": 80
                                    },
                                    {
                                        "columnKey": "SO_KOSCH",
                                        "index": 81
                                    },
                                    {
                                        "columnKey": "SO_BSTKD",
                                        "index": 82
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_04_LANG",
                                        "index": 83
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_03_LANG",
                                        "index": 84
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_01_LANG",
                                        "index": 85
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_05_LANG",
                                        "index": 86
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_02_LANG",
                                        "index": 87
                                    },
                                    {
                                        "columnKey": "SO_ABGRU",
                                        "index": 88
                                    },
                                    {
                                        "columnKey": "SO_EDATU_REQUESTED",
                                        "visible": false,
                                        "index": 89
                                    },
                                    {
                                        "columnKey": "SO_KWMENG",
                                        "visible": false,
                                        "index": 90
                                    },
                                    {
                                        "columnKey": "SO_ROUTE",
                                        "visible": false,
                                        "index": 91
                                    },
                                    {
                                        "columnKey": "SO_VKGRP",
                                        "index": 92
                                    },
                                    {
                                        "columnKey": "SO_VKBUR",
                                        "index": 93
                                    },
                                    {
                                        "columnKey": "SO_VKORG",
                                        "visible": false,
                                        "index": 94
                                    },
                                    {
                                        "columnKey": "SO_ZZDKPPRODB",
                                        "visible": false,
                                        "index": 95
                                    },
                                    {
                                        "columnKey": "SO_WE_PARTNER",
                                        "index": 96
                                    },
                                    {
                                        "columnKey": "SO_ORT01",
                                        "visible": false,
                                        "index": 97
                                    },
                                    {
                                        "columnKey": "SO_LAND1",
                                        "visible": false,
                                        "index": 98
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 99
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "visible": false,
                                        "index": 100
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "visible": false,
                                        "index": 101
                                    },
                                    {
                                        "columnKey": "SO_F_VSBED",
                                        "index": 102
                                    },
                                    {
                                        "columnKey": "TM_VSART",
                                        "index": 103
                                    },
                                    {
                                        "columnKey": "SO_AG_PARTNER",
                                        "index": 104
                                    },
                                    {
                                        "columnKey": "SO_F_LGORT",
                                        "index": 105
                                    },
                                    {
                                        "columnKey": "SO_SUPPLY_SITUATION",
                                        "index": 106
                                    },
                                    {
                                        "columnKey": "SO_TRAGR",
                                        "index": 107
                                    },
                                    {
                                        "columnKey": "SO_F_TDDAT",
                                        "index": 108
                                    },
                                    {
                                        "columnKey": "SO_VE_PARTNER",
                                        "index": 109
                                    },
                                    {
                                        "columnKey": "TM_EXTI1",
                                        "index": 110
                                    }
                                ]
                            },
                            "sort": {
                                "sortItems": [
                                    {
                                        "columnKey": "SO_VBELN",
                                        "operation": "Ascending"
                                    }
                                ]
                            }
                        },
                        "nps10Key": {
                            "executeOnSelection": false
                        },
                        "nps20Key": {
                            "executeOnSelection": false
                        },
                        "nps30Key": {
                            "executeOnSelection": false
                        },
                        "nps40Key": {
                            "executeOnSelection": false
                        },
                        "nps50Key": {
                            "executeOnSelection": false
                        },
                        "nps60Key": {
                            "executeOnSelection": false
                        },
                        "nps70Key": {
                            "executeOnSelection": false
                        },
                        "nps80Key": {
                            "executeOnSelection": false
                        },
                        "nps90Key": {
                            "executeOnSelection": false
                        },
                        "nps95Key": {
                            "executeOnSelection": false
                        },
                        "nps99Key": {
                            "executeOnSelection": false
                        },
                        "nps00Key": {
                            "executeOnSelection": false
                        },
                        "filterBarKey": {
                            "version": "V3",
                            "filterbar": [
                                {
                                    "group": "allIssues",
                                    "name": "SO_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ORDER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AUART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_MATNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KDMAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LAND1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ORT01",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_CO_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NY_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VE_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AM_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KNREF_HEAD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VBUND",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KWMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EDATU_CONFIRMED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_UNCONFIRMED_QTY",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REQ_TEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FAKSP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_SUPPLY_SITUATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBETR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NETWR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_HTEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PSTYV",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DISPO",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KOSCH",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKBUR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ABGRU",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZTERM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PRSDT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZ0S2REVG2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZDKPPRODB",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSARK",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BASF_LOFCR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_GUSCON_LEVEL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_I_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LEVEL_TYPE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_N_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSTKD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_TRAGR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKGRP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ROUTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VKORG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LGORT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_TDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_ZZ0S2MATUG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AUFNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_DGLTP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_PSMNG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VSBED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "LAST_NOTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_CHARG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFIMG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_TRAID",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_ZZ0S2BLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_PEND_DEL_QUAN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT_IST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TKNUM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_VSART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_EXTI1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_AR_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TDLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ALERT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_STTRG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NPS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DUE_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ETA_UPDATED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_XBLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FOLLOWUP_NOTES_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_01_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_02_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_03_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_04_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_05_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DEV_CONF_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SEND_DATE_F",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SENT_ON",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_MDB",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_CURRENT_STATUS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                }
                            ],
                            "orderedFilterItems": "[{\"name\":\"SO_VBELN\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VKORG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VTWEG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_EDATU_REQUESTED\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_AG_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_WE_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_ISSUE\",\"group\":\"__$INTERNAL$\"},{\"name\":\"criticalityDueDate\",\"group\":\"__$INTERNAL$\"},{\"name\":\"shipmentEtaUpdated\",\"group\":\"__$INTERNAL$\"}]",
                            "filterBarVariant": "{\"SO_VBELN\":{\"value\":null,\"ranges\":[{\"keyField\":\"SO_VBELN\",\"tokenText\":\"=6011937537\",\"value1\":\"6011937537\",\"value2\":null,\"exclude\":false,\"operation\":\"EQ\"},{\"keyField\":\"SO_VBELN\",\"tokenText\":\"=6011699448\",\"value1\":\"6011699448\",\"value2\":null,\"exclude\":false,\"operation\":\"EQ\"},{\"keyField\":\"SO_VBELN\",\"tokenText\":\"=6011904931\",\"value1\":\"6011904931\",\"value2\":null,\"exclude\":false,\"operation\":\"EQ\"}],\"items\":[]},\"_CUSTOM\":{\"shipmentEta\":\"\"}}",
                            "singleInputsTextArrangementData": "{}"
                        }
                    },
                    "texts": {
                        "variantName": {
                            "value": "Public Intercompany 3o level",
                            "type": "XFLD"
                        }
                    },
                    "favorite": true,
                    "executeOnSelection": false,
                    "contexts": {},
                    "selector": {
                        "persistencyKey": "pageVariantKey"
                    },
                    "standardVariant": false,
                    "variantId": "id_1724143937544_720_page",
                    "creation": "2024-08-20T08:52:18.5835870Z"
                },
                {
                    "changeType": "page",
                    "reference": "ordermonitoring.openorders",
                    "namespace": "apps/ordermonitoring.openorders/changes/",
                    "creation": "2024-11-04T10:56:51.6894730Z",
                    "projectId": "ordermonitoring.openorders",
                    "support": {
                        "generator": "FlexObjectFactory.createCompVariant",
                        "user": "GARCID42"
                    },
                    "originalLanguage": "EN",
                    "layer": "CUSTOMER",
                    "fileType": "variant",
                    "fileName": "id_1730717810990_164_page",
                    "content": {
                        "allIssuesKey": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_POSNR",
                                        "width": "124px"
                                    },
                                    {
                                        "columnKey": "SO_DUE_DATE",
                                        "width": "197px"
                                    },
                                    {
                                        "columnKey": "SO_NPS",
                                        "width": "255.88px"
                                    }
                                ]
                            },
                            "sort": {
                                "sortItems": [
                                    {
                                        "columnKey": "SO_DUE_DATE",
                                        "operation": "Ascending"
                                    },
                                    {
                                        "columnKey": "SO_VBELN",
                                        "operation": "Ascending"
                                    },
                                    {
                                        "columnKey": "SO_POSNR",
                                        "operation": "Ascending"
                                    }
                                ]
                            }
                        },
                        "nps10Key": {
                            "executeOnSelection": false
                        },
                        "nps20Key": {
                            "executeOnSelection": false
                        },
                        "nps30Key": {
                            "executeOnSelection": false
                        },
                        "nps40Key": {
                            "executeOnSelection": false
                        },
                        "nps50Key": {
                            "executeOnSelection": false
                        },
                        "nps60Key": {
                            "executeOnSelection": false
                        },
                        "nps70Key": {
                            "executeOnSelection": false
                        },
                        "nps80Key": {
                            "executeOnSelection": false
                        },
                        "nps90Key": {
                            "executeOnSelection": false
                        },
                        "nps95Key": {
                            "executeOnSelection": false
                        },
                        "nps99Key": {
                            "executeOnSelection": false
                        },
                        "nps00Key": {
                            "executeOnSelection": false
                        },
                        "filterBarKey": {
                            "version": "V3",
                            "filterbar": [
                                {
                                    "group": "allIssues",
                                    "name": "SO_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ORDER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AUART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_MATNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KDMAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LAND1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ORT01",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_CO_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NY_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VE_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AM_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KNREF_HEAD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VBUND",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KWMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EDATU_CONFIRMED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_UNCONFIRMED_QTY",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REQ_TEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FAKSP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_SUPPLY_SITUATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBETR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NETWR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_HTEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PSTYV",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DISPO",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KOSCH",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKBUR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ABGRU",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZTERM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PRSDT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZ0S2REVG2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZDKPPRODB",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSARK",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BASF_LOFCR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_GUSCON_LEVEL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_I_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LEVEL_TYPE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_N_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSTKD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_TRAGR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKGRP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ROUTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VKORG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LGORT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_TDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_ZZ0S2MATUG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AUFNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_DGLTP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_PSMNG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VSBED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "LAST_NOTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_CHARG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFIMG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_TRAID",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_ZZ0S2BLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_PEND_DEL_QUAN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT_IST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TKNUM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_VSART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_EXTI1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_AR_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TDLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ALERT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_STTRG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NPS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DUE_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ETA_UPDATED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_XBLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FOLLOWUP_NOTES_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_01_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_02_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_03_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_04_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_05_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DEV_CONF_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SEND_DATE_F",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SENT_ON",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_MDB",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_ERDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_CURRENT_STATUS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                }
                            ],
                            "orderedFilterItems": "[{\"name\":\"SO_VBELN\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VKORG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VTWEG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_EDATU_REQUESTED\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_AG_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_WE_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_ISSUE\",\"group\":\"__$INTERNAL$\"},{\"name\":\"criticalityDueDate\",\"group\":\"__$INTERNAL$\"},{\"name\":\"shipmentEtaUpdated\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_POSNR\",\"group\":\"allIssues\"},{\"name\":\"SO_ERDAT_ORDER\",\"group\":\"allIssues\"},{\"name\":\"SO_ERDAT_ITEM\",\"group\":\"allIssues\"},{\"name\":\"SO_AUART\",\"group\":\"allIssues\"},{\"name\":\"SO_WERKS\",\"group\":\"allIssues\"},{\"name\":\"SO_MATNR\",\"group\":\"allIssues\"},{\"name\":\"SO_KDMAT\",\"group\":\"allIssues\"},{\"name\":\"SO_LAND1\",\"group\":\"allIssues\"},{\"name\":\"SO_ORT01\",\"group\":\"allIssues\"},{\"name\":\"SO_CO_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_NY_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_AS_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_VE_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_AM_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_KNREF_HEAD\",\"group\":\"allIssues\"},{\"name\":\"SO_VBUND\",\"group\":\"allIssues\"},{\"name\":\"SO_KWMENG\",\"group\":\"allIssues\"},{\"name\":\"SO_EDATU_CONFIRMED\",\"group\":\"allIssues\"},{\"name\":\"SO_KBMENG\",\"group\":\"allIssues\"},{\"name\":\"SO_UNCONFIRMED_QTY\",\"group\":\"allIssues\"},{\"name\":\"SO_REQ_TEXT\",\"group\":\"allIssues\"},{\"name\":\"SO_FAKSP\",\"group\":\"allIssues\"},{\"name\":\"SO_SUPPLY_SITUATION\",\"group\":\"allIssues\"},{\"name\":\"SO_KBETR\",\"group\":\"allIssues\"},{\"name\":\"SO_NETWR\",\"group\":\"allIssues\"},{\"name\":\"SO_HTEXT\",\"group\":\"allIssues\"},{\"name\":\"SO_PSTYV\",\"group\":\"allIssues\"},{\"name\":\"SO_DISPO\",\"group\":\"allIssues\"},{\"name\":\"SO_KOSCH\",\"group\":\"allIssues\"},{\"name\":\"SO_VKBUR\",\"group\":\"allIssues\"},{\"name\":\"SO_ABGRU\",\"group\":\"allIssues\"},{\"name\":\"SO_INCO1\",\"group\":\"allIssues\"},{\"name\":\"SO_INCO2\",\"group\":\"allIssues\"},{\"name\":\"SO_ZTERM\",\"group\":\"allIssues\"},{\"name\":\"SO_PRSDT\",\"group\":\"allIssues\"},{\"name\":\"SO_ZZ0S2REVG2\",\"group\":\"allIssues\"},{\"name\":\"SO_ZZDKPPRODB\",\"group\":\"allIssues\"},{\"name\":\"SO_BSARK\",\"group\":\"allIssues\"},{\"name\":\"SO_BASF_LOFCR\",\"group\":\"allIssues\"},{\"name\":\"SO_GUSCON_LEVEL\",\"group\":\"allIssues\"},{\"name\":\"SO_I_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_LEVEL_TYPE\",\"group\":\"allIssues\"},{\"name\":\"SO_N_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_BSTKD\",\"group\":\"allIssues\"},{\"name\":\"SO_TRAGR\",\"group\":\"allIssues\"},{\"name\":\"SO_VKGRP\",\"group\":\"allIssues\"},{\"name\":\"SO_ROUTE\",\"group\":\"allIssues\"},{\"name\":\"SO_F_WERKS\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VKORG\",\"group\":\"allIssues\"},{\"name\":\"SO_F_AS_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_F_LDDAT\",\"group\":\"allIssues\"},{\"name\":\"SO_F_LGORT\",\"group\":\"allIssues\"},{\"name\":\"SO_F_TDDAT\",\"group\":\"allIssues\"},{\"name\":\"SO_F_ZZ0S2MATUG\",\"group\":\"allIssues\"},{\"name\":\"SO_F_AUFNR\",\"group\":\"allIssues\"},{\"name\":\"SO_F_DGLTP\",\"group\":\"allIssues\"},{\"name\":\"SO_F_PSMNG\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VSBED\",\"group\":\"allIssues\"},{\"name\":\"LAST_NOTE\",\"group\":\"allIssues\"},{\"name\":\"DL_VBELN\",\"group\":\"allIssues\"},{\"name\":\"DL_POSNR\",\"group\":\"allIssues\"},{\"name\":\"DL_CHARG\",\"group\":\"allIssues\"},{\"name\":\"DL_LFIMG\",\"group\":\"allIssues\"},{\"name\":\"DL_LFART\",\"group\":\"allIssues\"},{\"name\":\"DL_LFDAT\",\"group\":\"allIssues\"},{\"name\":\"DL_TRAID\",\"group\":\"allIssues\"},{\"name\":\"DL_ZZ0S2BLNR\",\"group\":\"allIssues\"},{\"name\":\"DL_PEND_DEL_QUAN\",\"group\":\"allIssues\"},{\"name\":\"DL_WADAT\",\"group\":\"allIssues\"},{\"name\":\"DL_WADAT_IST\",\"group\":\"allIssues\"},{\"name\":\"TM_TKNUM\",\"group\":\"allIssues\"},{\"name\":\"TM_VSART\",\"group\":\"allIssues\"},{\"name\":\"TM_EXTI1\",\"group\":\"allIssues\"},{\"name\":\"TM_DPTBG\",\"group\":\"allIssues\"},{\"name\":\"TM_DATBG\",\"group\":\"allIssues\"},{\"name\":\"TM_DPTEN\",\"group\":\"allIssues\"},{\"name\":\"TM_DATEN\",\"group\":\"allIssues\"},{\"name\":\"TM_AR_DATE\",\"group\":\"allIssues\"},{\"name\":\"TM_TDLNR\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_ALERT\",\"group\":\"allIssues\"},{\"name\":\"TM_STTRG\",\"group\":\"allIssues\"},{\"name\":\"SO_NPS\",\"group\":\"allIssues\"},{\"name\":\"SO_DUE_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_ISSUE_LOCATION\",\"group\":\"allIssues\"},{\"name\":\"SO_ISSUE_LOCATION_ITEM\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_ETA_UPDATED\",\"group\":\"allIssues\"},{\"name\":\"BL_VBELN_INV_FIRST\",\"group\":\"allIssues\"},{\"name\":\"BL_VBELN_INV_LAST\",\"group\":\"allIssues\"},{\"name\":\"BL_XBLNR\",\"group\":\"allIssues\"},{\"name\":\"BL_POSNR_INV_LAST\",\"group\":\"allIssues\"},{\"name\":\"BL_POSNR_INV_FIRST\",\"group\":\"allIssues\"},{\"name\":\"SO_FOLLOWUP_NOTES_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_01_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_02_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_03_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_04_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_05_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_DEV_CONF_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL_SEND_DATE_F\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL_SENT_ON\",\"group\":\"allIssues\"},{\"name\":\"SO_MDB\",\"group\":\"allIssues\"},{\"name\":\"DL_ERDAT\",\"group\":\"allIssues\"},{\"name\":\"DL_LDDAT\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_CURRENT_STATUS\",\"group\":\"allIssues\"}]",
                            "filterBarVariant": "{\"SO_EDATU_REQUESTED\":{\"conditionTypeInfo\":{\"name\":\"sap.ui.comp.config.condition.DateRangeType\",\"data\":{\"operation\":\"TODAY\",\"value1\":null,\"value2\":null,\"key\":\"SO_EDATU_REQUESTED\",\"calendarType\":\"Gregorian\"}},\"ranges\":[{\"operation\":\"BT\",\"value1\":\"2024-11-04T00:00:00.000\",\"value2\":\"2024-11-04T23:59:59.999\",\"exclude\":false,\"keyField\":\"SO_EDATU_REQUESTED\",\"tokenText\":null}],\"items\":[]},\"_CUSTOM\":{\"shipmentEta\":\"\"}}",
                            "singleInputsTextArrangementData": "{}"
                        }
                    },
                    "texts": {
                        "variantName": {
                            "value": "Standarddavid",
                            "type": "XFLD"
                        }
                    },
                    "favorite": true,
                    "executeOnSelection": false,
                    "contexts": {},
                    "selector": {
                        "persistencyKey": "pageVariantKey"
                    },
                    "standardVariant": false,
                    "variantId": "id_1730717810990_164_page"
                },
                {
                    "changeType": "page",
                    "reference": "ordermonitoring.openorders",
                    "namespace": "apps/ordermonitoring.openorders/changes/",
                    "projectId": "ordermonitoring.openorders",
                    "support": {
                        "generator": "FlexObjectFactory.createCompVariant",
                        "sapui5Version": "1.129.2",
                        "user": "GIFONNVD"
                    },
                    "originalLanguage": "EN",
                    "layer": "CUSTOMER",
                    "fileType": "variant",
                    "fileName": "id_1730971062555_603_page",
                    "content": {
                        "allIssuesKey": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_NPS",
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "index": 4
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "visible": true,
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "SO_ZZ0S2REVG2",
                                        "visible": true,
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "SO_BSTKD",
                                        "visible": true,
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "index": 9
                                    },
                                    {
                                        "columnKey": "SO_KWMENG",
                                        "width": "141.56px",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "SO_KBMENG",
                                        "width": "143.56px",
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "DL_LFIMG",
                                        "visible": true,
                                        "width": "126.03999999999999px",
                                        "index": 12
                                    },
                                    {
                                        "columnKey": "DL_PEND_DEL_QUAN",
                                        "visible": true,
                                        "width": "180.04000000000002px",
                                        "index": 13
                                    },
                                    {
                                        "columnKey": "SO_UNCONFIRMED_QTY",
                                        "visible": true,
                                        "index": 14
                                    },
                                    {
                                        "columnKey": "DL_WADAT_IST",
                                        "index": 15
                                    },
                                    {
                                        "columnKey": "SO_GUSCON_LEVEL",
                                        "visible": true,
                                        "index": 16
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION_ITEM",
                                        "visible": true,
                                        "index": 17
                                    },
                                    {
                                        "columnKey": "DL_POSNR",
                                        "index": 18
                                    },
                                    {
                                        "columnKey": "SO_MDB",
                                        "index": 19
                                    },
                                    {
                                        "columnKey": "SO_F_ZZ0S2MATUG",
                                        "index": 20
                                    },
                                    {
                                        "columnKey": "SO_AM_PARTNER",
                                        "index": 21
                                    },
                                    {
                                        "columnKey": "SO_AS_PARTNER",
                                        "index": 22
                                    },
                                    {
                                        "columnKey": "SO_F_AS_PARTNER",
                                        "index": 23
                                    },
                                    {
                                        "columnKey": "TM_DATEN",
                                        "visible": false,
                                        "index": 24
                                    },
                                    {
                                        "columnKey": "TM_DATBG",
                                        "visible": false,
                                        "index": 25
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "index": 26
                                    },
                                    {
                                        "columnKey": "DL_ZZ0S2BLNR",
                                        "index": 27
                                    },
                                    {
                                        "columnKey": "SO_F_DGLTP",
                                        "index": 28
                                    },
                                    {
                                        "columnKey": "DL_CHARG",
                                        "index": 29
                                    },
                                    {
                                        "columnKey": "SO_FAKSP",
                                        "index": 30
                                    },
                                    {
                                        "columnKey": "BL_VBELN_INV_LAST",
                                        "index": 31
                                    },
                                    {
                                        "columnKey": "BL_VBELN_INV_FIRST",
                                        "index": 32
                                    },
                                    {
                                        "columnKey": "BL_POSNR_INV_FIRST",
                                        "index": 33
                                    },
                                    {
                                        "columnKey": "BL_POSNR_INV_LAST",
                                        "index": 34
                                    },
                                    {
                                        "columnKey": "TM_AR_DATE",
                                        "index": 35
                                    },
                                    {
                                        "columnKey": "SO_CO_PARTNER",
                                        "index": 36
                                    },
                                    {
                                        "columnKey": "SO_EDATU_CONFIRMED",
                                        "visible": false,
                                        "index": 37
                                    },
                                    {
                                        "columnKey": "DL_TRAID",
                                        "index": 38
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ORDER",
                                        "index": 39
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ITEM",
                                        "visible": false,
                                        "index": 40
                                    },
                                    {
                                        "columnKey": "SO_KDMAT",
                                        "visible": false,
                                        "index": 41
                                    },
                                    {
                                        "columnKey": "SO_KNREF_HEAD",
                                        "index": 42
                                    },
                                    {
                                        "columnKey": "DL_ERDAT",
                                        "index": 43
                                    },
                                    {
                                        "columnKey": "DL_LFART",
                                        "index": 44
                                    },
                                    {
                                        "columnKey": "SO_DEV_CONF_DATE",
                                        "index": 45
                                    },
                                    {
                                        "columnKey": "SO_VTWEG",
                                        "visible": false,
                                        "index": 46
                                    },
                                    {
                                        "columnKey": "SO_EMAIL_SENT_ON",
                                        "index": 47
                                    },
                                    {
                                        "columnKey": "TM_DPTEN",
                                        "visible": false,
                                        "index": 48
                                    },
                                    {
                                        "columnKey": "TM_DPTBG",
                                        "visible": false,
                                        "index": 49
                                    },
                                    {
                                        "columnKey": "SO_F_VBELN",
                                        "index": 50
                                    },
                                    {
                                        "columnKey": "SO_I_VBELN",
                                        "index": 51
                                    },
                                    {
                                        "columnKey": "TM_TDLNR",
                                        "visible": false,
                                        "index": 52
                                    },
                                    {
                                        "columnKey": "SO_REQ_TEXT",
                                        "index": 53
                                    },
                                    {
                                        "columnKey": "SO_EMAIL_SEND_DATE_F",
                                        "index": 54
                                    },
                                    {
                                        "columnKey": "SO_VBUND",
                                        "index": 55
                                    },
                                    {
                                        "columnKey": "SO_HTEXT",
                                        "index": 56
                                    },
                                    {
                                        "columnKey": "SO_INCO1",
                                        "index": 57
                                    },
                                    {
                                        "columnKey": "SO_INCO2",
                                        "index": 58
                                    },
                                    {
                                        "columnKey": "SO_PSTYV",
                                        "index": 59
                                    },
                                    {
                                        "columnKey": "SO_F_PSMNG",
                                        "index": 60
                                    },
                                    {
                                        "columnKey": "SO_BASF_LOFCR",
                                        "index": 61
                                    },
                                    {
                                        "columnKey": "LAST_NOTE",
                                        "index": 62
                                    },
                                    {
                                        "columnKey": "SO_FOLLOWUP_NOTES_LANG",
                                        "index": 63
                                    },
                                    {
                                        "columnKey": "SO_LEVEL_TYPE",
                                        "index": 64
                                    },
                                    {
                                        "columnKey": "SO_F_LDDAT",
                                        "visible": false,
                                        "index": 65
                                    },
                                    {
                                        "columnKey": "DL_LDDAT",
                                        "index": 66
                                    },
                                    {
                                        "columnKey": "SO_MATNR",
                                        "visible": false,
                                        "index": 67
                                    },
                                    {
                                        "columnKey": "SO_DISPO",
                                        "index": 68
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 69
                                    },
                                    {
                                        "columnKey": "SO_N_VBELN",
                                        "index": 70
                                    },
                                    {
                                        "columnKey": "BL_XBLNR",
                                        "index": 71
                                    },
                                    {
                                        "columnKey": "SO_NY_PARTNER",
                                        "index": 72
                                    },
                                    {
                                        "columnKey": "SO_AUART",
                                        "index": 73
                                    },
                                    {
                                        "columnKey": "TM_STTRG",
                                        "index": 74
                                    },
                                    {
                                        "columnKey": "SO_ZTERM",
                                        "index": 75
                                    },
                                    {
                                        "columnKey": "DL_LFDAT",
                                        "index": 76
                                    },
                                    {
                                        "columnKey": "DL_WADAT",
                                        "index": 77
                                    },
                                    {
                                        "columnKey": "SO_WERKS",
                                        "visible": false,
                                        "index": 78
                                    },
                                    {
                                        "columnKey": "SO_F_WERKS",
                                        "index": 79
                                    },
                                    {
                                        "columnKey": "SO_BSARK",
                                        "index": 80
                                    },
                                    {
                                        "columnKey": "SO_F_VKORG",
                                        "index": 81
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 82
                                    },
                                    {
                                        "columnKey": "SO_PRSDT",
                                        "index": 83
                                    },
                                    {
                                        "columnKey": "SO_F_AUFNR",
                                        "index": 84
                                    },
                                    {
                                        "columnKey": "SO_KOSCH",
                                        "index": 85
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_04_LANG",
                                        "index": 86
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_03_LANG",
                                        "index": 87
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_01_LANG",
                                        "index": 88
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_05_LANG",
                                        "index": 89
                                    },
                                    {
                                        "columnKey": "SO_REASON_CODE_02_LANG",
                                        "index": 90
                                    },
                                    {
                                        "columnKey": "SO_ABGRU",
                                        "index": 91
                                    },
                                    {
                                        "columnKey": "SO_EDATU_REQUESTED",
                                        "visible": false,
                                        "index": 92
                                    },
                                    {
                                        "columnKey": "SO_ROUTE",
                                        "visible": false,
                                        "index": 93
                                    },
                                    {
                                        "columnKey": "SO_VKGRP",
                                        "index": 94
                                    },
                                    {
                                        "columnKey": "SO_VKBUR",
                                        "index": 95
                                    },
                                    {
                                        "columnKey": "SO_VKORG",
                                        "visible": false,
                                        "index": 96
                                    },
                                    {
                                        "columnKey": "SO_ZZDKPPRODB",
                                        "visible": false,
                                        "index": 97
                                    },
                                    {
                                        "columnKey": "SO_WE_PARTNER",
                                        "index": 98
                                    },
                                    {
                                        "columnKey": "SO_ORT01",
                                        "visible": false,
                                        "index": 99
                                    },
                                    {
                                        "columnKey": "SO_LAND1",
                                        "visible": false,
                                        "index": 100
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 101
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "visible": false,
                                        "index": 102
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "visible": false,
                                        "index": 103
                                    },
                                    {
                                        "columnKey": "SO_F_VSBED",
                                        "index": 104
                                    },
                                    {
                                        "columnKey": "TM_VSART",
                                        "index": 105
                                    },
                                    {
                                        "columnKey": "SO_AG_PARTNER",
                                        "index": 106
                                    },
                                    {
                                        "columnKey": "SO_F_LGORT",
                                        "index": 107
                                    },
                                    {
                                        "columnKey": "SO_SUPPLY_SITUATION",
                                        "index": 108
                                    },
                                    {
                                        "columnKey": "SO_TRAGR",
                                        "index": 109
                                    },
                                    {
                                        "columnKey": "SO_F_TDDAT",
                                        "index": 110
                                    },
                                    {
                                        "columnKey": "SO_VE_PARTNER",
                                        "index": 111
                                    },
                                    {
                                        "columnKey": "TM_EXTI1",
                                        "index": 112
                                    }
                                ]
                            }
                        },
                        "nps10Key": {
                            "executeOnSelection": false
                        },
                        "nps20Key": {
                            "columns": {
                                "columnsItems": [
                                    {
                                        "columnKey": "SO_NPS",
                                        "index": 3
                                    },
                                    {
                                        "columnKey": "SO_ISSUE_LOCATION",
                                        "index": 4
                                    },
                                    {
                                        "columnKey": "SO_ISSUE",
                                        "index": 5
                                    },
                                    {
                                        "columnKey": "DL_CHARG",
                                        "index": 6
                                    },
                                    {
                                        "columnKey": "SO_WERKS",
                                        "index": 7
                                    },
                                    {
                                        "columnKey": "SO_NETWR",
                                        "index": 8
                                    },
                                    {
                                        "columnKey": "SO_KDMAT",
                                        "index": 9
                                    },
                                    {
                                        "columnKey": "SO_KBETR",
                                        "index": 10
                                    },
                                    {
                                        "columnKey": "SO_ERDAT_ORDER",
                                        "index": 11
                                    },
                                    {
                                        "columnKey": "SO_EMAIL",
                                        "index": 12
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ETA_UPDATED",
                                        "index": 35
                                    },
                                    {
                                        "columnKey": "TM_TKNUM",
                                        "visible": true
                                    },
                                    {
                                        "columnKey": "DL_VBELN",
                                        "index": 37
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_CURRENT_STATUS",
                                        "index": 38
                                    },
                                    {
                                        "columnKey": "TM_SHIPMENT_ALERT",
                                        "index": 39
                                    }
                                ]
                            }
                        },
                        "nps30Key": {
                            "executeOnSelection": false
                        },
                        "nps40Key": {
                            "executeOnSelection": false
                        },
                        "nps50Key": {
                            "executeOnSelection": false
                        },
                        "nps60Key": {
                            "executeOnSelection": false
                        },
                        "nps70Key": {
                            "executeOnSelection": false
                        },
                        "nps80Key": {
                            "executeOnSelection": false
                        },
                        "nps90Key": {
                            "executeOnSelection": false
                        },
                        "nps95Key": {
                            "executeOnSelection": false
                        },
                        "nps99Key": {
                            "executeOnSelection": false
                        },
                        "nps00Key": {
                            "executeOnSelection": false
                        },
                        "filterBarKey": {
                            "version": "V3",
                            "filterbar": [
                                {
                                    "group": "allIssues",
                                    "name": "SO_MDB",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT_IST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_ZZ0S2MATUG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AM_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AS_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DATBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_ZZ0S2BLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_DGLTP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_CHARG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FAKSP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_VBELN_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_FIRST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_POSNR_INV_LAST",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_AR_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_CO_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EDATU_CONFIRMED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_TRAID",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ORDER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ERDAT_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZ0S2REVG2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KDMAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KNREF_HEAD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_ERDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFIMG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DEV_CONF_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DUE_DATE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SENT_ON",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTEN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_DPTBG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_I_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TDLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REQ_TEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_EMAIL_SEND_DATE_F",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VBUND",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_GUSCON_LEVEL",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_HTEXT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_INCO2",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ISSUE_LOCATION_ITEM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PSTYV",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_PSMNG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BASF_LOFCR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "LAST_NOTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_FOLLOWUP_NOTES_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LEVEL_TYPE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_MATNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_DISPO",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NETWR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_N_VBELN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NPS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": true,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "BL_XBLNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_NY_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_POSNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_AUART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_STTRG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZTERM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_PEND_DEL_QUAN",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_LFDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "DL_WADAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_WERKS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSARK",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VKORG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KBETR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_PRSDT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_AUFNR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KOSCH",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_BSTKD",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_04_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_03_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_01_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_05_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_REASON_CODE_02_LANG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ABGRU",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_KWMENG",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ROUTE",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKGRP",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VKBUR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ZZDKPPRODB",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_ORT01",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_LAND1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_TKNUM",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ALERT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_CURRENT_STATUS",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_SHIPMENT_ETA_UPDATED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_VSBED",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_VSART",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_LGORT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_SUPPLY_SITUATION",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_TRAGR",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_F_TDDAT",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_UNCONFIRMED_QTY",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "SO_VE_PARTNER",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                },
                                {
                                    "group": "allIssues",
                                    "name": "TM_EXTI1",
                                    "partOfCurrentVariant": true,
                                    "visibleInFilterBar": false,
                                    "visible": true
                                }
                            ],
                            "orderedFilterItems": "[{\"name\":\"SO_VBELN\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VKORG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_VTWEG\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_EDATU_REQUESTED\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_AG_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_WE_PARTNER\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_ISSUE\",\"group\":\"__$INTERNAL$\"},{\"name\":\"criticalityDueDate\",\"group\":\"__$INTERNAL$\"},{\"name\":\"shipmentEtaUpdated\",\"group\":\"__$INTERNAL$\"},{\"name\":\"SO_MDB\",\"group\":\"allIssues\"},{\"name\":\"DL_WADAT_IST\",\"group\":\"allIssues\"},{\"name\":\"SO_F_ZZ0S2MATUG\",\"group\":\"allIssues\"},{\"name\":\"SO_AM_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_AS_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_F_AS_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"TM_DATEN\",\"group\":\"allIssues\"},{\"name\":\"TM_DATBG\",\"group\":\"allIssues\"},{\"name\":\"DL_ZZ0S2BLNR\",\"group\":\"allIssues\"},{\"name\":\"SO_F_DGLTP\",\"group\":\"allIssues\"},{\"name\":\"DL_CHARG\",\"group\":\"allIssues\"},{\"name\":\"SO_FAKSP\",\"group\":\"allIssues\"},{\"name\":\"BL_VBELN_INV_LAST\",\"group\":\"allIssues\"},{\"name\":\"BL_VBELN_INV_FIRST\",\"group\":\"allIssues\"},{\"name\":\"BL_POSNR_INV_FIRST\",\"group\":\"allIssues\"},{\"name\":\"BL_POSNR_INV_LAST\",\"group\":\"allIssues\"},{\"name\":\"TM_AR_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_CO_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_EDATU_CONFIRMED\",\"group\":\"allIssues\"},{\"name\":\"SO_KBMENG\",\"group\":\"allIssues\"},{\"name\":\"DL_TRAID\",\"group\":\"allIssues\"},{\"name\":\"SO_ERDAT_ORDER\",\"group\":\"allIssues\"},{\"name\":\"SO_ERDAT_ITEM\",\"group\":\"allIssues\"},{\"name\":\"SO_ZZ0S2REVG2\",\"group\":\"allIssues\"},{\"name\":\"SO_KDMAT\",\"group\":\"allIssues\"},{\"name\":\"SO_KNREF_HEAD\",\"group\":\"allIssues\"},{\"name\":\"DL_VBELN\",\"group\":\"allIssues\"},{\"name\":\"DL_ERDAT\",\"group\":\"allIssues\"},{\"name\":\"DL_POSNR\",\"group\":\"allIssues\"},{\"name\":\"DL_LFIMG\",\"group\":\"allIssues\"},{\"name\":\"DL_LFART\",\"group\":\"allIssues\"},{\"name\":\"SO_DEV_CONF_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_DUE_DATE\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL_SENT_ON\",\"group\":\"allIssues\"},{\"name\":\"TM_DPTEN\",\"group\":\"allIssues\"},{\"name\":\"TM_DPTBG\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_I_VBELN\",\"group\":\"allIssues\"},{\"name\":\"TM_TDLNR\",\"group\":\"allIssues\"},{\"name\":\"SO_REQ_TEXT\",\"group\":\"allIssues\"},{\"name\":\"SO_EMAIL_SEND_DATE_F\",\"group\":\"allIssues\"},{\"name\":\"SO_VBUND\",\"group\":\"allIssues\"},{\"name\":\"SO_GUSCON_LEVEL\",\"group\":\"allIssues\"},{\"name\":\"SO_HTEXT\",\"group\":\"allIssues\"},{\"name\":\"SO_INCO1\",\"group\":\"allIssues\"},{\"name\":\"SO_INCO2\",\"group\":\"allIssues\"},{\"name\":\"SO_ISSUE_LOCATION\",\"group\":\"allIssues\"},{\"name\":\"SO_ISSUE_LOCATION_ITEM\",\"group\":\"allIssues\"},{\"name\":\"SO_PSTYV\",\"group\":\"allIssues\"},{\"name\":\"SO_F_PSMNG\",\"group\":\"allIssues\"},{\"name\":\"SO_BASF_LOFCR\",\"group\":\"allIssues\"},{\"name\":\"LAST_NOTE\",\"group\":\"allIssues\"},{\"name\":\"SO_FOLLOWUP_NOTES_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_LEVEL_TYPE\",\"group\":\"allIssues\"},{\"name\":\"SO_F_LDDAT\",\"group\":\"allIssues\"},{\"name\":\"DL_LDDAT\",\"group\":\"allIssues\"},{\"name\":\"SO_MATNR\",\"group\":\"allIssues\"},{\"name\":\"SO_DISPO\",\"group\":\"allIssues\"},{\"name\":\"SO_NETWR\",\"group\":\"allIssues\"},{\"name\":\"SO_N_VBELN\",\"group\":\"allIssues\"},{\"name\":\"SO_NPS\",\"group\":\"allIssues\"},{\"name\":\"BL_XBLNR\",\"group\":\"allIssues\"},{\"name\":\"SO_NY_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"SO_POSNR\",\"group\":\"allIssues\"},{\"name\":\"SO_AUART\",\"group\":\"allIssues\"},{\"name\":\"TM_STTRG\",\"group\":\"allIssues\"},{\"name\":\"SO_ZTERM\",\"group\":\"allIssues\"},{\"name\":\"DL_PEND_DEL_QUAN\",\"group\":\"allIssues\"},{\"name\":\"DL_LFDAT\",\"group\":\"allIssues\"},{\"name\":\"DL_WADAT\",\"group\":\"allIssues\"},{\"name\":\"SO_WERKS\",\"group\":\"allIssues\"},{\"name\":\"SO_F_WERKS\",\"group\":\"allIssues\"},{\"name\":\"SO_BSARK\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VKORG\",\"group\":\"allIssues\"},{\"name\":\"SO_KBETR\",\"group\":\"allIssues\"},{\"name\":\"SO_PRSDT\",\"group\":\"allIssues\"},{\"name\":\"SO_F_AUFNR\",\"group\":\"allIssues\"},{\"name\":\"SO_KOSCH\",\"group\":\"allIssues\"},{\"name\":\"SO_BSTKD\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_04_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_03_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_01_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_05_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_REASON_CODE_02_LANG\",\"group\":\"allIssues\"},{\"name\":\"SO_ABGRU\",\"group\":\"allIssues\"},{\"name\":\"SO_KWMENG\",\"group\":\"allIssues\"},{\"name\":\"SO_ROUTE\",\"group\":\"allIssues\"},{\"name\":\"SO_VKGRP\",\"group\":\"allIssues\"},{\"name\":\"SO_VKBUR\",\"group\":\"allIssues\"},{\"name\":\"SO_ZZDKPPRODB\",\"group\":\"allIssues\"},{\"name\":\"SO_ORT01\",\"group\":\"allIssues\"},{\"name\":\"SO_LAND1\",\"group\":\"allIssues\"},{\"name\":\"TM_TKNUM\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_ALERT\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_CURRENT_STATUS\",\"group\":\"allIssues\"},{\"name\":\"TM_SHIPMENT_ETA_UPDATED\",\"group\":\"allIssues\"},{\"name\":\"SO_F_VSBED\",\"group\":\"allIssues\"},{\"name\":\"TM_VSART\",\"group\":\"allIssues\"},{\"name\":\"SO_F_LGORT\",\"group\":\"allIssues\"},{\"name\":\"SO_SUPPLY_SITUATION\",\"group\":\"allIssues\"},{\"name\":\"SO_TRAGR\",\"group\":\"allIssues\"},{\"name\":\"SO_F_TDDAT\",\"group\":\"allIssues\"},{\"name\":\"SO_UNCONFIRMED_QTY\",\"group\":\"allIssues\"},{\"name\":\"SO_VE_PARTNER\",\"group\":\"allIssues\"},{\"name\":\"TM_EXTI1\",\"group\":\"allIssues\"}]",
                            "filterBarVariant": "{\"SO_EDATU_REQUESTED\":{\"conditionTypeInfo\":{\"name\":\"ordermonitoring.openorders.controller.dateRangeCustom\",\"data\":{\"operation\":\"THISMONTH\",\"value1\":null,\"value2\":null,\"key\":\"SO_EDATU_REQUESTED\",\"calendarType\":\"Gregorian\"}},\"ranges\":[{\"operation\":\"BT\",\"value1\":\"2024-11-01T00:00:00.000\",\"value2\":\"2024-11-30T23:59:59.999\",\"exclude\":false,\"keyField\":\"SO_EDATU_REQUESTED\",\"tokenText\":null}],\"items\":[]},\"_CUSTOM\":{\"shipmentEta\":\"\"}}",
                            "singleInputsTextArrangementData": "{}"
                        }
                    },
                    "texts": {
                        "variantName": {
                            "value": "Standard Testing QA",
                            "type": "XFLD"
                        }
                    },
                    "favorite": true,
                    "executeOnSelection": false,
                    "contexts": {},
                    "selector": {
                        "persistencyKey": "pageVariantKey"
                    },
                    "standardVariant": false,
                    "variantId": "id_1730971062555_603_page",
                    "creation": "2024-11-07T09:17:43.5506070Z"
                },
                {
                    "changeType": "defaultVariant",
                    "reference": "ordermonitoring.openorders",
                    "namespace": "apps/ordermonitoring.openorders/changes/",
                    "creation": "2024-07-31T16:00:13.4701680Z",
                    "projectId": "ordermonitoring.openorders",
                    "support": {
                        "generator": "CompVariantState.defaultVariant",
                        "user": "GARCID42",
                        "sapui5Version": "1.126.0"
                    },
                    "originalLanguage": "ES",
                    "layer": "USER",
                    "fileType": "change",
                    "fileName": "id_1722441612547_1760_defaultVariant",
                    "content": {
                        "defaultVariantName": "id_1730717810990_164_page"
                    },
                    "texts": {},
                    "selector": {
                        "persistencyKey": "pageVariantKey"
                    },
                    "dependentSelector": {}
                },
                {
                    "changeType": "updateVariant",
                    "reference": "ordermonitoring.openorders",
                    "namespace": "apps/ordermonitoring.openorders/changes/",
                    "creation": "2024-11-04T10:56:52.1864450Z",
                    "projectId": "ordermonitoring.openorders",
                    "packageName": "",
                    "support": {
                        "generator": "FlexObjectFactory.createFromFileContent",
                        "user": "GARCID42",
                        "sapui5Version": "1.129.2"
                    },
                    "originalLanguage": "EN",
                    "layer": "USER",
                    "fileType": "change",
                    "fileName": "id_1730717810990_165_updateVariant",
                    "content": {
                        "favorite": true,
                        "executeOnSelection": false
                    },
                    "texts": {},
                    "selector": {
                        "persistencyKey": "pageVariantKey",
                        "variantId": "id_1730717810990_164_page"
                    },
                    "dependentSelector": {}
                }
            ],
            "contexts": [],
            "variantSection": {},
            "ui2personalization": {},
            "settings": {
                "isKeyUser": true,
                "isAtoAvailable": true,
                "isAtoEnabled": false,
                "isProductiveSystem": true,
                "isVariantSharingEnabled": true,
                "isZeroDowntimeUpgradeRunning": false,
                "system": "ZHL",
                "client": "100"
            }
        }
        
		var outer = {
			'changes': [],
			'settings': {
				"isKeyUser": true,
                "isAtoAvailable": true,
                "isAtoEnabled": false,
                "isProductiveSystem": true,
                "isVariantSharingEnabled": true,
                "isZeroDowntimeUpgradeRunning": false,
                "system": "ZHL",
                "client": "100"
			}
		};

        userVariants.forEach(function(variant){
            var body = {};
            body.fileName = variant.fileName;
            body.fileType = variant.fileType;
            body.changeType = variant.changeType;
            body.conditions = JSON.parse(variant.conditions);
            body.content = JSON.parse(variant.content);
            body.contexts = {}; // changed
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
            body.projectId = "ordermonitoring.openorders"; // missing
            body.standardVariant = false; // missing
            body.favorite = true; // missing
            body.executeOnSelection = false; // missing
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

    app.put('/variants/:fileName', async (req, res) => {
        const { Variants } = await cds.entities("srvOpenOrders");
		var body = req.body;
        var userId = "GARCID42" //req.user.id;
		var fileNameInput = req.params.fileName;

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
            contexts: body.contexts,
            supportGenerator: generator,
            supportService: service,
            supportUser: userId,
            layer: body.layer,
            selector: JSON.stringify(body.selector),
            texts: JSON.stringify(body.texts),
            variantName: variantName,
            variantId: body.variantId
        }];
        try{
            var entry = await SELECT.from(Variants).where `changeType = ${body.changeType} 
                and fileType = ${body.fileType} 
                and layer = ${body.layer} 
                and supportUser = ${userId} 
                and variantName = ${variantName}`;
            if(entry.length > 0){
                variantData[0].id = entry[0].id;
                await UPSERT.into(Variants).entries(variantData);
                // res.type('application/json').status(200).send(body);
            }else{
                await INSERT.into(Variants).entries(variantData);
            }
            // await UPSERT.into(Variants).entries(variantData).where `fileName = ${fileNameInput}`;
            res.type('application/json').status(200).send(body);
        }catch(err){
            res.type('text/plain').status(500).send(`ERROR: ${err.toString()}`);
           return;
        }

	});
})
module.exports = cds.server