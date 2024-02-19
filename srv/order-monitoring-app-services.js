const cds = require("@sap/cds");
const NodeCache = require('node-cache');
const sessionCache = new NodeCache();
const uuid = require('uuid');
const status = require('http-status');
const textBundle = require('./utils/textBundle')
const log = require("cf-nodejs-logging-support");
const enableHints = require('./plugins/enable_hints')

class srvOpenOrders extends cds.ApplicationService {

    init() {

        this.on("getVBAKAuthObjKeys", async req => {
            let lt_result = [];
            let userID = req.user.id;
            // let authSet = await SELECT.from(VBAKAuthObjectKeys).where ({USERID: userID});
            try {
                const service = await cds.connect.to('authService');
                lt_result = await service.get("/authObjectRequest?authObjName=V_VBAK_VKO&sap-client=100");
            } catch (error) {
                // log.error("[order-monitoring-app-services.js] - Remote service to Cobalt failed ! " + JSON.stringify(error));
                req.error(413, 'ERROR_AUTH_CALL')
            }
                         
            const { VBAKAuthObjectKeys } = await cds.entities ('srvOpenOrders');
            await DELETE.from(VBAKAuthObjectKeys).where ({USERID: userID});

            if (lt_result.length !== 0){
                lt_result.forEach((set) => {
                    set.USERID = userID;
                })

                await INSERT.into(VBAKAuthObjectKeys, lt_result);
            }else{
                return false;
            }           
            return true;
            
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
            const { VBAKAuthObjectKeys } = await cds.entities ('srvOpenOrders');
            let userID = req.user.id;
            let authSet = await SELECT.from(VBAKAuthObjectKeys).where ({USERID: userID});
            if(authSet.length === 0){
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
            const dateProps = [
                "SO_ERDAT_ORDER",
                "SO_ERDAT_ITEM",
                "SO_EDATU_REQUESTED",
                "SO_EDATU_CONFIRMED",
                "SO_LDDAT",
                "SO_PRSDT",
                "SO_F_TDDAT",
                "DL_LFDAT",
                "DL_HSDAT",
                "DL_VFDAT",
                "DL_WADAT",
                "DL_WADAT_IST",
                "TM_DPTBG",
                "TM_DATBG",
                "TM_DPTEN",
                "TM_DATEN",
                "SO_F_LDDAT",
                "TM_AR_DATE"]
            for (let i = 0; i < req.query.SELECT.where.length; i++) {
                const item = req.query.SELECT.where[i];
                if (item.ref && Array.isArray(item.ref) && item.ref.some(prop => dateProps.includes(prop))) {
                  for (let j = i + 1; j < req.query.SELECT.where.length; j++) {
                    if (req.query.SELECT.where[j].val !== undefined) {
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
                    if(partnersQuery.length > 0 ){
                        let queryString = "(" + partnersQuery.join(' or ') + ")";
                        partnersQueryParsed = cds.parse.expr(queryString);
                    }

                    // Add queries to request
                    let requestQuery = req.query.SELECT.where || [];
                    if(partnersQuery.length > 0){
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

            if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count' &&  req.headers?.countcols) {
                try { 
                    const db = cds.transaction(req);
                    let query = cds.parse.cql(`SELECT count(*) from ( SELECT DISTINCT ${req.headers.countcols} from  srvOpenOrders_Results   ) ` )
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
                let query = req.query
                 query.SELECT.where = req.query.SELECT.where
                const queryString = JSON.stringify(query);
                const queryId = `${sessionID}Query`
                sessionCache.set(queryId, queryString);
            }
            if (Array.isArray(data)) {
                var dateProps = [
                "SO_ERDAT_ORDER",
                "SO_ERDAT_ITEM",
                "SO_EDATU_REQUESTED",
                "SO_EDATU_CONFIRMED",
                "SO_LDDAT",
                "SO_PRSDT",
                "SO_F_TDDAT",
                "DL_LFDAT",
                "DL_HSDAT",
                "DL_VFDAT",
                "DL_WADAT",
                "DL_WADAT_IST",
                "TM_DPTBG",
                "TM_DATBG",
                "TM_DPTEN",
                "TM_DATEN",
                "SO_F_LDDAT",
                "TM_AR_DATE"]
                data.forEach((item) => {
                    item.id = uuid.v1()
                    dateProps.forEach((property) => {
                       const dateString = item[property]
                       if (dateString &&  dateString != "00000000" && dateString != "0000-00-00" && dateString != "--"){
                            const year = parseInt(dateString.substring(0, 4), 10);
                            const month = parseInt(dateString.substring(4, 6), 10) - 1; 
                            const day = parseInt(dateString.substring(6, 8), 10);
                            item[property] = new Date(year, month, day);
                        } else{
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
            const { VBAKAuthObjectKeys } = await cds.entities ('srvOpenOrders');
            let userID = req.user.id;
            let authSet = await SELECT.from(VBAKAuthObjectKeys).where ({USERID: userID});
            if(authSet.length === 0){
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
            if (sessionCache.get(queryId) )  {
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
                        const fields = selectedField && selectedField.split(',');
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

                        if(lt_count.length > 0){
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
                        if(lt_count.length > 0){
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
            // since there is a virtual id field, adding a random guid to each record of the result set.
            if (Array.isArray(data)) {
                data.forEach((item) => {
                    item.id = uuid.v1()  
                })
            }
        })

        this.on("READ", "notes", async (req, next) => {
            const service = await cds.connect.to('order_monitoring_services');
            const lt_count = await service.send({ query: req.query })
            return req.reply(lt_count)

        })
        this.on("CREATE", "notes", async (req, next) => {
            const service = await cds.connect.to('order_monitoring_services');
            const lt_count = await service.send({ query: req.query })
            return req.reply(lt_count)

        })
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
        lt_result = lt_result.map(obj => {
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
    return req.user.is(scope) ?  true :  false;
        
}