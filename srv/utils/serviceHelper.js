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
        "BL_FKDAT_FIRST",
        "BL_FKDAT_LAST",
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
            return "AP";
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
            item.val = '0000-00-00';
        }

        // Check nested arrays (e.g., for complex filter structures)
        if (item.ref && Array.isArray(item.ref)) {
            replaceDateInArray(item.ref);
        }
    });
    return array;
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
    replaceDateInArray
}