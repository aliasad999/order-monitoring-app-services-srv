const cds = require("@sap/cds");
const NodeCache = require('node-cache');
const sessionCache = new NodeCache();
const uuid = require('uuid');
const status = require('http-status').status;

const log = require("cf-nodejs-logging-support");
const { startOfToday } = require('date-fns');
const formatSpecialCurrencies = require('./plugins/formatSpecialCurrencies')
const serviceHelper = require('./utils/serviceHelper');

class openOrdersSrv extends cds.ApplicationService {

    async init() {
        // only needed to run this when the server is starting
        const { allIssues } = cds.entities('openOrdersSrv')
        this._textKeys = []
        this._SpecialCurrencies = []
        const { currencies } = cds.entities('openOrdersSrv');
        this._SpecialCurrencies = await SELECT.from(currencies)
        let data = allIssues.elements
        for (let key in data) {
            if (data[key]["@Common.Text"] && data[key]["@Common.Text"]["="]) {
                switch (key) {
                    case 'SO_NPS':
                        this._textKeys.push({ key: key, value: 'SO_NPS' });
                        break;
                    case 'SO_ISSUE':
                        this._textKeys.push({ key: key, value: 'SO_ISSUE' });
                        break;
                    case 'SO_DCP_ITEM_STATUS':
                        this._textKeys.push({ key: key, value: 'SO_DCP_ITEM_STATUS' });
                        break;
                    default:
                        this._textKeys.push({ key: key, value: data[key]["@Common.Text"]["="] });
                        break;
                }
            }
        }
        // only needed to run this when the server is starting
        this.before('*', '*', async (req, next) => {
            await cds.run(`SET 'APPLICATION' = 'CAPServices'`);
        })

        // GET SAP TEXTS //
        this.on("getSAPTexts", async req => {
            let SAPTextsEntity = [];
            let SAPTexts = [];
            let salesOrder = req.data.salesOrder;
            let salesOrderItem = req.data.salesOrderItem;
            let orderSystem = req.data.orderSystem;
            // Purchase order Text
            const { Results } = cds.entities('srvOpenOrders')
            let POData = await SELECT.distinct.from(Results).columns(["PO_MANDT", "PO_EBELN", "PO_EBELP"])
                .where`SO_VBELN = ${salesOrder} and SO_POSNR = ${salesOrderItem} and SO_MANDT = ${orderSystem} and PO_MANDT <> null`;
            if (POData.length > 0 && POData[0].PO_MANDT === "100") {
                const { PO_EBELN, PO_EBELP } = POData[0];
                const SAPTextsService = await cds.connect.to('DSLServicesService');
                SAPTexts = await SAPTextsService.run(SELECT.from('SAPTextsSet').where({
                    TextId: 'F15',
                    TextName: `${PO_EBELN}${PO_EBELP}`,
                    TextObject: 'EKPO'
                }));
                if (SAPTexts.length > 0) {
                    SAPTexts.forEach((text) => {
                        SAPTextsEntity.push({
                            TextId: text.TextId,
                            SAPText: text.Text.replaceAll("--", "\r\n"),
                            KeyText: serviceHelper.getBundle(req.locale).getText(`SAPText${text.TextId}`),
                            TextLanguage: text.TextLang
                        })
                    })
                }
            }

            switch (orderSystem) {
                case "100": // Cobalt   
                    let textObjectsData = [
                        {
                            id: "ZAI1",
                            onItem: false
                        },
                        {
                            id: "ZAV1",
                            onItem: false
                        },
                        {
                            id: "ZA16",
                            onItem: true
                        },
                        {
                            id: "ZA10",
                            onItem: true
                        },
                        {
                            id: "NFL",
                            onItem: true
                        }
                    ]

                    const SAPTextsService = await cds.connect.to('DSLServicesService');
                    for (var i = 0; i < textObjectsData.length; i++) {
                        let textObject = textObjectsData[i];
                        try {
                            let whereClause = `TextId = '${textObject.id}' and TextName = '${salesOrder}' and TextObject = 'VBBK'`;
                            if (textObject.onItem) {
                                whereClause = `TextId = '${textObject.id}' and TextName = '${salesOrder}${salesOrderItem}' and TextObject = 'VBBP'`;
                            }
                            SAPTexts = await SAPTextsService.run(SELECT.from('SAPTextsSet').where(whereClause))
                            if (SAPTexts.length > 0) {
                                SAPTexts.forEach((text) => {
                                    SAPTextsEntity.push({
                                        TextId: text.TextId,
                                        SAPText: text.Text.replaceAll("--", "\r\n"),
                                        KeyText: serviceHelper.getBundle(req.locale).getText(`SAPText${text.TextId}`),
                                        TextLanguage: text.TextLang
                                    })
                                })
                            }
                        } catch (error) {
                            if (!error.message.includes("No Data Found")) {
                                req.error(413, error)
                            }
                        }
                    }
                case "200": // EC
                    break;
                case "300": // AP
                    let headerTextIds = ["ZH09", "ZH10"]
                    let itemTextIds = ["ZI10"];
                    const APSAPTextsService = await cds.connect.to('APSalesOrderA2X');

                    const addTexts = (arrayOfTexts) => {
                        if (arrayOfTexts.length > 0) {
                            arrayOfTexts.forEach((text) => {
                                SAPTextsEntity.push({
                                    TextId: text.LongTextID,
                                    SAPText: text.LongText,
                                    KeyText: serviceHelper.getBundle(req.locale).getText(`SAPText${text.LongTextID}`),
                                    TextLanguage: text.Language
                                })
                            })
                        }
                    }

                    // Header
                    SAPTexts = await APSAPTextsService.run(SELECT.from('A_SalesOrderText').where({
                        SalesOrder: salesOrder,
                        LongTextID: { in: headerTextIds }
                    }))
                    addTexts(SAPTexts);

                    // Item
                    SAPTexts = await APSAPTextsService.run(SELECT.from('A_SalesOrderItemText').where({
                        SalesOrder: salesOrder,
                        SalesOrderItem: salesOrderItem,
                        LongTextID: { in: itemTextIds }
                    }))
                    addTexts(SAPTexts);

                    break;
            }

            return SAPTextsEntity;
        });


        // START OF REMOVE DELIVERY BLOCK //
        this.on("RemoveDeliveryBlock", async req => {
            let salesOrder = req.data.SalesOrderID;
            let salesOrderItem = req.data.ItemID;
            let functionPath = `/RemoveDeliveryBlock?SalesOrderID='${salesOrder}'&ItemID='${salesOrderItem}'`
            try {
                const LORDOdataOrderService = await cds.connect.to('LORDOdataOrderService');
                var releaseBillingBlockCall = await LORDOdataOrderService.tx(req).send({
                    method: "POST",
                    path: functionPath
                });
            } catch (error) {
                req.error(413, error)
            }

            let response = "SUCCESS"
            return response;
        });

        this.on("UPDATE", "LORDHeaderSet", async req => {
            try {
                const LORDOdataOrderService = await cds.connect.to('LORDOdataOrderService');
                let updateReq = await LORDOdataOrderService.tx(req).send({
                    query: req.query
                });

                return updateReq;

            } catch (error) {
                if (error.reason.response.status === 204) {
                    // This is actually not an error - supress it 
                    return null;
                } else {
                    req.error(413, error)
                }
            }
        })

        this.on("UPDATE", "LORDItemSet", async req => {
            try {
                const LORDOdataOrderService = await cds.connect.to('LORDOdataOrderService');
                let updateReq = await LORDOdataOrderService.tx(req).send({
                    query: req.query
                });

                return updateReq;

            } catch (error) {
                if (error.reason.response.status === 204) {
                    // This is actually not an error - supress it 
                    return null;
                } else {
                    req.error(413, error)
                }
            }
        })
        // END OF REMOVE DELIVERY BLOCK //

        this.on("cancelOrder", async req => {
            let reqData = JSON.parse(req.data); // parse stringified object

            try {
                const OrderChangeService = await cds.connect.to('S4OrderChangeService');
                var cancelOrderCall = await OrderChangeService.tx(req).send({
                    method: "POST",
                    path: "/directOrderChange",
                    data: reqData
                });
            } catch (error) {
                req.error(413, error)
            }

            let response = "SUCCESS"
            return response;
        });

        this.on("READ", "RejCodesSet", async (req, next) => {
            let rejectCodes = [];
            try {
                const CSEUCockpitService = await cds.connect.to('CSEUCockpitService');
                rejectCodes = await CSEUCockpitService.tx(req).send({
                    query: req.query
                });
            } catch (error) {
                req.error(413, error)
            }

            return rejectCodes;
        });

        this.on("submitOrderChangeWF", async req => {
            let parsedPayload = JSON.parse(req.data.payload); // parse stringified object

            try {
                const orderChangeService = await cds.connect.to('S4OrderChangeService');
                var bizagiCaseCreationCall = await orderChangeService.tx(req).send({
                    method: "POST",
                    path: "/workflowOrderChange",
                    data: {
                        payload : parsedPayload
                    }
                });
            } catch (error) {
                req.error(413, error)
            }

            return bizagiCaseCreationCall
        });

        this.on("submitOrderChange", async req => {
            let reqData = JSON.parse(req.data.payload); // parse stringified object
            let postData = {
                payload: {
                    "Order": reqData.SalesOrder,
                    "OrderItem": reqData.SalesOrderItem,
                    "Internal": reqData.Internal,
                    "RequestedScheduleLines": {
                        "Date": reqData.RequestedScheduleLines.Date,
                        "Quantity": reqData.RequestedScheduleLines.Quantity,
                        "Unit": reqData.RequestedScheduleLines.Unit
                    }
                }
            };

            try {
                // directOrderChange - endpoint
                // S4OrderChangeService - service
                const orderChangeSAPSrv = await cds.connect.to('S4OrderChangeService');
                let directSAPChangeCall = await orderChangeSAPSrv.tx(req).send({
                    method: "POST",
                    path: "/directOrderChangeV2",
                    data: postData
                });
            } catch (error) {
                req.error(413, error)
            }

            let response = {
                response: "Everything went well"
            }
            return JSON.stringify(response);
        });

        this.on("CREATE", "SalesOrderHeaderSet", async (req) => {
            try {
                const orderChangeSAPSrv = await cds.connect.to('YRDSDV1Foe1Service');
                let postReq = await orderChangeSAPSrv.tx(req).send({
                    query: req.query
                });

                return postReq;

            } catch (error) {
                req.error(413, error)
            }

        })

        this.on("isOrderChangeable", async req => {
            let SalesOrderNumber = req.data.salesOrder; 
            let SalesOrderItem = req.data.salesOrderItem;
            let orderChangeTabData = {};
            const orderChangeService = await cds.connect.to('S4OrderChangeService');

            try {
                orderChangeTabData = await orderChangeService.send({
                    method: "GET",
                    path: `/isOrderChangeable?salesOrder='${SalesOrderNumber}'&salesOrderItem='${SalesOrderItem}'`
                });
            } catch (error) {
                req.error(413, error)
            }
            // orderChangeTabData.OrdSchedConf[0].SlDate = new Date()
            return orderChangeTabData
        });

        this.on("isOrderChangeableV2", async req => {
            let SalesOrderNumber = req.data.salesOrder; 
            let SalesOrderItem = req.data.salesOrderItem;
            let finalData = {}

            let orderChangeTabData = {};
            let scheduleLines = {};
            const orderChangeService = await cds.connect.to('S4OrderChangeService');
            const APSalesOrderA2X = await cds.connect.to('APSalesOrderA2X');
            try {
                orderChangeTabData = await orderChangeService.send({
                    method: "GET",
                    path: `/isOrderChangeableV2?order='${SalesOrderNumber}'&orderItem='${SalesOrderItem}'`
                });

                scheduleLines = await APSalesOrderA2X.send({
                    method: "GET",
                    path: `/A_SalesOrderItem(SalesOrder='${SalesOrderNumber}',SalesOrderItem='${SalesOrderItem}')/to_ScheduleLine` 
                });

                if(orderChangeTabData){
                    finalData = {
                        Editable: orderChangeTabData.Editable,
                        DirectChange: orderChangeTabData.DirectChange,
                        WorkflowChange: orderChangeTabData.WorkflowChange,
                        CancelFlag: orderChangeTabData.CancelFlag,
                        BizagiCaseInProgress: false, // always false
                        FinalOrder: orderChangeTabData.FinalOrder,
                        FinalItem: orderChangeTabData.FinalItem,
                        FirstOrder: orderChangeTabData.FirstOrder,
                        FirstItem: orderChangeTabData.FirstItem,
                        SalesOrder: orderChangeTabData.SalesOrder,
                        SalesOrderItem: orderChangeTabData.SalesOrderItem,
                        OrdSchedReq: [],
                        OrdSchedConf: []
                    }
                    if(scheduleLines.length > 0){
                        scheduleLines.forEach((schedLine) => {
                            // Requested Schedule Lines
                            finalData.OrdSchedReq.push({
                                Quantity: schedLine.ScheduleLineOrderQuantity,
                                SalesUnit: schedLine.OrderQuantitySAPUnit,
                                SlDate: schedLine.RequestedDeliveryDate ,
                                SlNum: schedLine.ScheduleLine
                            });
                            // Confirmed Schedule Lines
                            if(schedLine.ConfirmedDeliveryDate){
                                finalData.OrdSchedConf.push({
                                    Quantity: schedLine.ConfdOrderQtyByMatlAvailCheck,
                                    SalesUnit: schedLine.OrderQuantitySAPUnit,
                                    SlDate: schedLine.ConfirmedDeliveryDate,
                                    SlNum: schedLine.ScheduleLine
                                });
                            }
                        })
                        
                    }
                }

            } catch (error) {
                req.error(413, error)
            }
            return finalData
        });

        this.on("READ", "ContactSet", async (req, next) => {
            let lt_contacts = [];
            if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count') {
                try {
                    // GET Filters as an object from WHERE Clause
                    const filtersAsObject = req.query.SELECT.where.reduce((obj, item, index, arr) => {
                        // If item has ref, then look for val
                        if (item.ref) {
                            // Look for the next val value
                            for (let i = index + 1; i < arr.length; i++) {
                            if (arr[i].val) {
                                obj[item.ref[0]] = arr[i].val;
                                break;
                            }
                            }
                        }
                        return obj;
                    }, {});
                    let language = req.locale.toUpperCase();
                    if (req.headers.so_mandt && ( req.headers.so_mandt == '300' || req.headers.so_mandt == '400')) { // AP or Mercury
                        let addGTSContacts = req.headers.add_gts_contacts;
                        let OMServices = await cds.connect.to('OMServicesAP'); // AP
                        let systemClient = process.env.AP_CLIENT;
                        if(req.headers.so_mandt == '400'){
                            OMServices = await cds.connect.to('OMServicesMercury'); // Mercury
                            systemClient = '100';
                        }
                        // get a random number for the personal number of the contact to avoid duplicates
                        const getRandomInt = function (min, max) {
                            const minCeiled = Math.ceil(min);
                            const maxFloored = Math.floor(max);
                            return Math.floor(Math.random() * (maxFloored - minCeiled) + minCeiled); // The maximum is exclusive and the minimum is inclusive
                        }
                        const LPadOrderItem = filtersAsObject.OrderItem.replace(/^0+/, "") || "0";
                        const ltPartners = await OMServices.send({
                            method: 'GET',
                            query: SELECT.from('SalesOrderPartner').where`(SalesOrder = ${filtersAsObject.SalesDocument} and SalesOrderItem = '000000') or (SalesOrder = ${filtersAsObject.SalesDocument} and SalesOrderItem = ${LPadOrderItem})`,
                            headers: {
                                'X-Basf-Sap-Client': systemClient
                            }
                        });
                        let CMEntry = {}
                        ltPartners.forEach((item) => {
                            CMEntry = {
                                "SapClient": req.headers.so_mandt,
                                "PersonalName": item.FullName,
                                "EmailAddress": item.EmailAddress,
                                "PhoneNumber": item.PhoneNumber,
                                "PersonalNumber": getRandomInt(1, 99999999),
                                "SalesDocument": item.SalesOrder,
                                "OrderItem": item.SalesOrderItem,
                                "PartnerFunction": item.PartnerFunction
                            }
                            lt_contacts.push(CMEntry);
                        })

                        if(addGTSContacts){
                            const OMServicesAP = await cds.connect.to('OMServicesAP');
                            let issueData = JSON.parse(req.headers.issue_data);
                            let entity = "OrderGTSBlocks";
                            let whereClause = `SalesDocument = '${issueData.issueLocation}' and SalesDocumentItem = '${issueData.issueLocationItem}'`;
                            // gts block is in outbound delivery
                            if (issueData.issueLoctionDocType === "J") {
                                entity = "DeliveryGTSBlocks";
                                whereClause = `DeliveryDocument = '${issueData.issueLocation}' and DeliveryDocumentItem = '${issueData.issueLocationItem}'`;
                            }
                            let gtsBlockReasons = await OMServicesAP.send({
                                method: 'GET',
                                query: SELECT.from(entity).where(whereClause),
                                headers: {
                                    'X-Basf-Sap-Client': process.env.AP_CLIENT
                                }
                            });
                            gtsBlockReasons.forEach((gtsBlockReasons) =>{
                                let GTSEntry = {
                                    "SapClient": req.headers.so_mandt,
                                    "PersonalName": "",
                                    "EmailAddress": "",
                                    "PhoneNumber": "",
                                    "PersonalNumber": getRandomInt(1, 99999999),
                                    "SalesDocument": "",
                                    "OrderItem": "",
                                    "PartnerFunction": ""
                                }
                                if(gtsBlockReasons.EmbargoStatus !== "A"){
                                    GTSEntry.EmailAddress = "NA-Trade-Compliance@basf.com";
                                    GTSEntry.PersonalName = "Embargo Blocks Contact";
                                }
                                if(gtsBlockReasons.ScreeningStatus !== "A"){
                                    GTSEntry.EmailAddress = "gts-trade-control@basf.com"; // TODO change to spl-global@basf.com by end of november
                                    GTSEntry.PersonalName = "SPL Blocks Contact";
                                }
                                if(gtsBlockReasons.LegalControlStatus !== "A"){
                                    GTSEntry.EmailAddress = "GTS-Legal-Reg-AP@basf.com";
                                    GTSEntry.PersonalName = "Legal Blocks Contact";
                                }
                                lt_contacts.push(GTSEntry);
                            })
                        }

                    }else {
                        // Run queries
                        const apiManagementService = await cds.connect.to('ContactsService');
                        let whereClause = `SalesDocument = '${filtersAsObject.SalesDocument}' and OrderItem = '${filtersAsObject.OrderItem}'`;
                        if(filtersAsObject.Material){
                            whereClause += ` and Material = '${filtersAsObject.Material}'`
                        }
                        lt_contacts = await apiManagementService.tx(req).send({
                            query: SELECT.from('ContactSet').where(whereClause)  //req.query
                        });
                    }
                    const creditManagerService = await cds.connect.to('CreditManagerService');
                    let creditMngrQuery = SELECT.from('CreditManagerSet').byKey({ OrderNumber: filtersAsObject.SalesDocument, Language: language });
                    let creditManager = await creditManagerService.tx(req).send({
                        query: creditMngrQuery
                    });
                    if (creditManager && creditManager.NameCreditManager) {
                        let CMEntry = {
                            "SapClient": req.headers.so_mandt ?? "100",
                            "PersonalName": creditManager.NameCreditManager,
                            "EmailAddress": creditManager.SmtpAddress,
                            "PhoneNumber": creditManager.TelnrCall,
                            "PersonalNumber": null,
                            "SalesDocument": filtersAsObject.SalesDocument,
                            "OrderItem": filtersAsObject.OrderItem,
                            "PartnerFunction": creditManager.PartnerRole
                        }
                        lt_contacts.push(CMEntry);
                    }

                } catch (error) {
                    // log.error("[order-monitoring-app-services.js] - Remote service to Cobalt failed ! " + JSON.stringify(error));
                    req.error(413, error)
                }
            } else {
                lt_contacts.push({ $count: 0 })
            }
            return lt_contacts;
        });

