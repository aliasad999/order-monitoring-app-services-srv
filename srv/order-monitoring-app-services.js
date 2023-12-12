const cds = require("@sap/cds");
const NodeCache = require('node-cache');
const sessionCache = new NodeCache();
const uuid = require('uuid');
const status = require('http-status');
const textBundle = require('./utils/textBundle')
const log = require("cf-nodejs-logging-support");

class srvOpenOrders extends cds.ApplicationService {

    init() {

        this.on("getVBAKAuthObjKeys", async req => {
            let query = "GET /authObjectRequest?authObjName=V_VBAK_VKO&sap-client=100";
            if(req.data.isDevSystem){
                query += "&isDevEnv=X";
            }
            let lt_result = [];
            // let lt_result = [{"VKORG":"0001","VTWEG":"01","SPART":"01"},{"VKORG":"1000","VTWEG":"01","SPART":"01"},{"VKORG":"1000","VTWEG":"02","SPART":"02"}];
            try {
                const service = await cds.connect.to('authService');
                lt_result = await service.run(query);
            } catch (error) {
                log.error("[order-monitoring-app-services.js] - Remote service to Cobalt failed ! " + JSON.stringify(error));
                req.error(413, 'remote service to Cobalt could not be executed')
            }

            let authObject = null;
            let finalQuery = "";
            // DEV ENVIRONMENT
            if(req.data.isDevSystem){
                if (lt_result.length === 0)
                return req.error(404, 'no authorization profile attached to user')

                let finalQueryPieces = [];
                lt_result.forEach((set) => {
                    let vkorg = `SO_VKORG = '${set.VKORG}'`;
                    let vtweg = `SO_VTWEG = '${set.VTWEG}'`;
                    let spart = `SO_SPART = '${set.SPART}'`;                    
                
                    let profileQuery = `( ${vkorg} and ${vtweg} and ${spart})`;
                    finalQueryPieces.push(profileQuery);
                })

                finalQuery = `(${finalQueryPieces.join(" or ")})`;
                
            }else{ // OTHER ENVIRONMENTS
                if (!lt_result)
                return req.error(404, 'no authorization profile attached to user')
                let vkorg = [];
                let vtweg = [];
                let spart = [];
                
                const salesOrgs = lt_result.VKORG
                const distributionChannels = lt_result.VTWEG;
                const divisions = lt_result.SPART;
                salesOrgs && salesOrgs.length != 0 && salesOrgs.forEach((salesOrg) => {
                    vkorg.push(`SO_VKORG = '${salesOrg}'`);
                })
                distributionChannels && distributionChannels.length != 0 && distributionChannels.forEach((distributionChannel) => {
                    vtweg.push(`SO_VTWEG = '${distributionChannel}'`);
                })
                divisions && divisions.length != 0 && divisions.forEach((division) => {
                    spart.push(`SO_SPART = '${division}'`);
                })

                
                authObject.vkOrgQuery = vkorg.length !== 0 ? cds.parse.expr(vkorg.join(' or ')) : null;
                authObject.vkwegQuery = vtweg.length !== 0 ? cds.parse.expr(vtweg.join(' or ')) : null;
                authObject.spartQuery = spart.length !== 0 ? cds.parse.expr(spart.join(' or ')) : null;


            }
            
            // let entry = [{ "VKORG" : "0003" , "VTWEG" : "01", "SPART": "01"}, { "VKORG" : "0004" , "VTWEG" : "02", "SPART": "02"}];
            // helper.setAuthObject(authObject);
            let sessionID = req.headers['authorization'] || req.headers['x-username'];
            const queryId = `${sessionID}AuthObjectString`
            sessionCache.set(queryId, finalQuery);
            return [];
        });

        /**
         * This event is triggered before the backend request for order list data
         * @param {string} "READ" - The type of backend request
         * @param {string} "Results" - The name of the entity set
         * @param {function} - The callback function containing the code that runs when the event is triggered
         * @param {object} req - The request object containing request details
         * */
        this.before("READ", "Results", async (req, next) => {                      
            req.query.SELECT.distinct = true;
            // user story: OTC-183934
            if (!checkScope(req, next, 'SystemScope')){
                let sessionID = req.headers['authorization'] || req.headers['x-username'];
                const queryId = `${sessionID}AuthObjectString`
                let authObject = sessionCache.get(queryId);
                if(authObject){
                    var authObjectWhereClause = cds.parse.expr(authObject);
                }
                
                // let vkorg = [];
                // let vtweg = [];
                // let spart = [];
                // let lt_result = {};
                // try {
                //     const service = await cds.connect.to('authService');
                //     const query = "GET /authObjectRequest?authObjName=V_VBAK_VKO&sap-client=100";
                //     lt_result = await service.run(query);
                // } catch (error) {
                //     log.error("[order-monitoring-app-services.js] - Remote service to Cobalt failed ! " + JSON.stringify(error));
                //     req.error(413, 'remote service to Cobalt could not be executed')
                // }
                // if (!lt_result)
                // return req.error(404, 'no authorization profile attached to user')
                // const salesOrgs = lt_result.VKORG
                // const distributionChannels = lt_result.VTWEG;
                // const divisions = lt_result.SPART;
                // salesOrgs && salesOrgs.length != 0 && salesOrgs.forEach((salesOrg) => {
                //     vkorg.push(`SO_VKORG = '${salesOrg}'`);
                // })
                // distributionChannels && distributionChannels.length != 0 && distributionChannels.forEach((distributionChannel) => {
                //     vtweg.push(`SO_VTWEG = '${distributionChannel}'`);
                // })
                // divisions && divisions.length != 0 && divisions.forEach((division) => {
                //     spart.push(`SO_SPART = '${division}'`);
                // })
        
        
                // let vkOrgQuery = vkorg.length !== 0 ? cds.parse.expr(vkorg.join(' or ')) : null;
                // let vkwegQuery = vtweg.length !== 0 ? cds.parse.expr(vtweg.join(' or ')) : null;
                // let spartQuery = spart.length !== 0 ? cds.parse.expr(spart.join(' or ')) : null;
                // let where = req.query.SELECT.where || [];
                // where.length != 0 && authObject.vkOrgQuery && authObject.vkOrgQuery.length != 0 && where.push('and');
                // authObject.vkOrgQuery && where.push(authObject.vkOrgQuery);
                // where.length != 0 && authObject.vkwegQuery && authObject.vkwegQuery.length != 0 && where.push('and');
                // authObject.vkwegQuery && where.push(authObject.vkwegQuery);
                // where.length !== 0 && authObject.spartQuery && authObject.spartQuery.length != 0 && where.push('and');
                // authObject.spartQuery && where.push(authObject.spartQuery);


                let where = req.query.SELECT.where || [];
                where.length != 0 && authObjectWhereClause && authObjectWhereClause.length != 0 && where.push('and');
                if(authObject){
                    where.push(authObjectWhereClause);
                }
                req.query.SELECT.where = where;
            }

        });
        
        this.on("READ", "Results", async (req, next) => {
            // OTC-24554 Partner Settings Functionality
            // Begin of Code OTC-24554
            // *-------------------------------------------------------------------*
            // Consider also partner settings, if they are maintained
            let db = cds.transaction(req);
            let currentUser = req.headers['active-user']
            if (currentUser) {
                let partnerSettingsQuery = cds.parse.cql(`SELECT from srvOpenOrders_PartnerSettings where BASF_USER = '${currentUser}' and ACTIVE = 'X'`);
                let partnerSettings = await db.run(partnerSettingsQuery);
                if (partnerSettings.length !== 0) {
                    let VEPartners = [];
                    let ASPartners = [];
                    let AMPartners = [];
                    for (let settingsEntry of partnerSettings) {
                        let partnerNumber = settingsEntry.PARTNER_NUMBER;
                        switch (settingsEntry.PARTNER_ROLE) {
                            case 'VE':
                                VEPartners.push(`SO_VE_PARTNER = ${partnerNumber}`);
                                break;

                            case 'AS':
                                ASPartners.push(`SO_AS_PARTNER = ${partnerNumber}`);
                                break;

                            case 'AM':
                                AMPartners.push(`SO_AM_PARTNER = ${partnerNumber}`);
                                break;
                            default:
                                break;
                        }
                    }

                    // Construct queries 
                    let VEQuery = VEPartners.length !== 0 ? cds.parse.expr(VEPartners.join(' or ')) : null;
                    let ASQuery = ASPartners.length !== 0 ? cds.parse.expr(ASPartners.join(' or ')) : null;
                    let AMQuery = AMPartners.length !== 0 ? cds.parse.expr(AMPartners.join(' or ')) : null;

                    // Add queries to request
                    let requestQuery  = req.query.SELECT.where || [];
                    VEQuery && requestQuery.length != 0 && requestQuery.push('and');
                    VEQuery && requestQuery.push(VEQuery);
                    ASQuery && requestQuery.length != 0 && requestQuery.push('and');
                    ASQuery && requestQuery.push(ASQuery);
                    AMQuery && requestQuery.length != 0 && requestQuery.push('and');
                    AMQuery && requestQuery.push(AMQuery);
                    req.query.SELECT.where = requestQuery
                }
            }
            // *-------------------------------------------------------------------*
            // End of Code OTC-24554

            if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count' && req.headers?.countcols) {
                try { 
                    const db = cds.transaction(req);
                    let query = cds.parse.cql(`SELECT count(*) from ( SELECT DISTINCT ${req.headers.countcols} from  srvOpenOrders_Results   )` )
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
                const queryString = JSON.stringify(req.query);
                const queryId = `${sessionID}Query`
                sessionCache.set(queryId, queryString);
            }
            if (Array.isArray(data)) {
                data.forEach((item) => {
                    item.id = uuid.v1()
                })
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
                if (query.SELECT.limit.rows.val) query.SELECT.limit.rows.val = req.query.SELECT.limit.rows?.val;
                //query.SELECT.distinct = true;
                // if any value is added in search field, that should be taken into account as well
                query.SELECT.search = req.query.SELECT.search;
                if (query.SELECT.limit.offset.val) query.SELECT.limit.offset.val = req.query.SELECT.limit.offset?.val || 0;
                if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count') {
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
                        let lt_count = await db.run(SELECT.from('srvOpenOrders_Results').columns(`countdistinct(${fields})`).where(query.SELECT.where))//distinct(true)

                        lt_result.push({ $count: lt_count.length })
                    } catch (error) {
                        req.error(status.EXPECTATION_FAILED, getBundle(req.user.locale).getText("VALUEHELP_NOT_EXECUTED"))
                    }

                }

            } else {
                const fields = req._query["search-focus"].split(',')
                // if there is no session id, execute the query directly
                if (req.query.SELECT.columns && req.query.SELECT.columns[0].as !== '$count') {
                    //req.query.SELECT.distinct = true;
                    lt_result = await db.run(req.query)
                    //await cds.run(req.query);
                } else {
                    try {
                        
                        let lt_count = await db.run(SELECT.from('srvOpenOrders_Results').columns(`countdistinct(${fields})`))
                        lt_result.push({ $count: lt_count.length })
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