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

module.exports =  {
    getDateProps,
    getPODateProps
}