        this.on("READ", "ServicesSet", async (req, next) => {
            let lt_services = [];
            try {
                const apiManagementService = await cds.connect.to('DSLServicesService');
                lt_services = await apiManagementService.tx(req).send({
                    query: req.query
                });
            } catch (error) {
                req.error(413, error)
            }

            return lt_services;
        });

        /**
      * This event is triggered before the backend request for order list data
      * @param {string} "READ" - The type of backend request
      * @param {string} "valueHelps" - The name of the entity set
      * @param {function} - The callback function containing the code that runs when the event is triggered
      * @param {object} req - The request object containing request details
      * */
        this.before("READ", "valueHelps", async (req) => {
            // Check if auth table is filled
            if (req.user.id !== "anonymous") {
                const { VBAKAuthObjectKeys } = await cds.entities('srvOpenOrders');
                let userID = req.user.id;
                let authSet = await SELECT.from(VBAKAuthObjectKeys).where({ USERID: userID });
                if (authSet.length === 0) {
                    req.error(413, 'NO_AUTH_VALUE_HELP')
                }
            }
        });


        /**
        * This event is triggered after the backend request for value help data
        * @param {string} "READ" - The type of backend request
        * @param {string} "valueHelps" - The name of the entity set
        * @param {function} - The callback function containing the code that runs when the event is triggered
        * @param {object} req - The request object containing request details
        * */
        this.on("READ", "valueHelps", async (req, next) => {
            // get the session id based on auth token
            let sessionID = req.headers['authorization'] || req.headers['x-username'];
            const queryId = `${sessionID}AMOOQuery`
            const db = cds.tx(req);
            let lt_result = []
            // if session id is there, get the cach-ed query and execute it.
            if (sessionCache.get(queryId)) {
                const queryString = sessionCache.get(queryId);
                const query = JSON.parse(queryString);
                query.SELECT.from.ref[0] = 'openOrdersSrv.allIssues'
                // make sure pagination is taken into account
                // if (query.SELECT.limit.rows.val) query.SELECT.limit.rows.val = req.query.SELECT.limit.rows?.val;
                //query.SELECT.distinct = true;
                // if any lowerCaseSearchString is added in search field, that should be taken into account as well
                //query.SELECT.search = req.query.SELECT.search;
                let searchString = req.http.req.query["$search"] && req.http.req.query["$search"].replace(/"/g, '')
                let lowerCaseSearchString = searchString && `%${searchString.toLowerCase()}%`
                if (lowerCaseSearchString) {
                    let where = []
                    if (req.http.req.query['$select'] && req.http.req.query['$select'].split(',').length > 1) {
                        where = cds.parse.expr(`lower(${req.http.req.query['$select'].split(',')[1]}) like '${lowerCaseSearchString}' ESCAPE '^' OR lower(${req.http.req.query['$select'].split(',')[0]}) like '${lowerCaseSearchString}' ESCAPE '^'`);
                    } else {
                        where = cds.parse.expr(`lower(${req.http.req.query['search-focus']}) like '${lowerCaseSearchString}' ESCAPE '^'`);
                    }
                    let requestQuery = query.SELECT.where || [];
                    where && requestQuery.length != 0 && requestQuery.push('and');
                    where && requestQuery.push(where);
                    query.SELECT.where = requestQuery
                }
                // if (query.SELECT.limit.offset && query.SELECT.limit.offset.val && query.SELECT.limit.offset.val) query.SELECT.limit.offset.val = req.query.SELECT.limit.offset?.val || 0;
                if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count') {
                    // ISSUE 343357 
                    // add skip and top parameters from real query
                    query.SELECT.limit = req.query.SELECT.limit;
                    // End of ISSUE 343357
                    query.SELECT.columns.length = 0;
                    query.SELECT.columns = req.query.SELECT.columns;
                    if (query.SELECT.orderBy) query.SELECT.orderBy.length = 0;
                    query.SELECT.orderBy = req.query.SELECT.orderBy;
                    try {
                        lt_result = await db.run(query)
                        //lt_result = await cds.run(query);
                        // req.header.select will have the string of visible columns. 
                        //this parameater has been manually set to header on every request
                        const selectedField = req.http.req.query && req.http.req.query['$select']
                        let fields = selectedField && selectedField.split(',');
                        if (fields) {
                            fields = fields.filter((fieldName) => {
                                const mandtFields = serviceHelper.getMandtFields();
                                const mandtTextFields = mandtFields.map((mandtFieldName) => mandtFieldName + "_TEXT");
                                if (mandtTextFields.includes(fieldName)) {
                                    return false;
                                } else {
                                    return true;
                                }
                            });
                            // remove duplicates based on fields in the valuehelp dialog box
                            lt_result = serviceHelper.removeDuplicates(fields, lt_result);
                        }
                    } catch (error) {
                        log.error("AMOO VH with Session: " + error.message + " || " + req.user.id + " || " + JSON.stringify(req.query.SELECT) + " || " + JSON.stringify(req.query.SELECT.where));
                        req.error(status.EXPECTATION_FAILED, serviceHelper.getBundle(req.locale).getText("VALUEHELP_NOT_EXECUTED"))
                    }
                } else {
                    try {
                        const fields = req.http.req.query["search-focus"].split(',')
                        let queryCount = 0;
                        // We need an orderBy clause to make the query performant
                        let keyField = fields[0];
                        let subquery = SELECT.distinct(...fields)
                            .from('openOrdersSrv.allIssues')
                            .orderBy(keyField)
                            .hints('USE_HEX_PLAN', 'HEX_INDEX_JOIN');
                        // Add where clause if needed
                        if (query.SELECT.where) {
                            subquery = subquery.where(query.SELECT.where);
                        }
                        // Run the count query
                        const distinctCount = await SELECT.from(subquery).columns('count(*) as total');
                        if (distinctCount.length > 0) {
                            queryCount = distinctCount[0].total;
                        }
                        lt_result.push({ $count: queryCount })
                    } catch (error) {
                        log.error("AMOO VH count with Session: " + error.message + " || " + req.user.id + " || " + JSON.stringify(req.query.SELECT) + " || " + JSON.stringify(req.query.SELECT.where));
                        req.error(status.EXPECTATION_FAILED, serviceHelper.getBundle(req.locale).getText("VALUEHELP_NOT_EXECUTED"))
                    }

                }

            } else {
                const fields = req.http.req.query && req.http.req.query["search-focus"] && req.http.req.query["search-focus"].split(',')
                if (!fields) {
                        req.error(status.EXPECTATION_FAILED, 'ERR_VALUE_HELP_NO_CACHE')
                        log.error(`[order-monitoring-app-services.js] - AMOO VH without Session search-focus undefined:  user: ${req.user.id} SELECT:${JSON.stringify(req.query.SELECT)} WHERE:${JSON.stringify(req.query.SELECT.where)}`);
                        return;
                    }
                // if there is no session id, execute the query directly
                let searchString = req.http.req.query["$search"] && req.http.req.query["$search"].replace(/"/g, '')
                let lowerCaseSearchString = searchString && `%${searchString.toLowerCase()}%`
                if (lowerCaseSearchString) {
                    let where = []
                    if (req.http.req.query['$select'] && req.http.req.query['$select'].split(',').length > 1) {
                        where = cds.parse.expr(`lower(${req.http.req.query['$select'].split(',')[1]}) like '${lowerCaseSearchString}' ESCAPE '^' OR lower(${req.http.req.query['$select'].split(',')[0]}) like '${lowerCaseSearchString}' ESCAPE '^'`);
                    } else {
                        where = cds.parse.expr(`lower(${req.http.req.query['search-focus']}) like '${lowerCaseSearchString}' ESCAPE '^'`);
                    }
                    let requestQuery = req.query.SELECT.where || [];
                    where && requestQuery.length != 0 && requestQuery.push('and');
                    where && requestQuery.push(where);
                    req.query.SELECT.where = requestQuery
                    // delete req.query.SELECT.search
                }
                if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count') {
                    let finalQuery = SELECT.distinct.from(allIssues).columns(req.query.SELECT.columns).where(req.query.SELECT.where).orderBy(req.query.SELECT.orderBy);
                    // req.query.SELECT.distinct = true;
                    try {
                        lt_result = await db.run(finalQuery)
                    } catch (error) {
                        log.error("AMOO VH without Session: " + error.message + " || " + req.user.id + " || " + JSON.stringify(req.query.SELECT) + " || " + JSON.stringify(req.query.SELECT.where));
                        req.error(error)
                    }
                    //await cds.run(req.query);
                } else {
                    try {
                        let queryCount = 0;
                        // We need an orderBy clause to make the query performant
                        let keyField = fields[0];
                        let subquery = SELECT.distinct(...fields)
                            .from('openOrdersSrv.allIssues')
                            .orderBy(keyField)
                            .hints('USE_HEX_PLAN', 'HEX_INDEX_JOIN');
                        // Add where clause if needed
                        if (req.query.SELECT.where) {
                            subquery = subquery.where(req.query.SELECT.where);
                        }

                        // Run the count query
                        const distinctCount = await SELECT.from(subquery).columns('count(*) as total');
                        if (distinctCount.length > 0) {
                            queryCount = distinctCount[0].total;
                        }
                        lt_result.push({ $count: queryCount })
                    } catch (error) {
                        log.error("AMOO VH count without Session: " + error.message + " || " + req.user.id + " || " + JSON.stringify(req.query.SELECT) + " || " + JSON.stringify(req.query.SELECT.where));
                        req.error(error)
                    }

                }
            }
            if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count' && req.query.SELECT.search) {
                lt_result = lt_result.filter((item) => {
                    for (const prop in item) {
                        if (item[prop] === null) return false;
                        // convert to lowercase both sides in order to avoid case sensitivity issues when searching
                        if (item[prop].toLowerCase().includes(req.query.SELECT.search[0].val.toLowerCase().replace(/^["']|["']$/g, ''))) {
                            return true;
                        }
                    }
                    return false;

                });
            }
            return lt_result;
        })



        /**
        * This event is triggered after the backend request for value help data
        * @param {string} "READ" - The type of backend request
        * @param {string} "valueHelps" - The name of the entity set
        * @param {function} - The callback function containing the code that runs when the event is triggered
        * @param {array} data - The array containing the result from the backend request
        * @param {object} req - The request object containing request details
        * */
        this.after("READ", "valueHelps", async (data, req) => {
            data = Array.isArray(data) ? data : [data]
            // since there is a virtual id field, adding a random guid to each record of the result set.
            data.forEach((item) => {
                item.id = uuid.v1()
                if ('SO_NPS' in item) item.SO_NPS_DESCRIPTION = serviceHelper.getBundle(req.locale).getText(`nps${item.SO_NPS}`)
                if ('SO_ISSUE' in item) item.SO_ISSUE_DESCRIPTION = serviceHelper.getBundle(req.locale).getText(`OrderIssue${item.SO_ISSUE}`)
                if ('SO_DCP_ITEM_STATUS' in item) {
                    if (item.SO_DCP_ITEM_STATUS) {
                        item.SO_DCP_ITEM_STATUS_DESCRIPTION = serviceHelper.getBundle(req.locale).getText(`dcpStatus${item.SO_DCP_ITEM_STATUS}`)
                    }
                }
                let mandtFields = serviceHelper.getMandtFields();
                // MANDANT TEXTS LOGIC -------------
                mandtFields.forEach((mandt) => {
                    const mandtProp = item[mandt];
                    if (mandtProp) {
                        let mandtTxtField = mandt + "_TEXT";
                        item[mandtTxtField] = serviceHelper.getMandtFieldsNames(mandtProp);
                    }
                })
            })

        });

        this.on("READ", "dueDateLimit", async (req, next) => {
            const db = cds.transaction(req);
            const result = await db.run(req.query)
            return result
        })
        this.on("CREATE", "dueDateLimit", async (req, next) => {
            const { dueDateLimit } = cds.entities('openOrdersSrv');
            await UPSERT.into(dueDateLimit).entries(req.query.INSERT.entries);
            return SELECT('*').from(dueDateLimit).byKey({ userId: req.query.INSERT.entries[0].userId })
        })
        this.on("createDeliveryforAllItem", async (req) => {
            const { allIssues } = cds.entities('openOrdersSrv');
            let lt_items = []
            let date = new Date()
            const lt_result = await SELECT.columns(['SO_VBELN', 'SO_POSNR', 'SO_DUE_DATE']).from(allIssues).where({ SO_VBELN: req.data.salesOrder, SO_NPS: '40' })
            lt_result.forEach((item) => {
                lt_items.push(item.SO_POSNR)
            })
            let biggerDate = lt_result.reduce((latest, current) => {
                const latestDate = parseDate(latest.SO_DUE_DATE);
                const currentDate = parseDate(current.SO_DUE_DATE);
                return currentDate > latestDate ? current : latest;
            });
            if (date > biggerDate.SO_DUE_DATE) biggerDate.SO_DUE_DATE = date;
            const oURLParam = {
                SalesOrderID: req.data.salesOrder,
                ItemIDs: lt_items.join(","),
                DueDate: biggerDate.SO_DUE_DATE.toISOString().split('.')[0],
                RollbackOnError: 0
            };
            const baseURL = 'CreateDeliveryForOrderItems';
            const queryString = encodeParams(oURLParam);
            const fullURL = `${baseURL}?${queryString}`;
            const createDelivery = await cds.connect.to('createDelivery');
            try {
                const responseDelivery = await createDelivery.tx(req).send({
                    method: req.http.req.method,
                    path: fullURL
                });
                return sendDeliveryResponse(req, responseDelivery)

            } catch (error) {
                req.error(status.PRECONDITION_FAILED,error.message);
            }
        })
        this.on("createDeliveryforItem", async (req) => {
            // CreateDeliveryForOrder?SalesOrderID='7012471445'&ItemID='20'
            const oURLParam = {
                SalesOrderID: req.data.salesOrder,
                ItemID: req.data.salesOrderItem
            };
            const baseURL = 'CreateDeliveryForOrder';
            const queryString = encodeParams(oURLParam);
            const fullURL = `${baseURL}?${queryString}`;
            const createDelivery = await cds.connect.to('createDelivery');
            try {
                const responseDelivery = await createDelivery.tx(req).send({
                    method: req.http.req.method,
                    path: fullURL,
                });
                return sendDeliveryResponse(req, responseDelivery)
            } catch (error) {
                req.error(status.PRECONDITION_FAILED,error.message);
            }
        })
        /**
         * This event is triggered before the backend request for order list data
         * @param {string} "READ" - The type of backend request
         * @param {string} "Results" - The name of the entity set
         * @param {function} - The callback function containing the code that runs when the event is triggered
         * @param {object} req - The request object containing request details
         * */
        this.before("READ", ["allIssues", "allIssuesDetails"], async (req, next) => {
            // is not empty date field, date value needs to be adjusted
            req.query.SELECT.where = serviceHelper.replaceDateInArray(req.query.SELECT.where)
            // is not empty date field, date value needs to be adjusted
            // Check if auth table is filled
            if (req.headers?.export === 'true') await cds.run(`SET 'APPLICATION' = 'CAPServicesExport'`);
            if (req.user.id !== "anonymous") {
                const { VBAKAuthObjectKeys } = await cds.entities('srvOpenOrders');
                let userID = req.user.id;
                let authSet = await SELECT.from(VBAKAuthObjectKeys).where({ USERID: userID });

                if (authSet.length === 0) {
                    req.error(413, 'NO_AUTH_LIST')
                }
            }
            req.query.SELECT.orderBy && req.query.SELECT.orderBy.forEach(order => {
                this._textKeys.forEach(item => {
                    if (order.ref.includes(item.key)) {
                        order.ref = [item.value];
                    }
                });
            });
            req.query.SELECT.hints = ['USE_HEX_PLAN', 'HEX_INDEX_JOIN'];
            req.query.SELECT.localized = false; 
            req.query.SELECT.distinct = true;
            
            serviceHelper.transformDateFilters(req.query.SELECT.where);
        });
  

        this.on("READ", ["allIssues", "allIssuesDetails"], async (req, next) => {
            // OTC-24554 Partner Settings Functionality
            // Begin of Code OTC-24554
            // *-------------------------------------------------------------------*
            // Consider also partner settings, if they are maintained
            if (req.target.name === 'openOrdersSrv.valueHelps') next()
            let db = cds.transaction(req);
            let currentUser = req.user.id;
            if (currentUser) {
                await serviceHelper.addPartnerSettings(currentUser, req.query.SELECT.where);
            }
            // *-------------------------------------------------------------------*
            // End of Code OTC-24554

            if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count' && req.headers?.countcols) {
                // return req.reply({ $count: 0 })
                if (req.target.name === 'openOrdersSrv.allIssues') {
                    let nps10, nps20, nps30, nps40, nps50, nps60, nps70, nps80, nps90, nps95, nps99, nps00;
                    let tabs = {}
                    try {
                        const db = cds.tx(req);
                        //  TODO: Refactoring is needed for this convert function to tackle search object and not just where clause
                        // based on findings for datasphere may be we get rid of the custom parser and use standard SAP libraray.. will explore in coming sprints
                        const where = serviceHelper.convertCQNtoCQL(req.query.SELECT.where, true)
                        const sQuery = `CALL"npsValueExist"(IV_WHERECLAUSE => '${where}',LT_NPS_TAB => ?)`;
                        const npstabs = await db.run(sQuery)

                        tabs = npstabs.reduce((acc, item) => {
                            acc[`nps${item.ID}`] = item.FLAG;
                            return acc;
                        }, {});
                    } catch (error) {
                        log.error("[order-monitoring-app-services.js] - if exist query failed ! " + JSON.stringify(error));
                        req.error(error)
                    }

                    try {
                        const db = cds.tx(req);
                        const countCols = req.headers.countcols; // Define count columns
                        const distinctQuery = SELECT.distinct(countCols)
                            .from('openOrdersSrv.allIssues')
                            .hints('USE_HEX_PLAN', 'HEX_INDEX_JOIN');
                        const query = SELECT.from(distinctQuery).columns('count(*) as total');
                        if (req.query.SELECT.where) query.SELECT.from.SELECT.where = req.query.SELECT.where
                        // added for including global search field... otherwise there is an infite loop as count doesnt match the actual resultset
                        if (req.query.SELECT.search) query.SELECT.from.SELECT.search = req.query.SELECT.search
                        // added for including global search field... otherwise there is an infite loop as count doesnt match the actual resultset
                        const distinctCount = await db.run(query);
                        let data = JSON.stringify({
                            "nps10": tabs.nps10,
                            "nps20": tabs.nps20,
                            "nps30": tabs.nps30,
                            "nps40": tabs.nps40,
                            "nps50": tabs.nps50,
                            "nps60": tabs.nps60,
                            "nps70": tabs.nps70,
                            "nps80": tabs.nps80,
                            "nps90": tabs.nps90,
                            "nps95": tabs.nps95,
                            "nps99": tabs.nps99,
                            "nps00": tabs.nps0,
                            "nps05": tabs.nps10 || tabs.nps20 || tabs.nps30 || tabs.nps40 || tabs.nps50 || tabs.nps60 || tabs.nps70 || tabs.nps80 || tabs.nps90 || tabs.nps95 || tabs.nps99,
                            "nps101": tabs.nps10 || tabs.nps20 || tabs.nps30 || tabs.nps40 || tabs.nps50 || tabs.nps60 || tabs.nps70 || tabs.nps80 || tabs.nps90 || tabs.nps95 || tabs.nps99
                        })
                        req.res.setHeader('custom', data)
                        return req.reply({ $count: distinctCount[0].total })

                    } catch (error) {
                        log.error("[order-monitoring-app-services.js] - Count query failed ! " + JSON.stringify(error));
                        req.error(error)
                    }
                } else {
                    return req.reply({ $count: 0 })
                }
            }
            await next(req)
        })

        /**
         * This event is triggered after the backend request for order list data
         * @param {string} "READ" - The type of backend request
         * @param {string} "Results" - The name of the entity set
         * @param {function} - The callback function containing the code that runs when the event is triggered
         * @param {array} data - The array containing the result from the backend request
         * @param {object} req - The request object containing request details
         * */
        this.after("READ", ["allIssues", "allIssuesDetails"], async (data, req) => {
            if (req.target.name != 'openOrdersSrv.valueHelps') {
                // needed for cache .. to make value helps dynamic. we are using unique session ID to cache based on authorization token.
                let sessionID = req.headers['authorization'] || req.headers['x-username'];
                if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count' && req.headers?.select) {
                    // do nothing
                } else {

                    // cache the query, so that all filter conditions can be consumed.. when any valuehelp is called.
                    if (req.target.name === 'openOrdersSrv.allIssues') {
                        let query = req.query;
                        query.SELECT.where = req.query.SELECT.where;
                        const queryString = JSON.stringify(query);
                        const queryId = `${sessionID}AMOOQuery`
                        sessionCache.set(queryId, queryString);
                    }
                }
                data = Array.isArray(data) ? data : [data]
                var dateProps = serviceHelper.getDateProps()
                data.forEach((item) => {
                    item.id = uuid.v1()
                    if ( 'SO_FOLLOWUP_NOTES_LANG' in item )
                        item.SO_FOLLOWUP_NOTES_LANG = serviceHelper.getFollowupNoteText(req,item.SO_FOLLOWUP_NOTES_LANG)
                    if ('SO_REASON_CODE_01_LANG' in item)
                        item.SO_REASON_CODE_01_LANG = serviceHelper.getReasonCodeText(req,'01',item.SO_REASON_CODE_01_LANG)
                    if ('SO_REASON_CODE_02_LANG' in item)
                        item.SO_REASON_CODE_02_LANG = serviceHelper.getReasonCodeText(req,'02',item.SO_REASON_CODE_02_LANG)
                    if ('SO_REASON_CODE_03_LANG' in item)
                        item.SO_REASON_CODE_03_LANG = serviceHelper.getReasonCodeText(req,'03',item.SO_REASON_CODE_03_LANG)
                    if ('SO_REASON_CODE_04_LANG' in item)
                        item.SO_REASON_CODE_04_LANG = serviceHelper.getReasonCodeText(req,'04',item.SO_REASON_CODE_04_LANG)
                    if ('SO_REASON_CODE_05_LANG' in item)
                        item.SO_REASON_CODE_05_LANG = serviceHelper.getReasonCodeText(req,'05',item.SO_REASON_CODE_05_LANG)
                    if ('SO_NETWR' in item) // Net Amount
                        item.SO_NETWR = formatSpecialCurrencies(item.SO_NETWR, item.SO_WAERK, this._SpecialCurrencies);
                    if ('SO_KBETR' in item) // Price Per Unit
                        item.SO_KBETR = formatSpecialCurrencies(item.SO_KBETR, item.SO_WAERK, this._SpecialCurrencies);
                    if ('SO_NPS' in item) item.SO_NPS_DESCRIPTION = serviceHelper.getBundle(req.locale).getText(`nps${item.SO_NPS}`)
                    if ('SO_ISSUE' in item) item.SO_ISSUE_DESCRIPTION = serviceHelper.getBundle(req.locale).getText(`OrderIssue${item.SO_ISSUE}`)
                    if ('SO_DCP_ITEM_STATUS' in item) {
                        if (item.SO_DCP_ITEM_STATUS) {
                            item.SO_DCP_ITEM_STATUS_DESCRIPTION = serviceHelper.getBundle(req.locale).getText(`dcpStatus${item.SO_DCP_ITEM_STATUS}`)
                        }
                    }
                    let mandtFields = serviceHelper.getMandtFields();
                    // MANDANT TEXTS LOGIC -------------
                    mandtFields.forEach((mandt) => {
                        const mandtProp = item[mandt];
                        if (mandtProp) {
                            let mandtTxtField = mandt + "_TEXT";
                            item[mandtTxtField] = serviceHelper.getMandtFieldsNames(mandtProp);
                        }
                    })
                    dateProps.forEach((property) => {
                        const dateString = item[property]
                        if (dateString && dateString != "00000000" && dateString != "0000-00-00" && dateString != "--") {
                            const year = parseInt(dateString.substring(0, 4), 10);
                            const month = parseInt(dateString.substring(4, 6), 10) - 1;
                            const day = parseInt(dateString.substring(6, 8), 10);
                            item[property] = new Date(year, month, day);
                        } else {
                            item[property] = null
                        }

                    })
                })

            }

        });

