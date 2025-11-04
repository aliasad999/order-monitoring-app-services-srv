const cds = require("@sap/cds");
const NodeCache = require('node-cache');
const sessionCache = new NodeCache();
const uuid = require('uuid');
const status = require('http-status').status;
const log = require("cf-nodejs-logging-support");
const { startOfToday, subDays } = require('date-fns');
const formatSpecialCurrencies = require('./plugins/formatSpecialCurrencies')
const serviceHelper = require('./utils/serviceHelper');

class srvOpenOrders extends cds.ApplicationService {

    async init() {
        this._SpecialCurrencies = []
        const { currencies } = cds.entities('openOrdersSrv');
        const { Results } = cds.entities('srvOpenOrders')
        this._SpecialCurrencies = await SELECT.from(currencies);
        this._textKeys = []
        let data = Results.elements
        for (let key in data) {
            if (data[key]["@Common.Text"] && data[key]["@Common.Text"]["="]) {
                switch (key) {
                    case 'SO_DCP_ITEM_STATUS':
                        this._textKeys.push({ key: key, value: 'SO_DCP_ITEM_STATUS' });
                        break;
                    default:
                        this._textKeys.push({ key: key, value: data[key]["@Common.Text"]["="] });
                        break;
                }
            }
        }
        this.before('*', '*', async (req, next) => {
            await cds.run(`SET 'APPLICATION' = 'CAPServices'`);
        })

        this.on("getUserRegionAssigned", async req => {
            const { RegionSettings } = await cds.entities('srvOpenOrders');
            let region = await SELECT.from(RegionSettings).byKey({ USER_ID: req.user.id });
            if(!region){
                return {
                    USER_ID: req.user.id,
                    REGION: 0,
                    REGION_2: 0
                }
            }else{
                return region;
            }
        })

        this.on("getVBAKAuthObjKeys", async req => {
            let bForceRefresh = req.data.forceRefresh;
            const { VBAKAuthObjectKeys, EKKOAuthObjectKeys } = await cds.entities('srvOpenOrders');
            // Get one month ago date
            const OneMonthAgoDate = subDays(startOfToday(), 30).toISOString().slice(0, 19).replace('T', ' ');
            // const todayDate = startOfToday().toISOString().slice(0, 19).replace('T', ' ');
            let updateNeeded = false;
            let lt_result = [];
            // let lt_resultEC = [];
            let lt_resultAP = [];
            let lt_resultAPEKKO = [];
            let lt_resultMercury = [];
            let lt_resultMercuryEKKO = [];
            let errorSet = []
            let globalError = [];
            let userID = req.user.id;

            let vbakAuths = await SELECT.from(VBAKAuthObjectKeys).where`USERID = ${userID}`.limit(1);
            // Avoid updating authorizations more than once a week
            // Update only if table empty or outdatedf
            if(bForceRefresh){ // manual refresh triggered by the user, update always
                updateNeeded = true;
            }else if (vbakAuths.length > 0) {
                if ((vbakAuths[0].LAST_UPDATE === null || vbakAuths[0].LAST_UPDATE < OneMonthAgoDate)) {
                    updateNeeded = true;
                }
            } else {
                updateNeeded = true;
            }

            if (updateNeeded) {
                let SQLdate = new Date().toISOString().slice(0, 19).replace('T', ' ');
                /// COBALT AUTH CALL
                try {
                    const service = await cds.connect.to('authService');
                    lt_result = await service.get("/authObjectRequest?authObjName=V_VBAK_VKO%2CM_BEST_EKO&sap-client=100");
                } catch (error) {
                    globalError.push({ user: 'cobaltNotAvailable', error: error })
                    errorSet.push({errorCode: "COBALTGLOBAL"});
                }
                /// AP CALL
                try {
                    const service = await cds.connect.to('authServiceAP');
                    lt_resultAP = await service.send({
                        method: "GET",
                        path: "/xBASFxVBAKAUTH?$format=json",
                        headers: {
                            "Accept-Encoding": "",
                            'X-Basf-Sap-Client': process.env.AP_CLIENT
                        }
                    });

                    // Only execute the second call if the first one succeeds
                    try {
                        lt_resultAPEKKO = await service.send({
                            method: "GET",
                            path: "/xBASFxEKKOAUTH?$format=json",
                            headers: {
                                "Accept-Encoding": "",
                                'X-Basf-Sap-Client': process.env.AP_CLIENT
                            }
                        });
                    } catch (error) {
                        globalError.push({ user: 'apNotAvailable', error: error });
                        errorSet.push({errorCode: "APPO"});
                    }

                } catch (error) {
                    globalError.push({ user: 'apNotAvailable', error: error });
                    errorSet.push({errorCode: "APSO"});
                }
                if (process.env.SUBACCOUNT === 'DEV'){
                    // MERCURY Auth call
                    try {
                        const service = await cds.connect.to('OMServicesMercury');
                        lt_resultMercury = await service.send({
                            method: "GET",
                            path: "/xBASFxVBAKAUTH?$format=json",
                            headers: {
                                "Accept-Encoding": "",
                                'X-Basf-Sap-Client': process.env.MERCURY_CLIENT
                            }
                        });

                        // Only execute the second call if the first one succeeds
                        try {
                            lt_resultMercuryEKKO = await service.send({
                                method: "GET",
                                path: "/xBASFxEKKOAUTH?$format=json",
                                headers: {
                                    "Accept-Encoding": "",
                                    'X-Basf-Sap-Client': process.env.MERCURY_CLIENT
                                }
                            });
                        } catch (error) {
                            globalError.push({ user: 'mercuryNotAvailable', error: error });
                            errorSet.push({errorCode: "MERCURYPO"});
                        }

                    } catch (error) {
                        globalError.push({ user: 'mercuryNotAvailable', error: error });
                        errorSet.push({errorCode: "MERCURYSO"});
                    }
                }
                // Mercury Auth call
                // OTC-1010881 Fault Tolerance if Cobalt is not available due to downtimes
                // | cobaltNotAvailable | apNotAvailable | MercuryNotAvailable | Result |
                // | ❌                 | ❌            | ❌             | ❌ Fail |
                // | ❌                 | ✅            | ❌             | ✅ Pass |
                // | ❌                 | ✅            | ✅             | ✅ Pass |
                // | ✅                 | ❌            | ❌             | ✅ Pass |
                // | ✅                 | ✅            | ❌             | ✅ Pass |
                // | ✅                 | ❌            | ✅             | ✅ Pass |
                // | ✅                 | ✅            | ✅             | ✅ Pass |


                const CobaltNotAvailableFlag = globalError.some(e => e.user === 'cobaltNotAvailable');
                const ApNotAvailable = globalError.some(e => e.user === 'apNotAvailable');
                if (CobaltNotAvailableFlag && ApNotAvailable) {
                    // Return an error so we can inform the user
                    return JSON.stringify([{errorCode: "GLOBALFAIL"}]);
                } 
                // OTC-1010881 Fault Tolerance if Cobalt is not available due to downtimes
                await DELETE.from(VBAKAuthObjectKeys).where({ USERID: userID });
                await DELETE.from(EKKOAuthObjectKeys).where({ USERID: userID });

                /// New Authorization scenario
                if (lt_result.VBAK) {
                    // lt_resultEC.VBAK = lt_resultEC.VBAK || []
                    // lt_resultEC.EKKO = lt_resultEC.EKKO || []
                    lt_resultAP = lt_resultAP || []
                    lt_resultAPEKKO = lt_resultAPEKKO || []
                    lt_resultMercuryEKKO = lt_resultMercuryEKKO || []                  
                    lt_resultMercuryEKKO = lt_resultMercuryEKKO || []
                    let lt_vbak = lt_result.VBAK || []
                    let lt_ekko = lt_result.EKKO || []
                    lt_vbak = [
                        ...lt_vbak,
                        // ...(lt_resultEC?.VBAK ?? []),
                        ...(lt_resultAP.d?.results ?? []).map(({ vkorg, vtweg, spart }) => ({
                            VKORG: vkorg,
                            VTWEG: vtweg,
                            SPART: spart
                        })),
                        ...(lt_resultMercury ?? []).map(({ vkorg, vtweg, spart }) => ({
                            VKORG: vkorg,
                            VTWEG: vtweg,
                            SPART: spart
                        }))];
                    lt_ekko = [...lt_ekko, 
                        // ...lt_resultEC?.EKKO ?? [], 
                        ...(lt_resultAPEKKO?.d?.results ?? []).map(({ PurchasingOrganization }) => ({
                            EKORG: PurchasingOrganization
                        })),
                        ...(lt_resultMercuryEKKO ?? []).map(({ PurchasingOrganization }) => ({
                            EKORG: PurchasingOrganization
                        }))];
                    const vbakSet = new Set();
                    const lt_vbakUnique = lt_vbak.filter(obj => {
                        const key = `${obj.VKORG}-${obj.VTWEG}-${obj.SPART}`;
                        if (vbakSet.has(key)) {
                            return false;
                        }
                        vbakSet.add(key);
                        return true;
                    });
                    if (lt_vbakUnique.length !== 0) {
                        lt_vbakUnique.forEach((set) => {
                            set.LAST_UPDATE = SQLdate;
                            set.USERID = userID;
                        })
                        await INSERT.into(VBAKAuthObjectKeys, lt_vbakUnique);
                    }
                    let ekkoSet = new Set();
                    const lt_ekkoUnique = lt_ekko.filter(item => {
                        if (ekkoSet.has(item.EKORG)) {
                            return false;
                        }
                        ekkoSet.add(item.EKORG);
                        return true;
                    });
                    if (lt_ekkoUnique.length !== 0) {
                        lt_ekkoUnique.forEach((set) => {
                            set.LAST_UPDATE = SQLdate;
                            set.USERID = userID;
                        })
                        await INSERT.into(EKKOAuthObjectKeys, lt_ekkoUnique);
                    }
                    // return true;
                } else { /// OLD Authorization scenario
                    if (lt_result.length !== 0) {
                        lt_result.forEach((set) => {
                            set.LAST_UPDATE = SQLdate;
                            set.USERID = userID;
                        })
                        await INSERT.into(VBAKAuthObjectKeys, lt_result);
                    }
                }
            }
            // if (globalError.length === 2)
            //     req.error(globalError[0].error)
            return JSON.stringify(errorSet);
        });

        /**
         * This event is triggered before the backend request for order list data
         * @param {string} "READ" - The type of backend request
         * @param {string} "Results" - The name of the entity set
         * @param {function} - The callback function containing the code that runs when the event is triggered
         * @param {object} req - The request object containing request details
         * */
        this.before("READ", "Results", async (req, next) => {
            // is not empty date field, date value needs to be adjusted
            req.query.SELECT.where = serviceHelper.replaceDateInArray(req.query.SELECT.where)
            // is not empty date field, date value needs to be adjusted
            // Check if auth table is filled
            if (req.headers?.export === 'true') await cds.run(`SET 'APPLICATION' = 'CAPServicesExport'`);
            const { VBAKAuthObjectKeys } = await cds.entities('srvOpenOrders');
            let userID = req.user.id;
            let authSet = await SELECT.from(VBAKAuthObjectKeys).where({ USERID: userID });

            if (authSet.length === 0) {
                req.error(413, 'NO_AUTH_LIST')
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
            // Transform date filters from YYYY-MM-DD to YYYYMMDD
            serviceHelper.transformDateFilters(req.query.SELECT.where);
        });

        this.on("READ", "Results", async (req, next) => {
            // OTC-24554 Partner Settings Functionality
            // Begin of Code OTC-24554
            // *-------------------------------------------------------------------*
            // Consider also partner settings, if they are maintained
            let db = cds.transaction(req);
            let currentUser = req.user.id;
            if (currentUser) {
                let partnerSettingsQuery = cds.parse.cql(`SELECT from srvOpenOrders_PartnerSettings where BASF_USER = '${currentUser}' and ACTIVE = 'X'`);
                let partnerSettings = await db.run(partnerSettingsQuery);
                if (partnerSettings.length !== 0) {
                    let partnersQuery = [];
                    for (let settingsEntry of partnerSettings) {
                        let partnerNumber = settingsEntry.PARTNER_NUMBER;
                        switch (settingsEntry.PARTNER_ROLE) {
                            case 'VE':
                                partnersQuery.push(`SO_VE_PARTNER = '${partnerNumber}'`);
                                break;

                            case 'AS':
                                partnersQuery.push(`SO_AS_PARTNER = '${partnerNumber}'`);
                                break;

                            case 'AM':
                                partnersQuery.push(`SO_AM_PARTNER = '${partnerNumber}'`);
                                break;

                            // Added with user story 851475
                            case 'AD':
                                partnersQuery.push(`SO_AD_PARTNER = '${partnerNumber}'`);
                                break;

                            case 'Z5':
                                partnersQuery.push(`SO_Z5_PARTNER = '${partnerNumber}'`);
                                break;

                            case 'SB':
                                partnersQuery.push(`SO_SB_PARTNER = '${partnerNumber}'`);
                                break;
                            // Added with user story 851475 
                            case 'OM':
                                partnersQuery.push(`SO_OM_PARTNER = '${partnerNumber}'`);
                                break;
                            case 'AH':
                                partnersQuery.push(`SO_AH_PARTNER = '${partnerNumber}'`);
                                break;
                            default:
                                break;
                        }
                    }

                    let partnersQueryParsed;
                    // Construct queries 
                    if (partnersQuery.length > 0) {
                        let queryString = "(" + partnersQuery.join(' or ') + ")";
                        partnersQueryParsed = cds.parse.expr(queryString);
                    }

                    // Add queries to request
                    let requestQuery = req.query.SELECT.where || [];
                    if (partnersQuery.length > 0) {
                        if (requestQuery.length > 0) {
                            requestQuery.push('and');
                        }
                        requestQuery.push(partnersQueryParsed);
                    }

                    req.query.SELECT.where = requestQuery
                }
            }
            // *-------------------------------------------------------------------*
            // End of Code OTC-24554

            if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count' && req.headers?.countcols) {
                try {
                    const db = cds.tx(req);
                    const countCols = req.headers.countcols; // Define count columns
                    const distinctQuery = SELECT.distinct(countCols)
                            .from('srvOpenOrders.Results')
                            .hints('USE_HEX_PLAN', 'HEX_INDEX_JOIN');
                    const query =  SELECT.from(distinctQuery).columns('count(*) as total');
                    if (req.query.SELECT.where) query.SELECT.from.SELECT.where = req.query.SELECT.where
                    const distinctCount = await db.run(query);
                    return req.reply({ $count: distinctCount[0].total })
                } catch (error) {
                    log.error("[order-monitoring-app-services.js] - Count query failed ! " + JSON.stringify(error));
                    req.error(error)
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

        this.after("READ", "Results", async (data, req) => {
            // needed for cache .. to make value helps dynamic. we are using unique session ID to cache based on authorization token.
            let sessionID = req.headers['authorization'] || req.headers['x-username'];
            if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count' && req.headers?.select) {
                // do nothing
            } else {
                // cache the query, so that all filter conditions can be consumed.. when any valuehelp is called.
                let query = req.query;
                query.SELECT.where = req.query.SELECT.where;
                const queryString = JSON.stringify(query);
                const queryId = `${sessionID}Query`
                sessionCache.set(queryId, queryString);
            }
            if (Array.isArray(data)) {
                var dateProps = serviceHelper.getDateProps();
                const mandtFields = serviceHelper.getMandtFields();
                data.forEach((item) => {
                    item.id = uuid.v1()
                    if ('SO_DCP_ITEM_STATUS' in item) {
                        if (item.SO_DCP_ITEM_STATUS) {
                            item.SO_DCP_ITEM_STATUS_DESCRIPTION = serviceHelper.getBundle(req.locale).getText(`dcpStatus${item.SO_DCP_ITEM_STATUS}`)
                        }
                    }
                    if ('SO_NETWR' in item) // Net Amount
                        item.SO_NETWR = formatSpecialCurrencies(item.SO_NETWR, item.SO_WAERK, this._SpecialCurrencies);
                    if ('SO_KBETR' in item) // Price Per Unit
                        item.SO_KBETR = formatSpecialCurrencies(item.SO_KBETR, item.SO_WAERK, this._SpecialCurrencies);
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

        /**
         * This event is triggered before the backend request for order list data
         * @param {string} "READ" - The type of backend request
         * @param {string} "valueHelps" - The name of the entity set
         * @param {function} - The callback function containing the code that runs when the event is triggered
         * @param {object} req - The request object containing request details
         * */
        this.before("READ", "valueHelps", async (req) => {
            // Check if auth table is filled
            const { VBAKAuthObjectKeys } = await cds.entities('srvOpenOrders');
            let userID = req.user.id;
            let authSet = await SELECT.from(VBAKAuthObjectKeys).where({ USERID: userID });
            if (authSet.length === 0) {
                req.error(413, 'NO_AUTH_VALUE_HELP')
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
            const queryId = `${sessionID}Query`
            const db = cds.tx(req);
            let lt_result = []
            // if session id is there, get the cach-ed query and execute it.
            if (sessionCache.get(queryId)) {
                const queryString = sessionCache.get(queryId);
                const query = JSON.parse(queryString);
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
                    query.SELECT.orderBy.length = 0;
                    query.SELECT.orderBy = req.query.SELECT.orderBy;
                    try {
                        lt_result = await db.run(query)
                        //lt_result = await cds.run(query);
                        // req.header.select will have the string of visible columns. 
                        //this parameater has been manually set to header on every request
                        const selectedField = req.http.req.query && req.http.req.query['$select']
                        let fields = selectedField && selectedField.split(',');
                        if(fields){
                            // Workaround for DCP STatus - Need a better fix
                            fields = fields.filter(e => e !== 'SO_DCP_ITEM_STATUS_DESCRIPTION');
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
                        log.error("AMO VH with Session: " + error.message +  " || " + req.user.id + " || " + JSON.stringify(req.query.SELECT)  + " || " + JSON.stringify(req.query.SELECT.where));
                        req.error(status.EXPECTATION_FAILED, serviceHelper.getBundle(req.locale).getText("VALUEHELP_NOT_EXECUTED"))
                    }
                } else {
                    try {
                        const fields = req.http.req.query["search-focus"].split(',')
                        let queryCount = 0;
                        // We need an orderBy clause to make the query performant
                        let keyField = fields[0];
                        let subquery = SELECT.distinct(...fields)
                            .from('srvOpenOrders.Results')
                            .orderBy(keyField)
                            .hints('USE_HEX_PLAN', 'HEX_INDEX_JOIN');
                        // Add where clause if needed
                        if(query.SELECT.where){
                            subquery = subquery.where(query.SELECT.where);
                        }
                        // Run the count query
                        const distinctCount = await SELECT.from(subquery).columns('count(*) as total');
                        if (distinctCount.length > 0) {
                            queryCount = distinctCount[0].total;
                        }
                        lt_result.push({ $count: queryCount })
                    } catch (error) {
                        log.error("AMO VH count with Session: " + error.message +  " || " + req.user.id + " || " + JSON.stringify(req.query.SELECT)  + " || " + JSON.stringify(req.query.SELECT.where));
                        req.error(status.EXPECTATION_FAILED, serviceHelper.getBundle(req.locale).getText("VALUEHELP_NOT_EXECUTED"))
                    }

                }

            } else {
                const fields = req.http.req.query["search-focus"] && req.http.req.query["search-focus"].split(',')
                    if (!fields) {
                        req.error(status.EXPECTATION_FAILED, 'ERR_VALUE_HELP_NO_CACHE')
                        log.error(`[order-monitoring-app-services.js] - AMO VH without Session search-focus undefined:  user: ${req.user.id} SELECT:${JSON.stringify(req.query.SELECT)} WHERE:${JSON.stringify(req.query.SELECT.where)}`);
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
                    // req.query.SELECT.distinct = true;
                    let finalQuery = SELECT.distinct.from(Results).columns(req.query.SELECT.columns).where(req.query.SELECT.where).orderBy(req.query.SELECT.orderBy);
                    try{
                        lt_result = await db.run(finalQuery)
                    }catch(error){
                        log.error("AMO VH without Session: " + error.message +  " || " + req.user.id + " || " + JSON.stringify(req.query.SELECT)  + " || " + JSON.stringify(req.query.SELECT.where));
                    }
                    //await cds.run(req.query);
                } else {
                    try {
                        let queryCount = 0;
                        // We need an orderBy clause to make the query performant
                        let keyField = fields[0];
                        let subquery = SELECT.distinct(...fields)
                            .from('srvOpenOrders.Results')
                            .orderBy(keyField)
                            .hints('USE_HEX_PLAN', 'HEX_INDEX_JOIN');
                        // Add where clause if needed
                        if(req.query.SELECT.where){
                            subquery = subquery.where(req.query.SELECT.where);
                        }
                        // Run the count query
                        const distinctCount = await SELECT.from(subquery).columns('count(*) as total');
                        if (distinctCount.length > 0) {
                            queryCount = distinctCount[0].total;
                        }
                        lt_result.push({ $count: queryCount })
                    } catch (error) {
                        log.error("AMO VH count without Session: " + error.message +  " || " + req.user.id + " || " + JSON.stringify(req.query.SELECT)  + " || " + JSON.stringify(req.query.SELECT.where));
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
            if (Array.isArray(data)) {
                data.forEach((item) => {
                    item.id = uuid.v1();
                    let mandtFields = serviceHelper.getMandtFields();
                    // MANDANT TEXTS LOGIC -------------
                    mandtFields.forEach((mandt) => {
                        const mandtProp = item[mandt];
                        if (mandtProp) {
                            let mandtTxtField = mandt + "_TEXT";
                            item[mandtTxtField] = serviceHelper.getMandtFieldsNames(mandtProp);
                        }
                    })
                    if ('SO_DCP_ITEM_STATUS' in item) {
                        if (item.SO_DCP_ITEM_STATUS) {
                            item.SO_DCP_ITEM_STATUS_DESCRIPTION = serviceHelper.getBundle(req.locale).getText(`dcpStatus${item.SO_DCP_ITEM_STATUS}`)
                        }
                    }
                })
            }
        })

        this.before("CREATE", "notes", async (req) => {
            const { notes } = await cds.entities('srvOpenOrders');
            req.query.INSERT.entries.forEach(async (entry) => {
                if(entry.LAST_NOTE_FLAG != "Y"){
                    req.query.INSERT.entries[0].LAST_NOTE_FLAG = 'X'
                    await UPDATE(notes).set({ LAST_NOTE_FLAG: ' ' }).where({ VBELN: entry.VBELN, POSNR: entry.POSNR, LAST_NOTE_FLAG: 'X' });
                }
            })
        })
        // OTC-1018723 - Last note should only be deleted by the user who created it
        this.on("DELETE", "notes", async(req,next)=>{
            const { notes } = await cds.entities('srvOpenOrders');
            const users = await SELECT.columns('USERNAME').from(notes).where({VBELN: req.data.VBELN, POSNR: req.data.POSNR,UTCTIME: req.data.UTCTIME, USERNAME: req.user.id})
            if (users && users.length > 0 )
                return  await next(req);
            else
                return req.error(status.CONFLICT,'NOTESNOTDELETED_USER_DIFFERENT')
            
        })
        // OTC-1018723 - Last note should only be deleted by the user who created it
        this.after("DELETE", "notes", async (data, req) => {
            const { notes } = await cds.entities('srvOpenOrders');
            let note = await SELECT.from(notes).where({ VBELN: req.data.VBELN, POSNR: req.data.POSNR,LAST_NOTE_FLAG: { '!=': 'Y' } }).orderBy('UTCTIME desc').limit(1)
            if (note.length > 0 && req.data.UTCTIME > note[0].UTCTIME) {
                await UPDATE(notes).set({ LAST_NOTE_FLAG: 'X' }).where({ VBELN: req.data.VBELN, POSNR: req.data.POSNR, UTCTIME: note[0].UTCTIME });
            }
        })

        this.on("CREATE", "ShipmentMarkedDelivered", async (req) => {

            try {
                const AMOOService = await cds.connect.to('AMOOUtilsService');
                const postReq = await AMOOService.tx(req).send({
                    query: req.query
                });

                return postReq;

            } catch (error) {
                req.error(413, error.message || 'An error occurred while updating the shipment');
            }
        });

        this.on("DELETE", "ShipmentMarkedDelivered", async (req) => {
            try {
                const AMOOService = await cds.connect.to('AMOOUtilsService');
                const deleteReq = await AMOOService.tx(req).send({
                    query: req.query
                });

                return deleteReq;

            } catch (error) {
                if (error.reason.response.status === 204) {
                    // This is not an error, supress it
                    return null;
                }
                req.error(413, error.message || 'An error occurred while deleting the shipment');
            }
        });


        this.on("READ", "ChangeDocSet", async req => {
            let lt_changeDocs = [];
            try {
                const apiManagementService = await cds.connect.to('CSEUCockpitService');

                lt_changeDocs = await apiManagementService.tx(req).send({
                    query: req.query
                });
            } catch (error) {
                req.error(413, error)
            }

            return lt_changeDocs;
        });

        this.on("CREATE", "RegionSettings", async (req) => {
            const { RegionSettings } = await cds.entities('srvOpenOrders');
            req.data.USER_ID = req.user.id;
            await UPSERT.into(RegionSettings).entries([req.data]);
        });

        return super.init();
    }
}

module.exports = {
    srvOpenOrders
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