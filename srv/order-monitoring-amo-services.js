const cds = require("@sap/cds");
const NodeCache = require('node-cache');
const sessionCache = new NodeCache();
const uuid = require('uuid');
const status = require('http-status');
const textBundle = require('./utils/textBundle')
const log = require("cf-nodejs-logging-support");
const enableHints = require("./plugins/enable_hints");
const { startOfToday } = require('date-fns');
const formatSpecialCurrencies = require('./plugins/formatSpecialCurrencies') 
const variantManagement = require('./utils/variantManagement');
const serviceHelper = require('./utils/serviceHelper') 

class srvOpenOrders extends cds.ApplicationService {

    async init() {
        this._SpecialCurrencies = []
        const {currencies} =  cds.entities('openOrdersSrv');
        this._SpecialCurrencies  =  await SELECT.from(currencies)
        this.before('*','*',async(req,next)=>{
            await cds.run(`SET 'APPLICATION' = 'CAPServices'`);
        })


        // test HANDLERS
        this.before("READ", "testEntity", async (req, next) => {
            cds
                .connect("db")
                .then(({ db }) =>
                    db?.before("READ", (req) => enableHints(req)
                    )
                );

            req.query.SELECT.localized = false;
            req.query.SELECT.distinct = true;
        });

        this.on("READ", "testEntity", async (req, next) => {
            if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count' ) {
                return req.reply({ $count: 0 })
            }
            await next(req)
        })

        this.after("READ", "testEntity", async (data, req) => {

        });
        // END OF test HANDLERS

        this.on("getVBAKAuthObjKeys", async req => {
            const { VBAKAuthObjectKeys,EKKOAuthObjectKeys } = await cds.entities ('srvOpenOrders');
            const todayDate = startOfToday().toISOString().slice(0, 19).replace('T', ' ');
            let updateNeeded = false;
            let lt_result = [];
            let lt_resultEC = [];
            let err = []
            let globalError= [] ;
            let userID = req.user.id;

            // VARIANT MIGRATION LOGIC
            let AMOmigrationDone  = await variantManagement.checkIfMigrationNeeded(req,"ordermonitoring.allorders");
            let AMOOmigrationDone  = await variantManagement.checkIfMigrationNeeded(req,"ordermonitoring.openorders");
            if(AMOmigrationDone === "ERROR" || AMOOmigrationDone === "ERROR"){
                err = 3; // variant migration failed
                return err;
            }
            if(AMOmigrationDone || AMOOmigrationDone){
                await UPSERT.into `allorders.db.variantMigration`.entries([{
                    userId : userID,
                    AMOvariantsMigrated : AMOmigrationDone,
                    AMOOVariantsMigrated : AMOOmigrationDone
                }])
                err = 4; // variant migration successful, refresh needed
                return err;       
            }
            // VARIANT MIGRATION LOGIC END
            
            let vbakAuths = await SELECT.from(VBAKAuthObjectKeys).where`USERID = ${userID}`.limit(1);
            // Avoid updating authorizations more than once a day
            // Update only if table empty or outdatedf
            if (vbakAuths.length > 0) {
                if ((vbakAuths[0].LAST_UPDATE === null || vbakAuths[0].LAST_UPDATE < todayDate)) {
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
                    globalError.push({user: 'noCobaltUser',error: error})
                    err = 1 //Cobalt call failed
                }
                /// EC AUTH CALL
                try {
                    const service = await cds.connect.to('authServiceEC');
                     lt_resultEC = await service.get("/authObjectRequest?authObjName=V_VBAK_VKO%2CM_BEST_EKO&sap-client=100");
                } catch (error) {
                    globalError.push({user: 'noECUser',error: error})
                    err = 2 // EC called failed
                }
                await DELETE.from(VBAKAuthObjectKeys).where({ USERID: userID });
                await DELETE.from(EKKOAuthObjectKeys).where({ USERID: userID });

                /// New Authorization scenario
                if(lt_result.VBAK){
                    lt_resultEC.VBAK = lt_resultEC.VBAK || []
                    lt_resultEC.EKKO = lt_resultEC.EKKO || []
                    let lt_vbak = lt_result.VBAK || []
                    let lt_ekko = lt_result.EKKO || []
                    lt_vbak = [...lt_vbak, ...lt_resultEC.VBAK];
                    lt_ekko = [...lt_ekko, ...lt_resultEC.EKKO];
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
                }else{ /// OLD Authorization scenario
                    if (lt_result.length !== 0) {
                        lt_result.forEach((set) => {
                            set.LAST_UPDATE = SQLdate;
                            set.USERID = userID;
                        })
                        await INSERT.into(VBAKAuthObjectKeys, lt_result);
                    }
                }               
            }
            if (globalError.length === 2)
                req.error(globalError[0].error)
            return err;
        });

