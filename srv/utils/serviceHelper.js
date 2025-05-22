const textBundle = require('./textBundle')
const getDateProps = () => {
    return [
        "SO_ERDAT_ORDER",
        "SO_ERDAT_ITEM",
        "SO_EDATU_REQUESTED",
        "SO_EDATU_CONFIRMED",
        "SO_LDDAT",
        "SO_PRSDT",
        "SO_F_TDDAT",
        "SO_F_MBDAT",
        "DL_LFDAT",
        "DL_HSDAT",
        "DL_VFDAT",
        "DL_WADAT",
        "DL_WADAT_IST",
        "DL_ERDAT",
        "DL_LDDAT",
        "TM_DPTBG",
        "TM_DATBG",
        "TM_DPTEN",
        "TM_DATEN",
        "TM_DALBG",
        "SO_F_LDDAT",
        "TM_AR_DATE",
        "SO_F_DGLTP",
        "PO_AEDAT_HEAD",
        "PO_AEDAT_ITEM",
        "SO_DUE_DATE",
        "BL_ERDAT_FIRST",
        "BL_ERDAT_LAST",
    ]
}

const getPODateProps = () => {
    return [
        "PO_AEDAT_HEAD",
        "PO_AEDAT_ITEM",
        "PO_DUE_DATE"
    ]
}

const getMandtFields = () => {
    return [
        "SO_MANDT",
        "DL_MANDT",
        "TM_MANDT",
        "BL_MANDT_INV_FIRST",
        "BL_MANDT_INV_LAST",
        "SO_FINAL_SO_MANDT",
        "SO_FIRST_SO_MANDT",
        "PO_MANDT"
    ]
}

const getMandtFieldsNames = (mandtFieldValue) => {
    switch(mandtFieldValue){
        case "100":
            return "Cobalt";
        case "200":
            return "Star";
        case "300":
            return "Spark";
        default:
            return "No System defined";
    }
}

const _addFilterToQuery = (query, fieldFiltered, filterValue) => {
    if (query.SELECT.where && query.SELECT.where.length > 0) {
        // check if NoAuth filter already exists, if so, modify the value instead of adding the filter again
        let FieldFilteredIndex = query.SELECT.where.findIndex((filterElement) => {
            if (filterElement.ref && filterElement.ref[0] === fieldFiltered) {
                return true;
            }
            return false;
        });
        if (FieldFilteredIndex < 0) {
            query.SELECT.where.push('and', { ref: [fieldFiltered] }, '=', { val: filterValue });
        } else {
            FieldFilteredIndex = FieldFilteredIndex + 2;
            query.SELECT.where[FieldFilteredIndex].val = filterValue;
        }
    } else {
        query.SELECT.where = [
            { ref: [fieldFiltered] }, '=', { val: filterValue }
        ];
    }
}

const replaceDateInArray = (array ) =>{
    array.forEach(item => {
        if (item && item.val === '1999-12-31') {
            item.val = '00000000'; // date in DB is stored without "-"
        }

        if (item && item.val === '1899-12-31') {
            item.val = ''; // alternatively, empty date values are stored as an empty string
        }

        // Check nested arrays (e.g., for complex filter structures)
        if (item.ref && Array.isArray(item.ref) || item.xpr && Array.isArray(item.xpr)) {
            replaceDateInArray(item.ref ?? item.xpr);
        }
    });
    return array;
}