        // ORDER CREATION HANDLERS
        this.before("READ", "orderCreation", async (req, next) => {
            // Deactivated in PROD
            if (process.env.OC_TAB_STATUS === 'ACTIVE') {
                req.query.SELECT.localized = false;
                req.query.SELECT.distinct = true;
                req.query.SELECT.hints = ['USE_HEX_PLAN', 'HEX_INDEX_JOIN'];

                // Add sorting if necessary only
                if (!req.query.SELECT?.columns[0].as) {
                    if (req.query.SELECT.orderBy) {
                        serviceHelper.addOrderIfNeeded(req.query.SELECT.orderBy, 'PO_EBELN');
                        serviceHelper.addOrderIfNeeded(req.query.SELECT.orderBy, 'PO_EBELP');
                    } else {
                        req.query.SELECT.orderBy = [
                            { ref: ['PO_EBELN'], sort: 'asc' },
                            { ref: ['PO_EBELP'], sort: 'asc' }
                        ]
                    }
                }

                // where clause is initially converted from cqn to cql
                let whereClause = serviceHelper.convertCQNtoCQL(req.query.SELECT.where, false)
                // where clause is initially converted from cqn to cql
                // where clause is then transformed from cql for date formatting and removing additional inverted commas
                whereClause = serviceHelper.transformWhereClause(whereClause)
                // where clause is then transformed from cql for date formatting and removing additional inverted commas
                // where clause is then inserted back to the query
                req.query.SELECT.where = cds.parse.xpr(whereClause)
            }
        });