        /**
         * This event is triggered before the backend request for order list data
         * @param {string} "READ" - The type of backend request
         * @param {string} "Results" - The name of the entity set
         * @param {function} - The callback function containing the code that runs when the event is triggered
         * @param {object} req - The request object containing request details
         * */
        this.before("READ", "Results", async (req, next) => {
            // Check if auth table is filled
            if (req.headers?.export === 'true') await cds.run(`SET 'APPLICATION' = 'CAPServicesExport'`);
            const { VBAKAuthObjectKeys } = await cds.entities('srvOpenOrders');
            let userID = req.user.id;
            let authSet = await SELECT.from(VBAKAuthObjectKeys).where({ USERID: userID });

            if (authSet.length === 0) {
                req.error(413, 'NO_AUTH_LIST')
            }
            cds
                .connect("db")
                .then(({ db }) =>
                    db?.before("READ", (req) => enableHints(req)
                    )
                );

            req.query.SELECT.localized = false;
            req.query.SELECT.distinct = true;
            const dateProps = serviceHelper.getDateProps();
            for (let i = 0; i < req.query.SELECT.where?.length; i++) {
                const item = req.query.SELECT.where[i];
                if (item.ref && Array.isArray(item.ref) && item.ref.some(prop => dateProps.includes(prop))) {
                    for (let j = i + 1; j < req.query.SELECT.where.length; j++) {
                        if (typeof (req.query.SELECT.where[j].val) === 'string' && req.query.SELECT.where[j].val.includes('-') && req.query.SELECT.where[j].val !== undefined && req.query.SELECT.where[j].val !== null) {
                            req.query.SELECT.where[j].val = req.query.SELECT.where[j].val.split('-').join("");
                            break;
                        }
                    }
                }
            }
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
                                partnersQuery.push(`SO_VE_PARTNER = ${partnerNumber}`);
                                break;

                            case 'AS':
                                partnersQuery.push(`SO_AS_PARTNER = ${partnerNumber}`);
                                break;

                            case 'AM':
                                partnersQuery.push(`SO_AM_PARTNER = ${partnerNumber}`);
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
                    const db = cds.transaction(req);
                    let query = cds.parse.cql(`SELECT count(*) from ( SELECT DISTINCT ${req.headers.countcols} from  srvOpenOrders_Results   ) `)
                    if (req.query.SELECT.where) query.SELECT.from.SELECT.where = req.query.SELECT.where
                    const distinctCount = (req.query.SELECT.where) ?
                        await db.run(query)
                        : await db.run(query)
                    return req.reply({ $count: Object.values(distinctCount[0])[0] })
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
                            item.SO_DCP_ITEM_STATUS_DESCRIPTION = getBundle(req.locale).getText(`dcpStatus${item.SO_DCP_ITEM_STATUS}`)
                        }
                    }
                    if ('SO_NETWR' in item) // Net Amount
                        item.SO_NETWR = formatSpecialCurrencies(item.SO_NETWR, item.SO_WAERK, this._SpecialCurrencies);
                    if ('SO_KBETR' in item) // Price Per Unit
                        item.SO_KBETR = formatSpecialCurrencies(item.SO_KBETR, item.SO_WAERK, this._SpecialCurrencies);
                    // MANDANT TEXTS LOGIC -------------
                    mandtFields.forEach((mandt) => {
                        const mandtProp = item[mandt];
                        if(mandtProp){
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
            const db = cds.transaction(req);
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
                let searchString = req._query.$search && req._query.$search.replace(/"/g, '')
                let lowerCaseSearchString = searchString && `%${searchString.toLowerCase()}%`
                if (lowerCaseSearchString) {
                    let where = []
                    if (req._query['$select'] && req._query['$select'].split(',').length > 1) {
                        where = cds.parse.expr(`lower(${req._query['$select'].split(',')[1]}) like '${lowerCaseSearchString}' ESCAPE '^' OR lower(${req._query['$select'].split(',')[0]}) like '${lowerCaseSearchString}' ESCAPE '^'`);
                    } else {
                        where = cds.parse.expr(`lower(${req._query['search-focus']}) like '${lowerCaseSearchString}' ESCAPE '^'`);
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
                        const selectedField = req._query && req._query['$select']
                        let fields = selectedField && selectedField.split(',');
                        // Workaround for DCP STatus - Need a better fix
                        fields = fields.filter(e => e !== 'SO_DCP_ITEM_STATUS_DESCRIPTION');
                        fields = fields.filter((fieldName) => {
                            const mandtFields = serviceHelper.getMandtFields();
                            const mandtTextFields = mandtFields.map((mandtFieldName) => mandtFieldName + "_TEXT");
                            if(mandtTextFields.includes(fieldName)){
                                return false;
                            }else{
                                return true;
                            }
                        });
                        // remove duplicates based on fields in the valuehelp dialog box
                        lt_result = removeDuplicates(fields, lt_result);
                    } catch (error) {
                        req.error(status.EXPECTATION_FAILED, getBundle(req.user.locale).getText("VALUEHELP_NOT_EXECUTED"))
                    }
                } else {
                    try {
                        const fields = req._query["search-focus"].split(',')
                        let queryCount = 0;
                        // sometimes there is a cached query but it has no
                        let lt_count = query.SELECT.where
                            ? await db.run(SELECT.from('srvOpenOrders_Results').columns(`countdistinct(${fields})`).where(query.SELECT.where))
                            : await db.run(SELECT.from('srvOpenOrders_Results').columns(`countdistinct(${fields})`));

                        if (lt_count.length > 0) {
                            queryCount = lt_count[0][Object.keys(lt_count[0])[0]];
                        }
                        lt_result.push({ $count: queryCount })
                    } catch (error) {
                        req.error(status.EXPECTATION_FAILED, getBundle(req.user.locale).getText("VALUEHELP_NOT_EXECUTED"))
                    }

                }

            } else {
                const fields = req._query["search-focus"].split(',')
                // if there is no session id, execute the query directly
                let searchString = req._query.$search && req._query.$search.replace(/"/g, '')
                let lowerCaseSearchString = searchString && `%${searchString.toLowerCase()}%`
                if (lowerCaseSearchString) {
                    let where = []
                    if (req._query['$select'] && req._query['$select'].split(',').length > 1) {
                        where = cds.parse.expr(`lower(${req._query['$select'].split(',')[1]}) like '${lowerCaseSearchString}' ESCAPE '^' OR lower(${req._query['$select'].split(',')[0]}) like '${lowerCaseSearchString}' ESCAPE '^'`);
                    } else {
                        where = cds.parse.expr(`lower(${req._query['search-focus']}) like '${lowerCaseSearchString}' ESCAPE '^'`);
                    }
                    let requestQuery = req.query.SELECT.where || [];
                    where && requestQuery.length != 0 && requestQuery.push('and');
                    where && requestQuery.push(where);
                    req.query.SELECT.where = requestQuery
                    delete req.query.SELECT.search
                }
                if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count') {
                    req.query.SELECT.distinct = true;
                    lt_result = await db.run(req.query)
                    //await cds.run(req.query);
                } else {
                    try {
                        let queryCount = 0;
                        let lt_count = await db.run(SELECT.from('srvOpenOrders_Results').columns(`countdistinct(${fields})`))
                        if (lt_count.length > 0) {
                            queryCount = lt_count[0][Object.keys(lt_count[0])[0]];
                        }
                        lt_result.push({ $count: queryCount })
                    } catch (error) {
                        req.error(error)
                    }

                }
            }
            if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count' && req.query.SELECT.search) {
                lt_result = lt_result.filter((item) => {
                    for (const prop in item) {
                        if (item[prop] === null) return false;
                        // convert to lowercase both sides in order to avoid case sensitivity issues when searching
                        if (item[prop].toLowerCase().includes(req.query.SELECT.search[0].val.toLowerCase())) {
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
                        if(mandtProp){
                            let mandtTxtField = mandt + "_TEXT";
                            item[mandtTxtField] = serviceHelper.getMandtFieldsNames(mandtProp);
                        }
                    })
                    if ('SO_DCP_ITEM_STATUS' in item) {
                        if (item.SO_DCP_ITEM_STATUS) {
                            item.SO_DCP_ITEM_STATUS_DESCRIPTION = getBundle(req.locale).getText(`dcpStatus${item.SO_DCP_ITEM_STATUS}`)
                        }
                    }
                })
            }
        })