const removeDuplicates = (fields, lt_result) => {
    if (fields) {
        lt_result = lt_result
            .filter(obj => fields.every(field => obj[field] !== null))
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
const getBundle = (locale) => {
    return textBundle.getTextBundle(locale)
}


const addOrRemoveNPSFilter = (req, npsTabSelected) => {
    const NPSMapping = {
        SO_NPS_10: "10",
        SO_NPS_20: "20",
        SO_NPS_30: "30",
        SO_NPS_40: "40",
        SO_NPS_50: "50",
        SO_NPS_60: "60",
        SO_NPS_70: "70",
        SO_NPS_80: "80",
        SO_NPS_90: "90",
        SO_NPS_95: "95",
        SO_NPS_99: "99",
        SO_NPS_00: "00"
    };
    let filterValue = NPSMapping[npsTabSelected];
    if(filterValue){ // other tabs apart from all issues
        _addFilterToQuery(req, "SO_NPS", filterValue)
    }else{ // all issues tab
        _removeFilterFromQuery(req, "SO_NPS")
    }
}

convertCQNtoCQL = (where, ignoreNPS) => {
    const requestQuery = [...where];
    if (ignoreNPS){
    // Helper function to process nested expressions
    for (let i = requestQuery.length - 1; i >= 0; i--) {
        if (requestQuery[i].ref && requestQuery[i].ref[0] === 'SO_NPS' || requestQuery[i].ref && requestQuery[i].ref[0] === 'SO_IGNORED') {
            requestQuery.splice(i, 4);
        }
    }
}
    // Start processing from the top-level requestQuery array
    let cql = processExpression(requestQuery);

    // Clean up unnecessary spaces and extra parentheses
    cql = cql.replace(/\s*\(\s*/g, ' (').replace(/\s*\)\s*/g, ') ')
        .replace(/\s+\(\s+/g, ' (')
        .replace(/\s+\)\s+/g, ')')
        .replace(/\s*\(\s*\)/g, '') // Remove empty parentheses if any
        .trim();
    cql = cql.replace(/= NULL/g, 'IS NULL');
    cql = cql.replace(/!IS NULL/g, 'IS NOT NULL');
    cql = cql.replace(/(?<!\bAND\b)$/i, ' AND');
    return cql;
}
 processExpression = (expr) => {
    let cqlParts = [];
    let i = 0;

    while (i < expr.length) {
        const item = expr[i];

        if (typeof item === 'object') {
            if (item.xpr) {
                // Recursively process nested expressions
                cqlParts.push(`(${processExpression(item.xpr)})`);
            } else if (item.ref) {
                // Handle reference
                cqlParts.push(item.ref.join('.'));
            } else if (item.func === 'date' ){
                cqlParts.push(typeof item.args[0].val === 'string' ? `''${item.args[0].val}''` : item.val); 
            }
            else if (item.val !== undefined) {
                // Handle value when is empty is selected --> define conditions
                if (item.val === null) {
                    cqlParts.push('NULL');
                } else {
                    cqlParts.push(typeof item.val === 'string' ? `''${item.val}''` : item.val);
                }
            } else if (item.func && item.func.toLowerCase() === 'contains') {
                // Handle 'contains' function --> define conditions
                const column = item.args[0].ref.join('.');
                const value = item.args[1].val;
                cqlParts.push(`${column} LIKE ''%'' || ''${value}'' || ''%'' ESCAPE ''^''`);
            }
            else if (item.func && item.func.toLowerCase() === 'startswith') {
                // Handle 'startswith' function --> define conditions
                const column = item.args[0].ref.join('.');
                const value = item.args[1].val;
                cqlParts.push(`${column} LIKE  ''${value}'' || ''%'' ESCAPE ''^''`);
            }
            else if (item.func && item.func.toLowerCase() === 'endswith') {
                // Handle 'endswith' function --> define conditions
                const column = item.args[0].ref.join('.');
                const value = item.args[1].val;
                cqlParts.push(`${column} LIKE ''%'' || ''${value}''  ESCAPE ''^''`);
            }
        } else if (typeof item === 'string') {
            if (item.toLowerCase() === 'or') {
                cqlParts.push(item.toUpperCase());
            } else if (item.toLowerCase() === 'and') {
                // Process AND conditions
                cqlParts.push('AND');
            } else {
                // Handle operators (=, >=, <=, !=)
                cqlParts.push(item);
            }
        }
        i++;
    }

    return cqlParts.join(' ').trim();
}
transformWhereClause = (whereClause) => {
    const dateProps = getDateProps()
    let transformed =  whereClause.replace(/(\b\w+\b)\s*(>=|<=|>|<|=)\s*''(\d{4})-(\d{2})-(\d{2})''/g, 
        (match, field, operator, year, month, day) => {
        if (dateProps.includes(field)) {
            return `${field} ${operator} '${year}${month}${day}'`;  // Convert date format 
        }
    });
    transformed = transformed.replace(/''([^']+)''/g, "'$1'");  // keep only single quotes
    transformed = transformed.replace(/\s*AND\s*$/, ''); // removing ending and
    return transformed;
    }

const _removeFilterFromQuery = (query, filterToRemove) => {
    if (query.SELECT.where && query.SELECT.where.length > 0) {
        // check if  filter already exists, if so, modify the value instead of adding the filter again
        let FieldFilteredIndex = query.SELECT.where.findIndex((filterElement) => {
            if (filterElement.ref && filterElement.ref[0] === filterToRemove) {
                return true;
            }
            return false;
        });
        if (FieldFilteredIndex >= 0) {
            // check if previous part is an AND, remove it if so
            let previousIndex = FieldFilteredIndex - 1;
            if(query.SELECT.where[previousIndex] === "and"){
                // remove 4 parts starting from previousIndex
                query.SELECT.where.splice(previousIndex, 4);
            }else{
                // remove 3 parts starting from FieldFilteredIndex
                query.SELECT.where.splice(FieldFilteredIndex, 4);
            }
            
        }
    }
}

module.exports =  {
    getDateProps,
    getPODateProps,
    getMandtFields,
    getMandtFieldsNames,
    addOrRemoveNPSFilter,
    replaceDateInArray,
    transformWhereClause,
    convertCQNtoCQL,
    removeDuplicates,
    getBundle
}