        this.on("READ", "orderCreation", async (req, next) => {
            if (process.env.OC_TAB_STATUS === 'ACTIVE') {
                if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count') {
                    try {
                        const db = cds.tx(req);
                        const countCols = ['PO_MANDT', 'PO_EBELN', 'PO_EBELP']; // Define count columns
                        const distinctQuery = SELECT.distinct(...countCols)
                            .from('openOrdersSrv.orderCreation')
                            .orderBy({ PO_EBELN: 'asc' }, { PO_EBELP: 'asc' })
                            .hints('USE_HEX_PLAN', 'HEX_INDEX_JOIN');
                        const query = SELECT.from(distinctQuery).columns('count(*) as total');
                        if (req.query.SELECT.where) query.SELECT.from.SELECT.where = req.query.SELECT.where
                        const distinctCount = await db.run(query);
                        return req.reply({ $count: distinctCount[0].total })
                    } catch (error) {
                        log.error("[order-monitoring-app-services.js] - Count query failed ! " + JSON.stringify(error));
                        req.error(error)
                    }
                }
            } else { // Deactivated in PROD
                if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count') {
                    return req.reply({ $count: 0 })
                } else {
                    return [];
                }
            }
            await next(req)
        })

        this.after("READ", "orderCreation", async (data, req) => {
            if (process.env.OC_TAB_STATUS === 'ACTIVE') {
                let sessionID = req.headers['x-username'] || req.headers['authorization'];
                if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count') {
                    // do nothing
                } else {
                    // Logic for filling up or not the tab icon
                    let dataFound = false;
                    if (data.length > 0) {
                        dataFound = true;
                    }
                    req.res.setHeader('ordercreationdata', dataFound)
                    // cache the query, so that all filter conditions can be consumed.. when any valuehelp is called.
                    if (req.target.name === 'openOrdersSrv.orderCreation') {
                        let query = req.query;
                        query.SELECT.where = req.query.SELECT.where;
                        const queryString = JSON.stringify(query);
                        const queryId = `${sessionID}OCQuery`
                        sessionCache.set(queryId, queryString);
                    }
                }
                data = Array.isArray(data) ? data : [data]
                var dateProps = serviceHelper.getPODateProps()
                data.forEach((item) => {
                    item.Id = uuid.v1()
                    let mandtFields = serviceHelper.getMandtFields();
                    // MANDANT TEXTS LOGIC -------------
                    mandtFields.forEach((mandt) => {
                        const mandtProp = item[mandt];
                        if (mandtProp) {
                            let mandtTxtField = mandt + "_TEXT";
                            item[mandtTxtField] = serviceHelper.getMandtFieldsNames(mandtProp);
                        }
                    })
                    if ('PO_NPS' in item) item.PO_NPS_TEXT = serviceHelper.getBundle(req.locale).getText(`po_nps${item.PO_NPS}`)
                    if ('PO_ISSUE' in item) item.PO_ISSUE_TEXT = serviceHelper.getBundle(req.locale).getText(`po_issue${item.PO_ISSUE}`)
                    dateProps.forEach((property) => {
                        const dateString = item[property]
                        if (dateString && dateString != "00000000" && dateString != "0000-00-00" && dateString != "--") {
                            const year = parseInt(dateString.substring(0, 4), 10);
                            const month = parseInt(dateString.substring(4, 6), 10) - 1;
                            const day = parseInt(dateString.substring(6, 8), 10);
                            item[property] = new Date(year, month, day);
                        } else {
                            item[property] = null
                        }

                    })
                })
            }
        });

        // END OF ORDER CREATION HANDLERS

        this.on("resolveBIMErrors", async (req) => {
            const errorIds = req.data.errorIds?.split(',')
            if (!errorIds) return;

            const { ST_BIM_ERRORS } = await cds.entities('openorders.db');
            await UPDATE(ST_BIM_ERRORS).set({ IS_RESOLVED: true }).where({ BIM_ERROR_ID:  { in:  errorIds} });            
        });


        // BEGIN OF ORDER CREATION VALUE HELPS HANDLERS
        this.before("READ", "OCValueHelps", async (req, next) => {
            // Nothing yet
        });

        this.on("READ", "OCValueHelps", async (req, next) => {
            let lt_result = []
            if (process.env.OC_TAB_STATUS === 'ACTIVE') {
                // get the session id based on auth token
                let sessionID = req.headers['x-username'] || req.headers['authorization'];
                const queryId = `${sessionID}OCQuery`
                const db = cds.tx(req);
                // if session id is there, get the cach-ed query and execute it.
                if (sessionCache.get(queryId)) {
                    const queryString = sessionCache.get(queryId);
                    const query = JSON.parse(queryString);
                    query.SELECT.from.ref[0] = 'openOrdersSrv.orderCreation'
                    let searchString = req.http.req.query["$search"] && req.http.req.query["$search"].replace(/"/g, '')
                    let lowerCaseSearchString = searchString && `%${searchString.toLowerCase()}%`
                    if (lowerCaseSearchString) {
                        let where = []
                        if (req.http.req.query['$select'] && req.http.req.query['$select'].split(',').length > 1) {
                            where = cds.parse.expr(`lower(${req.http.req.query['$select'].split(',')[1]}) like '${lowerCaseSearchString}' ESCAPE '^' OR lower(${req.http.req.query['$select'].split(',')[0]}) like '${lowerCaseSearchString}' ESCAPE '^'`);
                        } else {
                            where = cds.parse.expr(`lower(${req.http.req.query['search-focus']}) like '${lowerCaseSearchString}' ESCAPE '^'`);
                        }
                        let requestQuery = query.SELECT.where || [];
                        where && requestQuery.length != 0 && requestQuery.push('and');
                        where && requestQuery.push(where);
                        query.SELECT.where = requestQuery
                    }
                    if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count') {
                        // ISSUE 343357 
                        // add skip and top parameters from real query
                        query.SELECT.limit = req.query.SELECT.limit;
                        // query.SELECT.distinct = true;
                        // End of ISSUE 343357
                        query.SELECT.columns.length = 0;
                        query.SELECT.columns = req.query.SELECT.columns;
                        if (query.SELECT.orderBy) query.SELECT.orderBy.length = 0;
                        query.SELECT.orderBy = req.query.SELECT.orderBy;
                        try {
                            // req.header.select will have the string of visible columns. 
                            //this parameater has been manually set to header on every request
                            const selectedField = req.http.req.query && req.http.req.query['$select']
                            let fields = selectedField && selectedField.split(',');
                            fields = fields.filter((fieldName) => {
                                const mandtFields = serviceHelper.getMandtFields();
                                const mandtTextFields = mandtFields.map((mandtFieldName) => mandtFieldName + "_TEXT");
                                if (mandtTextFields.includes(fieldName)) {
                                    return false;
                                } else {
                                    return true;
                                }
                            });
                            // Add order by for key field if needed
                            serviceHelper.addOrderIfNeeded(query.SELECT.orderBy, fields[0]);
                            lt_result = await db.run(query)
                            // remove duplicates based on fields in the valuehelp dialog box
                            lt_result = serviceHelper.removeDuplicates(fields, lt_result);
                        } catch (error) {
                            log.error("[amoo-services.js] - OC Value help query w session cache failed! " + error.message + "||" + JSON.stringify(error));
                            req.error(status.EXPECTATION_FAILED, serviceHelper.getBundle(req.locale).getText("VALUEHELP_NOT_EXECUTED"))
                        }
                    } else {
                        try {
                            const fields = req.http.req.query["search-focus"].split(',')
                            let queryCount = 0;

                            // We need an orderBy clause to make the query performant
                            let keyField = fields[0];
                            let subquery = SELECT.distinct(...fields)
                                .from('openOrdersSrv_orderCreation')
                                .orderBy(keyField)
                                .hints('USE_HEX_PLAN', 'HEX_INDEX_JOIN');
                            // Add where clause if needed
                            if (query.SELECT.where) {
                                subquery = subquery.where(query.SELECT.where);
                            }
                            // Run the count query
                            const distinctCount = await SELECT.from(subquery).columns('count(*) as total');
                            if (distinctCount.length > 0) {
                                queryCount = distinctCount[0].total;
                            }
                            lt_result.push({ $count: queryCount })
                        } catch (error) {
                            log.error("[amoo-services.js] - OC Value help count query w session cache failed! " + error.message + "||" + JSON.stringify(error));
                            req.error(status.EXPECTATION_FAILED, serviceHelper.getBundle(req.locale).getText("VALUEHELP_NOT_EXECUTED"))
                        }

                    }

                } else {
                    const fields = req.http.req.query["search-focus"].split(',')
                    // if there is no session id, execute the query directly
                    let searchString = req.http.req.query["$search"] && req.http.req.query["$search"].replace(/"/g, '')
                    let lowerCaseSearchString = searchString && `%${searchString.toLowerCase()}%`
                    if (lowerCaseSearchString) {
                        let where = []
                        if (req.http.req.query['$select'] && req.http.req.query['$select'].split(',').length > 1) {
                            where = cds.parse.expr(`lower(${req.http.req.query['$select'].split(',')[1]}) like '${lowerCaseSearchString}' ESCAPE '^' OR lower(${req.http.req.query['$select'].split(',')[0]}) like '${lowerCaseSearchString}' ESCAPE '^'`);
                        } else {
                            where = cds.parse.expr(`lower(${req.http.req.query['search-focus']}) like '${lowerCaseSearchString}' ESCAPE '^'`);
                        }
                        let requestQuery = req.query.SELECT.where || [];
                        where && requestQuery.length != 0 && requestQuery.push('and');
                        where && requestQuery.push(where);
                        req.query.SELECT.where = requestQuery
                        delete req.query.SELECT.search
                    }
                    if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count') {
                        // req.query.SELECT.distinct = true;
                        // Add order by for key field if needed
                        serviceHelper.addOrderIfNeeded(req.query.SELECT.orderBy, fields[0]);
                        let finalQuery = SELECT.distinct.from(allIssues).columns(req.query.SELECT.columns).where(req.query.SELECT.where).orderBy(req.query.SELECT.orderBy);
                        try {
                            lt_result = await db.run(finalQuery)
                        } catch (error) {
                            log.error("[amoo-services.js] - OC Value help query wo session cache failed! " + error.message + "||" + JSON.stringify(error));
                            req.error(error)
                        }
                    } else {
                        try {
                            let queryCount = 0;
                            // We need an orderBy clause to make the query performant
                            let keyField = fields[0];
                            let subquery = SELECT.distinct(...fields)
                                .from('openOrdersSrv_orderCreation')
                                .orderBy(keyField)
                                .hints('USE_HEX_PLAN', 'HEX_INDEX_JOIN');
                            // Add where clause if needed
                            if (req.query.SELECT.where) {
                                subquery = subquery.where(req.query.SELECT.where);
                            }

                            // Run the count query
                            const distinctCount = await SELECT.from(subquery).columns('count(*) as total');
                            if (distinctCount.length > 0) {
                                queryCount = distinctCount[0].total;
                            }
                            lt_result.push({ $count: queryCount })
                        } catch (error) {
                            log.error("[amoo-services.js] - OC Value help count query wo session cache failed! " + error.message + "||" + JSON.stringify(error));
                            req.error(error)
                        }

                    }
                }
                /// Filter the value help search
                if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count' && req.query.SELECT.search) {
                    lt_result = lt_result.filter((item) => {
                        for (const prop in item) {
                            if (item[prop] === null) return false;
                            // convert to lowercase both sides in order to avoid case sensitivity issues when searching
                            if (item[prop].toLowerCase().includes(req.query.SELECT.search[0].val.toLowerCase().replace(/^["']|["']$/g, ''))) {
                                return true;
                            }
                        }
                        return false;

                    });
                }
            } else {
                // Deactivation in PROD
                if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count') {
                    lt_result = [];
                } else {
                    lt_result.push({ $count: 0 });
                }
            }
            return lt_result;

        })

        this.after("READ", "OCValueHelps", async (data, req) => {
            if (process.env.OC_TAB_STATUS === 'ACTIVE') {
                data = Array.isArray(data) ? data : [data]
                // since there is a virtual id field, adding a random guid to each record of the result set.
                data.forEach((item) => {
                    item.Id = uuid.v1()
                    let mandtFields = serviceHelper.getMandtFields();
                    if ('PO_NPS' in item) item.PO_NPS_TEXT = serviceHelper.getBundle(req.locale).getText(`po_nps${item.PO_NPS}`)
                    if ('PO_ISSUE' in item) item.PO_ISSUE_TEXT = serviceHelper.getBundle(req.locale).getText(`po_issue${item.PO_ISSUE}`)
                    // MANDANT TEXTS LOGIC -------------
                    mandtFields.forEach((mandt) => {
                        const mandtProp = item[mandt];
                        if (mandtProp) {
                            let mandtTxtField = mandt + "_TEXT";
                            item[mandtTxtField] = serviceHelper.getMandtFieldsNames(mandtProp);
                        }
                    })
                })
            }
        });
        // END OF ORDER CREATION VALUE HELPS HANDLERS

        this.after('READ','ReasonCommentsCloud', async(data,req)=>{
            data = Array.isArray(data) ? data : [data]
            data.forEach((item)=>{
                item.BucketText = serviceHelper.getBucketText(req, item.BucketKey)
                item.ReasonCodeText = serviceHelper.getReasonCodeText(req, item.BucketKey,item.ReasonCodeKey)
            })
            
        })

        // Adding Flag for latest followup notes 
        this.before("CREATE", "FollowupNotes", async (req) => {
            const db = await cds.connect.to('db');
            const entries = req.query.INSERT.entries;

            await Promise.all(
                entries.map(async (entry) => {
                    await db.run(
                        UPDATE('OPENORDERS_DB_ST_FOLLOWUP_NOTES')
                            .set({ LAST_FOLLOWUPNOTE_FLAG: ' ' })
                            .where({
                                MANDT: entry.Client,
                                VBELN: entry.SalesOrder,
                                POSNR: entry.OrderItem,
                                LAST_FOLLOWUPNOTE_FLAG: 'X'
                            })
                    );
                    // Mark the new entry as last note
                    entry.LastFollowupNoteFlag = 'X';
                })
            );
        });
        
        // Adding Flag for first entry in the table after deleting one of the FollowupNotes
        this.after("DELETE", "FollowupNotes", async (data, req) => {
                    const { FollowupNotes } = await cds.entities('openOrdersSrv');
                    let Followupnote = await SELECT.from(FollowupNotes).where({  SalesOrder:req.data.SalesOrder, OrderItem: req.data.OrderItem}).orderBy('CreatedAt desc').limit(1);
                    if (Followupnote.length > 0 ) {
                        await UPDATE(FollowupNotes).set({ LastFollowupNoteFlag: 'X' }).where({ SalesOrder: req.data.SalesOrder, OrderItem: req.data.OrderItem, CreatedAt: Followupnote[0].CreatedAt });
                    }

                })
        this.after("READ","FollowupNotes", async(data,req)=>{
            data = Array.isArray(data) ? data : [data]
            data.forEach((item)=>{
                item.FollowupNoteText = serviceHelper.getFollowupNoteText(req,item.FollowupNote )
            })
        })

        this.on("READ", "ChangeDocSet", async req => {
            let lt_changeDocs = [];
            try {
                // let contactsQuery = SELECT.from('ServicesSet').limit(req.query.SELECT.limit);
                // if (req.query.SELECT.where) {
                //     contactsQuery.where(req.query.SELECT.where);
                // }
                // if (req.query.SELECT.orderBy) {
                //     contactsQuery.orderBy(req.query.SELECT.orderBy);
                // }
                const apiManagementService = await cds.connect.to('CSEUCockpitService');
                // lt_contacts = await apiManagementService.get("/ContactSet?$filter=SapClient eq '100' and SalesDocument eq '0005508482' and OrderItem eq '000010'");
                lt_changeDocs = await apiManagementService.tx(req).send({
                    query: req.query
                });
            } catch (error) {
                req.error(413, error)
            }

            return lt_changeDocs;
        })

        this.on("UPDATE", "ShipmentUpdates", async req => {
            try {
                const AMOOService = await cds.connect.to('AMOOUtilsService');
                let updateReq = await AMOOService.tx(req).send({
                    query: req.query
                });

                return updateReq;

            } catch (error) {
                if (error.reason.response.status === 204) {
                    // This is actually not an error - supress it 
                    return null;
                } else {
                    req.error(413, error)
                }
            }
        })

        this.on("getIssueReason", async (req) => {
            // let issueReason = []
            let textBundle = serviceHelper.getBundle(req.locale);
            let incompletionLog = []
            let gtsBlockReasons = []
            let creditData = {}
            let idocData = []
            let atpData = []
            const { salesOrder, salesOrderItem, issueLocation,
                issueLocationItem, issue, nps, material, issueLoctionDocType,
                plant, uom, dueDate, firstDate, system } = JSON.parse(req.data.issuePayload);

            switch (system) {
                case "100": // Cobalt
                    // Call Cobalt only for order incomplete and outbound delivery incomplete (for now)
                    if (issue === "01" || issue === "05") {
                        try {
                            const OMServices = await cds.connect.to('DSLServicesService');
                            incompletionLog = await OMServices.run(SELECT.from('IncompletionLogsSet').where({
                                DocumentNumber: issueLocation, // order number in case of 01 and delivery number in case of 05
                                DocumentItem: issueLocationItem, // order item in case of 01 and delivery item in case of 05
                                Issue: issue
                            }))
                        } catch (error) {
                            console.error('Error fetching issue reason:', error);
                        }
                    }
                    if (issue === '08' || issue === '11') {
                        const messageType = issue === '08' ? 'ZDESADV' : 'ZORDERS';
                        try {
                            const CSEUCockpitService = await cds.connect.to('CSEUCockpitService');
                            idocData = await CSEUCockpitService.run(SELECT.from('FailedIDocSet').where({
                                MessageType: messageType,
                                PONumber: issueLocation,
                                Direction: '2'
                            }))

                        } catch (error) {
                            console.error('Error fetching failed iDocs:', error);
                        }
                    }
                    if (['10', '20', '30', '40'].includes(nps)) {
                        try {
                            const ATPService = await cds.connect.to('ATPService');
                            let atpSystemCheck = await ATPService.run(SELECT.from('ATPCheckSystemSet').where({
                                Material: material,
                                Plant: plant
                            }))
                            if (atpSystemCheck[0].System != ' ') {
                                let dateToday = new Date();
                                let sCheckingRule = " ";
                                dateToday = dateToday.setUTCHours(0, 0, 0, 0);
                                let requestedDate = new Date(firstDate)
                                requestedDate = requestedDate.setUTCHours(0, 0, 0, 0);
                                let sDate = new Date(requestedDate > dateToday ? requestedDate : dateToday).toLocaleDateString("en-GB").split("/").reverse().join("");
                                switch (nps) {
                                    case "30":
                                        sCheckingRule = "A";
                                        break;
                                    case "40":
                                        let dueDateMs = new Date(dueDate).setUTCHours(0, 0, 0, 0);
                                        let dateMs = Math.abs(dueDateMs - dateToday);
                                        let days = 1000 * 3600 * 24;
                                        let dateDifference = dateMs / days;
                                        const db = cds.transaction(req);
                                        let timeFrame = await db.run(SELECT.from('openOrdersSrv.dueDateLimit').where({ userId: req.user.id }))
                                        sCheckingRule = dueDateMs > dateToday && dateDifference >= timeFrame[0].dayLimit ? "A" : "B";
                                }
                                atpData = await ATPService.run(SELECT.from('ATPCheckR3Set').where({
                                    Material: material,
                                    Plant: plant,
                                    RequestedQuantityUnit: uom,
                                    CheckingRule: sCheckingRule,
                                    Date: sDate,
                                    SalesOrderDocument: salesOrder,
                                    SalesOrderItem: salesOrderItem
                                }))
                            }
                        } catch (error) {
                            console.error('Error fetching ATP Pal status:', error);
                        }
                    }
                    break;
                case "200": // EC
                    break;
                case "300": // AP
                    const OMServicesAP = await cds.connect.to('OMServicesAP');
                    if (issue === "01" || issue === "05") {
                        try {
                            if (issue === "01") { // order incompletion
                                incompletionLog = await OMServicesAP.send({
                                    method: 'GET',
                                    query: SELECT.from('IncompletionLogsSet').where`DocumentNumber = ${issueLocation} and DocumentItem = ${issueLocationItem}`,
                                    headers: {
                                        'X-Basf-Sap-Client': process.env.AP_CLIENT
                                    }
                                });
                                // incompletionLog = await OMServicesAP.run(SELECT.from('IncompletionLogsSet').where `DocumentNumber = ${issueLocation} and DocumentItem = ${issueLocationItem}`);
                            } else { // issue 05 // delivery incompletion
                                // incompletionLog = await OMServicesAP.run(SELECT.from('IncompletionLogsSet').where `DocumentNumber = ${issueLocation} and ( DocumentItem = ${issueLocationItem} or DocumentItem = '000000' )`);
                                incompletionLog = await OMServicesAP.send({
                                    method: 'GET',
                                    query: SELECT.from('IncompletionLogsSet').where`DocumentNumber = ${issueLocation} and ( DocumentItem = ${issueLocationItem} or DocumentItem = '000000' )`,
                                    headers: {
                                        'X-Basf-Sap-Client': process.env.AP_CLIENT
                                    }
                                });
                            }
                            // Fill the text
                            incompletionLog.forEach((log) => {
                                if (issue === '01') {
                                    log.IncompletionText = `${log.IncompletionText} ${textBundle.getText("isMissing")}`;
                                } else {
                                    if (log.DocumentItem === '000000') {
                                        log.IncompletionText = `${textBundle.getText("onHeader")}: ${log.IncompletionText} ${textBundle.getText("isMissing")}`;
                                    } else {
                                        log.IncompletionText = `${log.DocumentItem}: ${log.IncompletionText} ${textBundle.getText("isMissing")}`;
                                    }
                                }
                            })
                        } catch (error) {
                            console.error('Error fetching issue reason:', error);
                        }
                    }
                    // GTS Block
                    if (issue === '07') {
                        try {
                            let entity = "OrderGTSBlocks";
                            let whereClause = `SalesDocument = '${issueLocation}' and SalesDocumentItem = '${issueLocationItem}'`;
                            // gts block is in outbound delivery
                            if (issueLoctionDocType === "J") {
                                entity = "DeliveryGTSBlocks";
                                whereClause = `DeliveryDocument = '${issueLocation}' and DeliveryDocumentItem = '${issueLocationItem}'`;
                            }
                            gtsBlockReasons = await OMServicesAP.send({
                                method: 'GET',
                                query: SELECT.from(entity).where(whereClause),
                                headers: {
                                    'X-Basf-Sap-Client': process.env.AP_CLIENT
                                }
                            });

                            // Fill the text
                            gtsBlockReasons.forEach((block) => {
                                block.EmbargoStatusText = `${serviceHelper.getBundle(req.locale).getText('EmbargoStatus')}: ${block.EmbargoStatusText}`;
                                block.ScreeningStatusText = `${serviceHelper.getBundle(req.locale).getText('ScreeningStatus')}: ${block.ScreeningStatusText}`;
                                block.LegalControlStatusText = `${serviceHelper.getBundle(req.locale).getText('LegalCtrlStatus')}: ${block.LegalControlStatusText}`;
                            })
                        } catch (error) {
                            console.error('Error fetching issue reason:', error);
                        }
                    }
                    //
                    /// AP PLACEHOLDER UNTIL THOSE REASONS FOR ISSUE ARE DONE (APIs MISSING)
                    if (issue === '08' || issue === '11') {
                        idocData.push({
                            text: textBundle.getText("APTBD")
                        })
                    }
                    ////////
                    break;
                default:
                    break;
            }

            // Call to FSCM system (Cobalt and AP orders)
            if (issue === '06' && system !== '200') {
                const CreditManagerService = await cds.connect.to('CreditManagerService');
                try {
                    creditData = await CreditManagerService.run(SELECT.from('OrderBlockSet').byKey({
                        OrderNumber: issueLocation,
                        Language: req.locale.toUpperCase()
                    }).columns("Text1", "Text2", "Text3", "Text4"))
                } catch (error) {
                    console.error('Error fetching credit status:', error);
                }
            }


            const combinedResults = [];
            // issueReason.forEach((item) => {
            //     combinedResults.push({ text: item.IssueReason })
            // })
            gtsBlockReasons.forEach((item) => {
                combinedResults.push({ text: item.EmbargoStatusText })
                combinedResults.push({ text: item.ScreeningStatusText })
                combinedResults.push({ text: item.LegalControlStatusText })
            })
            incompletionLog.forEach((item) => {
                combinedResults.push({ text: item.IncompletionText })
            })
            for (const prop in creditData) {
                if (creditData.hasOwnProperty(prop)) {
                    combinedResults.push({ text: creditData[prop] })
                }
            }
            if (idocData.length != 0) {
                combinedResults.push(...idocData);
            }
            if (atpData.length != 0) {
                if (atpData[0].Date === new Date().toLocaleDateString("en-GB").split("/").reverse().join("")) {
                    combinedResults.push({
                        "text": `Current ATP Quantity = ${atpData[0].ATPQuantity} / ${atpData[0].RequestedQuantityUnit}`
                    });
                } else {
                    combinedResults.push({
                        "text": `ATP Quantity = ${atpData[0].ATPQuantity} / ${atpData[0].RequestedQuantityUnit} on ${atpData[0].ATPQuantityDate}`
                    });
                }
            }
            return combinedResults;
        })
        this.before("READ", "OpenOrdersAnalytics", async (req, next) => {
            // if (req.query.SELECT.where) {
            // req.query.SELECT.where = serviceHelper.replaceDateInArray(req.subject.ref[0].SELECT.where[0].xpr[0].xpr[0].xpr[0].xpr)
            if (req.headers?.export === 'true') await cds.run(`SET 'APPLICATION' = 'CAPServicesExport'`);
            // if (req.user.id !== "anonymous") {
            //     const { VBAKAuthObjectKeys } = await cds.entities('srvOpenOrders');
            //     let userID = req.user.id;
            //     let authSet = await SELECT.from(VBAKAuthObjectKeys).where({ USERID: userID });
            //     if (authSet.length === 0) {
            //         req.error(413, 'NO_AUTH_LIST')
            //     }

            req.query.SELECT.orderBy && req.query.SELECT.orderBy.forEach(order => {
                this._textKeys.forEach(item => {
                    if (order.ref.includes(item.key)) {
                        order.ref = [item.value];
                    }
                });
            });
            req.query.SELECT.hints = ['USE_HEX_PLAN', 'HEX_INDEX_JOIN'];
            req.query.SELECT.distinct = true;
            let whereClause = serviceHelper.convertCQNtoCQL(req.query.SELECT.where, false)
            // where clause is initially converted from cqn to cql
            // where clause is then transformed from cql for date formatting and removing additional inverted commas
            whereClause = serviceHelper.transformWhereClause(whereClause)
            // where clause is then transformed from cql for date formatting and removing additional inverted commas
            // where clause is then inserted back to the query
            req.query.SELECT.where = cds.parse.xpr(whereClause)
        });

        this.on("READ", 'OpenOrdersAnalytics', async (req, next) => {
            const db = cds.tx(req);
            let currentUser = req.user.id;
            if (currentUser) {
                await serviceHelper.addPartnerSettings(currentUser, req.query.SELECT.where);
            }

            let where = serviceHelper.convertCQNtoCQL(req.query.SELECT.where);
            where = where.replace(/''/g, "'");
            where = `${where}  SO_IGNORED = 0`;
            //  get selected columns & sorters & summation fields
            let columns = req.headers?.selectedcolumns || '';
            let groupby = req.headers?.orderby || '';
            let summationFields = req.headers.summationfields || '';
            // Convert to array
            let columnsArray = columns.split(',').map(c => c.trim()).filter(Boolean);
            let groupbyArray = groupby.split(',').map(g => g.trim()).filter(Boolean);
            let groupbySet = new Set(groupbyArray);
            // Aggregated Fields
            let aggrMap = {
                SO_KWMENG: { sum: `SUM(SO_KWMENG) AS SO_KWMENG`, group: 'SO_VRKME' },
                SO_KBMENG: { sum: 'SUM(SO_KBMENG) AS SO_KBMENG', group: 'SO_VRKME' },
                DL_LFIMG: { sum: 'SUM(DL_LFIMG) AS DL_LFIMG', group: 'DL_VRKME' },
                SO_NETWR: { sum: 'SUM(SO_NETWR) AS SO_NETWR', group: 'SO_WAERK' }
            };
            const keys = Object.keys(aggrMap)
            keys.forEach(key => {
                if (!summationFields.includes(key)) {
                    delete aggrMap[key];
                }
            });
            const unitFields = new Set();
            for (const col of columnsArray) {
                if (aggrMap[col])
                    unitFields.add(aggrMap[col].group);
            }
            // Add required grouping fields for aggregated columns
            for (const col of columnsArray) {
                if (aggrMap[col]) {
                    groupbySet.add(aggrMap[col].group);
                }
            }

            // Convert back to array for final group by
            const finalGroupByArray = Array.from(groupbySet);
            const finalGroupBy = finalGroupByArray.join(', ');

            // Filter out NPS, Issue Description and text columns
            const excludeColumns = [
                'SO_ISSUE_DESCRIPTION', 'SO_NPS_DESCRIPTION', 'DL_MANDT_TEXT',
                'SO_MANDT_TEXT', 'SO_FINAL_SO_MANDT_TEXT', 'BL_MANDT_INV_LAST_TEXT',
                'TM_MANDT_TEXT'
            ];
            columnsArray = columns.split(',')
                .map(c => c.trim())
                .filter(Boolean)
                .map(col => excludeColumns.includes(col) ? `NULL AS ${col}` : col);

            let finalQuery = '';
            if (req.query.SELECT.columns && req.query.SELECT.columns[0].as === '$count') {
                const where = serviceHelper.convertCQNtoCQL(req.query.SELECT.where, true)
                const sQuery = `CALL"npsValueExist"(IV_WHERECLAUSE => '${where}',LT_NPS_TAB => ?)`;
                const npstabs = await db.run(sQuery)
                const tabs = npstabs.reduce((acc, item) => {
                    acc[`nps${item.ID}`] = item.FLAG;
                    return acc;
                }, {});
                let data = JSON.stringify({
                    "nps10": tabs.nps10,
                    "nps20": tabs.nps20,
                    "nps30": tabs.nps30,
                    "nps40": tabs.nps40,
                    "nps50": tabs.nps50,
                    "nps60": tabs.nps60,
                    "nps70": tabs.nps70,
                    "nps80": tabs.nps80,
                    "nps90": tabs.nps90,
                    "nps95": tabs.nps95,
                    "nps99": tabs.nps99,
                    "nps00": tabs.nps0,
                    "nps05": tabs.nps10 || tabs.nps20 || tabs.nps30 || tabs.nps40 || tabs.nps50 || tabs.nps60 || tabs.nps70 || tabs.nps80 || tabs.nps90 || tabs.nps95 || tabs.nps99,
                    "nps101": tabs.nps10 || tabs.nps20 || tabs.nps30 || tabs.nps40 || tabs.nps50 || tabs.nps60 || tabs.nps70 || tabs.nps80 || tabs.nps90 || tabs.nps95 || tabs.nps99
                })
                req.res.setHeader('custom', data)
                return;
            } else {
                // get pagination values
                const limit = req.query.SELECT.limit?.rows?.val ?? 500;
                const offset = req.query.SELECT.limit?.offset?.val ?? 0;
                let queryParts = [];
                if (columns.includes('SO_NPS')) {
                    queryParts.push(`
                    WITH base_data_raw AS (
                        SELECT DISTINCT ${columnsArray.join(', ')}
                        FROM openOrdersSrv_OpenOrdersAnalytics
                        WHERE ${where}
                        LIMIT ${limit} OFFSET ${offset}),
                        base_data AS (
                            SELECT *
                            FROM base_data_raw t
                                WHERE NOT (t.SO_NPS IN (20,30,40) AND EXISTS (
                            SELECT 1 FROM base_data_raw x 
                                WHERE x.SO_VBELN = t.SO_VBELN AND x.SO_POSNR = t.SO_POSNR AND x.SO_NPS = 10
                        ))
                        AND NOT (t.SO_NPS IN (30,40) AND EXISTS (
                            SELECT 1 FROM base_data_raw x 
                                WHERE x.SO_VBELN = t.SO_VBELN AND x.SO_POSNR = t.SO_POSNR AND x.SO_NPS = 20
                        ))
                        AND NOT (t.SO_NPS = 40 AND EXISTS (
                            SELECT 1 FROM base_data_raw x 
                                WHERE x.SO_VBELN = t.SO_VBELN AND x.SO_POSNR = t.SO_POSNR AND x.SO_NPS = 30
                            ))
                    )`);
                }
                else {
                    queryParts.push(`
                        WITH base_data AS (
                            SELECT DISTINCT ${columnsArray.join(', ')}
                            FROM openOrdersSrv_OpenOrdersAnalytics
                            WHERE ${where}
                        LIMIT ${limit} OFFSET ${offset})`);

                }
                // Line items with sort key
                queryParts.push(`, 
                    line_items_with_sort AS (
                        SELECT 
                            *,
                            FALSE AS "isSubtotal",
                            ROW_NUMBER() OVER (ORDER BY ${finalGroupBy}) AS base_sort_key
                        FROM base_data)`);

                // Union queries
                let unionSelects = [`
                    SELECT *, 
                        base_sort_key * 1000 AS final_sort_key
                    FROM line_items_with_sort`];

                // Add subtotal levels
                for (let level = 1; level <= groupbyArray.length; level++) {

                    const levelGroupBy = groupbyArray.slice(0, level);
                    const levelGroupByWithUnits = [...new Set([...levelGroupBy, ...unitFields])];
                    const levelGroupByStr = levelGroupByWithUnits.join(', ');
                    const subtotalColumns = serviceHelper.buildSubtotalColumns(columnsArray, levelGroupBy, aggrMap, excludeColumns);
                    const cteName = `subtotals_level_${level}`;

                    queryParts.push(`, ${cteName} AS (
                        SELECT 
                            ${subtotalColumns.join(', ')},
                            TRUE AS "isSubtotal",
                            MAX(base_sort_key)  AS base_sort_key
                        FROM line_items_with_sort
                        GROUP BY ${levelGroupByStr})`);

                    const sortOffset = (groupbyArray.length - level) * 100;
                    unionSelects.push(`
                        SELECT *, 
                            base_sort_key * 1000 + ${sortOffset} + ${level} AS final_sort_key
                            FROM ${cteName}`);
                }

                const withClause = queryParts.join('');
                const unionClause = unionSelects.join('\n    UNION ALL');

                finalQuery = `${withClause}
                    SELECT * FROM (
                        ${unionClause}
                    ) AS final_result
                    ORDER BY final_sort_key
                    WITH HINT(USE_HEX_PLAN, HEX_INDEX_JOIN)`;

                try {
                    const result = await cds.run(finalQuery);
                    return result;
                } catch (error) {
                    log.error("[order-monitoring-app-services.js] - subtotal query failed! reason => " + JSON.stringify(error));
                    req.error(400, 'ERROR_SORT_COL');
                }
            }



        });

        this.after("READ", 'OpenOrdersAnalytics', async (data, req) => {
            if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count') {
                return;
            } else {
                let sessionID = req.headers['authorization'] || req.headers['x-username'];
                let query = req.query;
                query.SELECT.where = req.query.SELECT.where;
                const queryString = JSON.stringify(query);
                const queryId = `${sessionID}AMOOQuery`
                sessionCache.set(queryId, queryString);

            }
            data = Array.isArray(data) ? data : [data]
            let dateProps = serviceHelper.getDateProps()
            data.forEach((item) => {
                item.id = uuid.v1()
                if ('SO_NETWR' in item) // Net Amount
                    item.SO_NETWR = formatSpecialCurrencies(item.SO_NETWR, item.SO_WAERK, this._SpecialCurrencies);
                if ('SO_KBETR' in item) // Price Per Unit
                    item.SO_KBETR = formatSpecialCurrencies(item.SO_KBETR, item.SO_WAERK, this._SpecialCurrencies);
                if ('SO_NPS' in item && item.SO_NPS) item.SO_NPS_DESCRIPTION = serviceHelper.getBundle(req.locale).getText(`nps${item.SO_NPS}`)
                if ('SO_ISSUE' in item && item.SO_ISSUE) item.SO_ISSUE_DESCRIPTION = serviceHelper.getBundle(req.locale).getText(`OrderIssue${item.SO_ISSUE}`)
                let mandtFields = serviceHelper.getMandtFields();
                // MANDANT TEXTS LOGIC -------------
                mandtFields.forEach((mandt) => {
                    const mandtProp = item[mandt];
                    if (mandtProp) {
                        let mandtTxtField = mandt + "_TEXT";
                        item[mandtTxtField] = serviceHelper.getMandtFieldsNames(mandtProp);
                    }
                })
                dateProps.forEach((property) => {
                    const dateString = item[property]
                    if (dateString && dateString != "00000000" && dateString != "0000-00-00" && dateString != "--") {
                        const year = parseInt(dateString.substring(0, 4), 10);
                        const month = parseInt(dateString.substring(4, 6), 10) - 1;
                        const day = parseInt(dateString.substring(6, 8), 10);
                        item[property] = new Date(year, month, day);
                    } else {
                        item[property] = null
                    }
                });
            })
        })
        return super.init();
    }
}