        this.before("CREATE", "notes", async (req) => {
            const { notes } = await cds.entities('srvOpenOrders');
            req.query.INSERT.entries.forEach(async (entry) => {
                req.query.INSERT.entries[0].LAST_NOTE_FLAG = 'X'
                await UPDATE(notes).set({ LAST_NOTE_FLAG: ' ' }).where({ VBELN: entry.VBELN, POSNR: entry.POSNR, LAST_NOTE_FLAG: 'X' });
            })
        })


        this.after("DELETE", "notes", async (data, req) => {
            const { notes } = await cds.entities('srvOpenOrders');
            let note = await SELECT.from(notes).where({ VBELN: req.data.VBELN, POSNR: req.data.POSNR }).orderBy('UTCTIME desc').limit(1)
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
function removeDuplicates(fields, lt_result) {
    if (fields) {
        lt_result = lt_result
            // .filter(obj => {
            //     // if all values are null, then allNull will be true
            //     // if not, allNull will be false
            //     // return value is the opposite of that to do the right filtering
            //     var allNull = fields.every(field => obj[field] === null);
            //     return !allNull;
            // })
            .filter(obj => fields.every(field => obj[field] !== null)) // Remove null values
            .map(obj => {
                const newObj = {};
                fields.forEach(field => newObj[field] = obj[field]);
                return newObj;
            });
    } else {
        // lt_result = lt_result.map((obj) => (obj));
    }
    let lt_result_final = [...new Set(lt_result.map(JSON.stringify))].map(JSON.parse);
    return lt_result_final;
}
function getBundle(locale) {
    return textBundle.getTextBundle(locale)
}
function checkScope(req, next, scope) {
    return req.user.is(scope) ? true : false;

}