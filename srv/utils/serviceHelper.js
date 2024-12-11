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
        "SO_F_LDDAT",
        "TM_AR_DATE",
        "SO_F_DGLTP",
        "PO_AEDAT_HEAD",
        "PO_AEDAT_ITEM",
        "SO_DUE_DATE"
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

module.exports =  {
    getDateProps,
    getPODateProps,
    getMandtFields,
    getMandtFieldsNames
}