module.exports = {
    openOrdersSrv
}


/**
 * Utility method used to remove duplicates
 * @param {array} fields - the fields contained in the original array
 * @param {array} lt_result - the original array with duplicates
 * @return {array} lt_result_final - the resulting array with duplicates removed
 */
function checkScope(req, next, scope) {
    return req.user.is(scope) ? true : false;

}
// Function to build subtotal column expressions
function parseDate(dateString) {
    const year = parseInt(dateString.substring(0, 4), 10);
    const month = parseInt(dateString.substring(4, 6), 10) - 1; // Months are 0-based
    const day = parseInt(dateString.substring(6, 8), 10);
    return new Date(year, month, day);
}
function _buildContactOption(order, item, key, text) {
    return {
        OptionKey: key,
        OptionText: order + " / " + item + " - " + text,
        VBELN: order,
        POSNR: item
    }
}
function sendDeliveryResponse(req, responseDelivery) {
    let messageSet = new Set();
    let error = false;
    responseDelivery = Array.isArray(responseDelivery) ? responseDelivery : [responseDelivery]
    responseDelivery.forEach((item) => {
        if (item.Status === 'E') {
            error = true;
            messageSet.add(item.Message);
        }
    });
    if (error) {
        let message = Array.from(messageSet).join(' ');
        req.error(status.PRECONDITION_FAILED,message);
        return false;
    }
    return true;
}


function encodeParams(params) {
    return Object.entries(params)
        .map(([key, value]) => {
            if (key === 'DueDate') value = `datetime'${value}'`;
            else if (key === 'SalesOrderID') value = `'${value}'`;
            else if (key === 'ItemIDs') value = `'${value.split(',').map(id => id.replace(/^0+/, '')).join(',')}'`;
            else if (key === 'ItemID') value = `'${value.replace(/^0+/, '')}'`
            return `${encodeURIComponent(key)}=${encodeURIComponent(value)}`;
        })
        .join('&');
}
function ODataV2toODataV4DateTime(value) {
    var thenum = value.match(/\d+/)[0];
    if (!thenum)
        return value
    return new Date(Number(thenum)).toISOString()
}