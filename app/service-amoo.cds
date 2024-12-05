using openOrdersSrv as service from '../srv/order-monitoring-amoo-services.cds';

annotate service.allIssues with @Consumption.dbHints: [
    'USE_HEX_PLAN',
    'HEX_INDEX_JOIN'
];

annotate service.valueHelps with @Consumption.dbHints: [
    'USE_HEX_PLAN',
    'HEX_INDEX_JOIN'
];

annotate service.orderCreation with @Consumption.dbHints: [
    'USE_HEX_PLAN',
    'HEX_INDEX_JOIN'
];

annotate service.valueHelps with {
    @Common.Text           : SO_NPS_DESCRIPTION
    @Common.TextArrangement: #TextOnly
    SO_NPS                         @title: '{i18n>SO_NPS}'              @sap.Label: '{i18n>SO_NPS}';
    SO_NPS_DESCRIPTION             @UI   : {Hidden: true};
    @Common.Text           : SO_ISSUE_DESCRIPTION
    @Common.TextArrangement: #TextOnly
    SO_ISSUE                       @title: '{i18n>SO_ISSUE}'            @sap.Label: '{i18n>SO_ISSUE}';
    SO_ISSUE_DESCRIPTION           @UI   : {Hidden: true};
    @Common.Text           : SO_DCP_ITEM_STATUS_DESCRIPTION
    @Common.TextArrangement: #TextOnly
    SO_DCP_ITEM_STATUS             @title: '{i18n>SO_DCP_ITEM_STATUS}'  @sap.Label: '{i18n>SO_DCP_ITEM_STATUS}';
    SO_DCP_ITEM_STATUS_DESCRIPTION @UI   : {Hidden: true};
}

annotate service.allIssues with @(UI: {SelectionFields: [
    SO_VBELN,
    SO_VKORG,
    SO_VTWEG,
    SO_EDATU_REQUESTED,
    SO_AG_PARTNER,
    SO_WE_PARTNER,
    SO_ISSUE
], });
// -------------------------------------------------
// ------------- ORDER CREATION ANNOTATIONS -------
// -------------------------------------------------

// ------------- ORDER CREATION LINE ITEM -------
annotate service.orderCreation with @UI.LineItem: {$value: [
    {Value: PO_EBELN},
    {Value: PO_EBELP},
    {Value: PO_AEDAT_HEAD},
    {Value: PO_AEDAT_ITEM}
]};

// ------------- ORDER CREATION SELECTION FIELDS -------
annotate service.orderCreation with @(UI: {SelectionFields: [
    PO_EBELN,
    PO_EBELP
],

});

// ------------- ORDER CREATION FIELD ANNOTATIONS -------
annotate service.orderCreation with {
    PO_MANDT                @title: '{i18n>PO_MANDT}'            @sap.Label: '{i18n>PO_MANDT}';
    PO_EBELN                @title: '{i18n>PO_EBELN}'            @sap.Label: '{i18n>PO_EBELN}'       @Common.IsDigitSequence : true;
    PO_EBELP                @title: '{i18n>PO_EBELP}'            @sap.Label: '{i18n>PO_EBELP}'       @Common.IsDigitSequence : true;
    PO_AEDAT_HEAD           @title: '{i18n>PO_AEDAT_HEAD}'       @sap.Label: '{i18n>PO_AEDAT_HEAD}'  @sap.filter.restriction : 'interval';
    PO_AEDAT_ITEM           @title: '{i18n>PO_AEDAT_ITEM}'       @sap.Label: '{i18n>PO_AEDAT_ITEM}'  @sap.filter.restriction : 'interval';
    PO_EKORG                @title: '{i18n>PO_EKORG}'            @sap.Label: '{i18n>PO_EKORG}';
    PO_EKOTX                @title: '{i18n>PO_EKOTX}'            @sap.Label: '{i18n>PO_EKOTX}';
    PO_EKGRP                @title: '{i18n>PO_EKGRP}'            @sap.Label: '{i18n>PO_EKGRP}';
    PO_EKNAM                @title: '{i18n>PO_EKNAM}'            @sap.Label: '{i18n>PO_EKNAM}';
    PO_EMATN                @title: '{i18n>PO_EMATN}'            @sap.Label: '{i18n>PO_EMATN}';
    PO_WERKS                @title: '{i18n>PO_WERKS_PO}'         @sap.Label: '{i18n>PO_WERKS_PO}';
    PO_MENGE                @title: '{i18n>PO_MENGE}'            @sap.Label: '{i18n>PO_MENGE}'       @Measures.Unit          : PO_MEINS;
    PO_MEINS                @title: '{i18n>PO_MEINS}'            @sap.Label: '{i18n>PO_MEINS}'       @Semantics.unitOfMeasure: 'unit-of-measure';
    PO_DUE_DATE             @title: '{i18n>PO_DUE_DATE}'         @sap.Label: '{i18n>PO_DUE_DATE}';
    PO_ERROR_TEXT           @title: '{i18n>PO_ERROR_TEXT}'       @sap.Label: '{i18n>PO_ERROR_TEXT}';
    PO_BIM_ERROR_ID         @title: '{i18n>PO_BIM_ERROR_ID}'     @sap.Label: '{i18n>PO_BIM_ERROR_ID}';

    // FIELDS WITH TEXT ARRANGEMENT
    @Common.Text           : PO_KUNNR_NAME
    @Common.TextArrangement: #TextLast
    PO_KUNNR                @title: '{i18n>PO_KUNNR}'            @sap.Label: '{i18n>PO_KUNNR}';
    @Common.TextFor
    PO_KUNNR_NAME;
    @Common.Text           : PO_PARTNER_9A_HEAD_NAME
    @Common.TextArrangement: #TextLast
    PO_PARTNER_9A_HEAD      @title: '{i18n>PO_PARTNER_9A_HEAD}'  @sap.Label: '{i18n>PO_PARTNER_9A_HEAD}';
    @Common.TextFor
    PO_PARTNER_9A_HEAD_NAME;
    @Common.Text           : PO_PARTNER_9O_HEAD_NAME
    @Common.TextArrangement: #TextLast
    PO_PARTNER_9O_HEAD      @title: '{i18n>PO_PARTNER_9O_HEAD}'  @sap.Label: '{i18n>PO_PARTNER_9O_HEAD}';
    @Common.TextFor
    PO_PARTNER_9O_HEAD_NAME;
    @Common.Text           : PO_BSART_BATXT
    @Common.TextArrangement: #TextLast
    PO_BSART                @title: '{i18n>PO_BSART}'            @sap.Label: '{i18n>PO_BSART}';
    @Common.TextFor
    PO_BSART_BATXT;

    // HIDDEN FIELDS
    PO_KUNNR_NAME           @UI   : {Hidden: true};
    PO_PARTNER_9A_HEAD_NAME @UI   : {Hidden: true};
    PO_PARTNER_9O_HEAD_NAME @UI   : {Hidden: true};
    PO_BSART_BATXT          @UI   : {Hidden: true};
    PO_BIM_ERROR_ID         @UI   : {Hidden: true};
}

// ------------- ORDER CREATION VALUE HELPS -------
// In Standby until we have a first implementation ready

// annotate service.orderCreation with {
//     PO_EBELN
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>PO_EBELN}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: PO_EBELN,
//             ValueListProperty: 'PO_EBELN'
//         }

//         ]
//     };

//     PO_EBELP
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>PO_EBELP}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: PO_EBELP,
//             ValueListProperty: 'PO_EBELP'
//         }

//         ]
//     };
// };

// -------------------------------------------------
// ------- END OF ORDER CREATION ANNOTATIONS -------
// -------------------------------------------------


// ------------- different tabs qualifier for lineitems-------
annotate service.allIssues with @UI.LineItem #allIssues: {
    ![@UI.Criticality]: 5,
    $value            : [
        {Value: SO_VBELN},
        {Value: SO_POSNR},
        {Value: SO_DUE_DATE},
        {Value: SO_NPS},
        {Value: SO_ISSUE},
        {Value: SO_ERDAT_ITEM},
        {Value: SO_WE_PARTNER_NAME},
        {Value: SO_LAND1},
        {Value: SO_LANDX},
        {Value: SO_ORT01},
        {Value: SO_WERKS},
        {Value: SO_MAKTX},
        {Value: SO_MATNR},
        {Value: SO_KDMAT},
        {Value: SO_EDATU_REQUESTED},
        {Value: SO_EDATU_CONFIRMED},
        {Value: SO_ZZDKPPRODB},
        {Value: DL_VBELN},
        {Value: DL_POSNR},
        {Value: TM_TKNUM},
        {Value: DL_WADAT_IST},
        {Value: TM_TDLNR},
        {Value: TM_TDLNR_NAME1},
        {Value: SO_VKORG},
        {Value: SO_VTWEG},
        {Value: SO_KWMENG},
        {Value: SO_KBMENG},
        {Value: SO_NETWR},
        {Value: SO_KBETR},
        {Value: SO_ROUTE},
        {Value: SO_F_LDDAT},
        {Value: TM_SHIPMENT_ETA_UPDATED},
        {Value: TM_DPTBG},
        {Value: TM_DPTEN},
        {Value: TM_DATBG},
        {Value: TM_DATEN},
        {Value: TM_SHIPMENT_CURRENT_STATUS},
    ]
};

annotate service.allIssues with @UI.LineItem #nps10: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_DUE_DATE},
    {Value: SO_NPS},
    {Value: SO_ISSUE},
    {Value: SO_AUART},
    // {Value: }, MDB block
    {Value: SO_VTWEG},
    {Value: SO_WERKS},
    {Value: SO_MAKTX},
    {Value: SO_ZZDKPPRODB},
    {Value: SO_KDMAT},
    {Value: SO_ERDAT_ORDER},
    {Value: SO_ERDAT_ITEM},
    {Value: SO_MATNR},
    {Value: SO_AG_PARTNER},
    {Value: SO_AG_PARTNER_NAME},
    {Value: SO_WE_PARTNER},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_LAND1},
    {Value: SO_LANDX},
    {Value: SO_ORT01},
    {Value: SO_VKORG},
    {Value: SO_VKORG_NAME1},
    {Value: SO_VKBUR},
    {Value: SO_VKBUR_BEZEI},
    {Value: SO_NETWR},
    {Value: SO_BSTKD},
    {Value: SO_EDATU_REQUESTED},
    {Value: SO_KWMENG},
]};

annotate service.allIssues with @UI.LineItem #nps20: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_DUE_DATE},
    {Value: SO_NPS},
    {Value: SO_ISSUE},
    // {Value: }, MDB block
    {Value: SO_WERKS},
    {Value: SO_MAKTX},
    {Value: SO_KDMAT},
    {Value: SO_ERDAT_ORDER},
    {Value: SO_ERDAT_ITEM},
    {Value: SO_AUART},
    {Value: SO_VTWEG},
    {Value: SO_MATNR},
    {Value: SO_AG_PARTNER},
    {Value: SO_AG_PARTNER_NAME},
    {Value: SO_WE_PARTNER},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_LAND1},
    {Value: SO_LANDX},
    {Value: SO_ORT01},
    {Value: SO_VKORG},
    {Value: SO_VKORG_NAME1},
    {Value: SO_EDATU_REQUESTED},
    {Value: SO_KWMENG},
    {Value: SO_VRKME},
    {Value: SO_BSTKD},
    {Value: SO_F_WERKS},
    {Value: SO_ZZ0S2REVG2},
    {Value: SO_ZZDKPPRODB},
    {Value: SO_ZTERM},
    {Value: SO_PRSDT},
    {Value: SO_KBETR},
    {Value: SO_WAERS},
    {Value: SO_SPART},
    {Value: SO_GUSCON_LEVEL},
    {Value: SO_I_VBELN},
    {Value: SO_LEVEL_TYPE},
    {Value: SO_N_VBELN},
    {Value: SO_F_VBELN},

]};

annotate service.allIssues with @UI.LineItem #nps30: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_DUE_DATE},
    {Value: SO_NPS},
    {Value: SO_ISSUE},
    // {Value: }, MDB block
    {Value: SO_MAKTX},
    {Value: SO_WERKS},
    {Value: SO_KDMAT},
    {Value: SO_ERDAT_ORDER},
    {Value: SO_ERDAT_ITEM},
    {Value: SO_AUART},
    {Value: SO_VTWEG},
    {Value: SO_MATNR},
    {Value: SO_AG_PARTNER},
    {Value: SO_AG_PARTNER_NAME},
    {Value: SO_WE_PARTNER},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_LAND1},
    {Value: SO_LANDX},
    {Value: SO_ORT01},
    {Value: SO_VKORG},
    {Value: SO_VKORG_NAME1},
    {Value: SO_EDATU_REQUESTED},
    {Value: SO_KWMENG},
    {Value: SO_VRKME},
    {Value: SO_BSTKD},
    {Value: SO_F_WERKS},
    {Value: SO_ZZ0S2REVG2},
    {Value: SO_ZZDKPPRODB},
    {Value: SO_KBETR},
    {Value: SO_WAERS},
    {Value: SO_NETWR},
    {Value: SO_ZTERM},
    {Value: SO_PRSDT},
    {Value: SO_SPART},
    {Value: SO_GUSCON_LEVEL},
    {Value: SO_I_VBELN},
    {Value: SO_LEVEL_TYPE},
    {Value: SO_N_VBELN},
    {Value: SO_F_VBELN},
]};

annotate service.allIssues with @UI.LineItem #nps40: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_DUE_DATE},
    {Value: SO_NPS},
    {Value: SO_ISSUE},
    {Value: SO_WERKS},
    {Value: SO_MAKTX},
    // {Value: }, mdb block
    {Value: SO_KDMAT},
    {Value: SO_ERDAT_ORDER},
    {Value: SO_ERDAT_ITEM},
    {Value: SO_AUART},
    {Value: SO_VTWEG},
    {Value: SO_MATNR},
    {Value: SO_AG_PARTNER},
    {Value: SO_AG_PARTNER_NAME},
    {Value: SO_WE_PARTNER},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_LAND1},
    {Value: SO_LANDX},
    {Value: SO_ORT01},
    {Value: SO_VKORG},
    {Value: SO_VKORG_NAME1},
    {Value: SO_EDATU_CONFIRMED},
    {Value: SO_EDATU_REQUESTED},
    {Value: SO_KWMENG},
    {Value: SO_VRKME},
    {Value: SO_BSTKD},
    {Value: SO_F_WERKS},
    {Value: SO_ZZ0S2REVG2},
    {Value: SO_ZZDKPPRODB},
    {Value: SO_KBETR},
    {Value: SO_WAERS},
    {Value: SO_SPART},
    {Value: SO_GUSCON_LEVEL},
    {Value: SO_I_VBELN},
    {Value: SO_LEVEL_TYPE},
    {Value: SO_N_VBELN},
    {Value: SO_F_VBELN},
    {Value: SO_ZTERM},
    {Value: SO_PRSDT},
]};

annotate service.allIssues with @UI.LineItem #nps50: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_DUE_DATE},
    {Value: SO_NPS},
    {Value: SO_ISSUE},
    {Value: SO_MAKTX},
    {Value: SO_MATNR},
    {Value: SO_WERKS},
    {Value: DL_CHARG},
    // {Value: },^MDB block
    {Value: DL_VBELN},
    {Value: DL_POSNR},
    {Value: DL_LFDAT},
    {Value: SO_EDATU_CONFIRMED},
    {Value: SO_KWMENG},
    {Value: SO_KBMENG},
    {Value: DL_PEND_DEL_QUAN},
    {Value: DL_WADAT},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_LAND1},
    {Value: SO_LANDX},
    {Value: SO_ORT01},
    {Value: SO_ROUTE},
    {Value: SO_INCO1},
    {Value: SO_KBETR},
    {Value: SO_NETWR},
    {Value: SO_ZZDKPPRODB},

]};

annotate service.allIssues with @UI.LineItem #nps60: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_DUE_DATE},
    {Value: SO_NPS},
    {Value: SO_ISSUE},
    {Value: SO_MAKTX},
    {Value: SO_MATNR},
    {Value: SO_WERKS},
    {Value: DL_CHARG},
    {Value: TM_TKNUM},
    {Value: TM_VSART},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_ORT01},
    {Value: SO_LAND1},
    {Value: DL_VBELN},
    {Value: SO_WE_PARTNER},
    {Value: DL_LFART},
    {Value: SO_KWMENG},
    {Value: SO_KBMENG},
    {Value: DL_PEND_DEL_QUAN},
    {Value: DL_LFDAT},
    {Value: DL_WADAT},
    {Value: SO_FAKSP},
    {Value: DL_ZZ0S2BLNR},
    {Value: TM_AR_DATE},

]};

annotate service.allIssues with @UI.LineItem #nps70: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_DUE_DATE},
    {Value: SO_NPS},
    {Value: SO_MAKTX},
    {Value: SO_MATNR},
    {Value: SO_WERKS},
    {Value: DL_CHARG},
    {Value: TM_TKNUM},
    {Value: TM_SHIPMENT_ETA_UPDATED},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_ORT01},
    {Value: SO_LAND1},
    {Value: SO_WE_PARTNER},
    {Value: SO_NETWR},
    {Value: DL_VBELN},
    {Value: SO_KWMENG},
    {Value: SO_KBMENG},
    {Value: DL_PEND_DEL_QUAN},
    {Value: DL_LFDAT},
    {Value: DL_WADAT},
    {Value: TM_DPTEN},
    {Value: TM_DPTBG},
    {Value: SO_EDATU_CONFIRMED},
    {Value: DL_TRAID},
    {Value: SO_F_LDDAT},
    {Value: TM_TDLNR_NAME1},
    {Value: SO_INCO1},
    {Value: SO_ROUTE},

]};

annotate service.allIssues with @UI.LineItem #nps80: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_DUE_DATE},
    {Value: SO_NPS},
    {Value: SO_MAKTX},
    {Value: SO_MATNR},
    {Value: SO_WERKS},
    {Value: DL_CHARG},
    {Value: TM_TKNUM},
    {Value: TM_SHIPMENT_ETA_UPDATED},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_ORT01},
    {Value: SO_LAND1},
    {Value: SO_WE_PARTNER},
    {Value: SO_F_VSBED_VTEXT},
    {Value: TM_TDLNR_NAME1},
    {Value: TM_EXTI1},
    {Value: DL_TRAID},
    {Value: SO_ROUTE},
    {Value: DL_VBELN},
    {Value: DL_WADAT},
    {Value: DL_WADAT_IST},
    {Value: SO_KBMENG},
    {Value: TM_DPTEN},
    {Value: TM_DPTBG},
    {Value: SO_EDATU_CONFIRMED},
    {Value: DL_PEND_DEL_QUAN},
    {Value: SO_F_LDDAT},
    {Value: SO_NETWR},
    {Value: SO_ZZDKPPRODB},
    {Value: SO_INCO1},

]};

annotate service.allIssues with @UI.LineItem #nps90: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_MAKTX},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_ORT01},
    {Value: SO_LAND1},
    {Value: DL_VBELN},
    {Value: SO_ZZDKPPRODB},
    {Value: DL_POSNR},
    {Value: TM_SHIPMENT_ETA_UPDATED},
    {Value: TM_SHIPMENT_CURRENT_STATUS},
    {Value: TM_SHIPMENT_ALERT},
    {Value: TM_TKNUM},
    {Value: TM_DPTBG},
    {Value: TM_DPTEN},
    {Value: TM_DATBG},
    {Value: TM_DATEN},
    {Value: DL_LFDAT},
    {Value: SO_EDATU_CONFIRMED},
    {Value: TM_TDLNR_NAME1},
    {Value: TM_EXTI1},
    {Value: SO_INCO1},
    {Value: SO_ROUTE},
    {Value: DL_WADAT_IST},
    {Value: SO_DUE_DATE},
    {Value: SO_NPS},

]};

annotate service.allIssues with @UI.LineItem #nps95: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_MAKTX},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_ORT01},
    {Value: SO_LAND1},
    {Value: DL_VBELN},
    {Value: DL_POSNR},
    {Value: TM_SHIPMENT_CURRENT_STATUS},
    {Value: TM_SHIPMENT_ALERT},
    {Value: SO_ZZDKPPRODB},
    {Value: SO_EDATU_CONFIRMED},
    {Value: DL_LFDAT},
    {Value: TM_DPTEN},
    {Value: TM_DATEN},
    {Value: TM_TKNUM},
    {Value: TM_TDLNR_NAME1},
    {Value: SO_ROUTE},

]};

annotate service.allIssues with @UI.LineItem #nps99: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_DUE_DATE},
    {Value: SO_NPS},
    {Value: SO_ISSUE},
    {Value: DL_VBELN},
    {Value: DL_POSNR},
    {Value: SO_ISSUE_LOCATION},
    {Value: SO_ISSUE_LOCATION_ITEM},
    {Value: SO_FAKSP},
    {Value: SO_FAKSP_VTEXT},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_LAND1},
    {Value: SO_AG_PARTNER_NAME},
    {Value: DL_VGBEL},
    {Value: DL_VGPOS},
    {Value: SO_WERKS},
    {Value: SO_NETWR},
    {Value: SO_ZZDKPPRODB},
    {Value: SO_MAKTX},
    {Value: SO_ERDAT_ITEM},

]};

annotate service.allIssues with @UI.LineItem #nps00: {$value: [
    {Value: SO_VBELN},
    {Value: SO_POSNR},
    {Value: SO_DUE_DATE},
    {Value: SO_NPS},
    {Value: SO_ISSUE},
    {Value: SO_ERDAT_ITEM},
    {Value: SO_WE_PARTNER_NAME},
    {Value: SO_LAND1},
    {Value: SO_LANDX},
    {Value: SO_ORT01},
    {Value: SO_WERKS},
    {Value: SO_MAKTX},
    {Value: SO_MATNR},
    {Value: SO_KDMAT},
    {Value: SO_EDATU_REQUESTED},
    {Value: SO_EDATU_CONFIRMED},
    {Value: SO_ZZDKPPRODB},
    {Value: DL_VBELN},
    {Value: DL_POSNR},
    {Value: TM_TKNUM},
    {Value: DL_WADAT_IST},
    {Value: TM_TDLNR},
    {Value: TM_TDLNR_NAME1},
    {Value: SO_VKORG_NAME1},
    {Value: SO_VTWEG},
    {Value: SO_KWMENG},
    {Value: SO_KBMENG},
    {Value: SO_NETWR},
    {Value: SO_KBETR},
    {Value: SO_ROUTE},
    {Value: SO_F_LDDAT},
    {Value: TM_SHIPMENT_ETA_UPDATED},
    {Value: TM_DPTBG},
    {Value: TM_DPTEN},
    {Value: TM_DATBG},
    {Value: TM_DATEN},
    {Value: TM_SHIPMENT_CURRENT_STATUS},

]};

// ------------- different tabs qualifier for lineitems-------
annotate service.baseEntity with {
    SO_VBELN                    @title: '{i18n>SO_VBELN}'                    @sap.Label: '{i18n>SO_VBELN}';
    SO_POSNR                    @title: '{i18n>SO_POSNR}'                    @sap.Label: '{i18n>SO_POSNR}'            @Common.IsDigitSequence: true;
    SO_ERDAT_ORDER              @title: '{i18n>SO_ERDAT_ORDER}'              @sap.Label: '{i18n>SO_ERDAT_ORDER}'      @sap.filter.restriction:'interval';
    SO_ERDAT_ITEM               @title: '{i18n>SO_ERDAT_ITEM}'               @sap.Label: '{i18n>SO_ERDAT_ITEM}'       @sap.filter.restriction:'interval';
    SO_AUART                    @title: '{i18n>SO_AUART}'                    @sap.Label: '{i18n>SO_AUART}';
    SO_WERKS                    @title: '{i18n>SO_WERKS}'                    @sap.Label: '{i18n>SO_WERKS}';
    SO_VTWEG                    @title: '{i18n>SO_VTWEG}'                    @sap.Label: '{i18n>SO_VTWEG}';
    SO_MATNR                    @title: '{i18n>SO_MATNR}'                    @sap.Label: '{i18n>SO_MATNR}'            @Common.IsDigitSequence: true;
    SO_MAKTX                    @title: '{i18n>SO_MAKTX}'                    @sap.Label: '{i18n>SO_MAKTX}';
    SO_KDMAT                    @title: '{i18n>SO_KDMAT}'                    @sap.Label: '{i18n>SO_KDMAT}';
    SO_AG_PARTNER               @title: '{i18n>SO_AG_PARTNER}'               @sap.Label: '{i18n>SO_AG_PARTNER}'       @Common.IsDigitSequence: true;
    SO_AG_PARTNER_NAME          @title: '{i18n>SO_AG_PARTNER_NAME}'          @sap.Label: '{i18n>SO_AG_PARTNER_NAME}';
    SO_WE_PARTNER               @title: '{i18n>SO_WE_PARTNER}'               @sap.Label: '{i18n>SO_WE_PARTNER}'       @Common.IsDigitSequence: true;
    SO_WE_PARTNER_NAME          @title: '{i18n>SO_WE_PARTNER_NAME}'          @sap.Label: '{i18n>SO_WE_PARTNER_NAME}';
    SO_LAND1                    @title: '{i18n>SO_LAND1}'                    @sap.Label: '{i18n>SO_LAND1}';
    SO_LANDX                    @title: '{i18n>SO_LANDX}'                    @sap.Label: '{i18n>SO_LANDX}';
    SO_ORT01                    @title: '{i18n>SO_ORT01}'                    @sap.Label: '{i18n>SO_ORT01}';
    SO_VKORG                    @title: '{i18n>SO_VKORG}'                    @sap.Label: '{i18n>SO_VKORG}';
    SO_VKORG_NAME1              @title: '{i18n>SO_VKORG_NAME1}'              @sap.Label: '{i18n>SO_VKORG_NAME1}';
    SO_CO_PARTNER               @title: '{i18n>SO_CO_PARTNER}'               @sap.Label: '{i18n>SO_CO_PARTNER}'       @Common.IsDigitSequence: true;
    SO_CO_PARTNER_NAME          @title: '{i18n>SO_CO_PARTNER_NAME}'          @sap.Label: '{i18n>SO_CO_PARTNER_NAME}';
    SO_NY_PARTNER               @title: '{i18n>SO_NY_PARTNER}'               @sap.Label: '{i18n>SO_NY_PARTNER}'       @Common.IsDigitSequence: true;
    SO_NY_PARTNER_NAME          @title: '{i18n>SO_NY_PARTNER_NAME}'          @sap.Label: '{i18n>SO_NY_PARTNER_NAME}';
    SO_AS_PARTNER               @title: '{i18n>SO_AS_PARTNER}'               @sap.Label: '{i18n>SO_AS_PARTNER}'       @Common.IsDigitSequence: true;
    SO_AS_PARTNER_NAME          @title: '{i18n>SO_AS_PARTNER_NAME}'          @sap.Label: '{i18n>SO_AS_PARTNER_NAME}';
    SO_VE_PARTNER               @title: '{i18n>SO_VE_PARTNER}'               @sap.Label: '{i18n>SO_VE_PARTNER}'       @Common.IsDigitSequence: true;
    SO_VE_PARTNER_NAME          @title: '{i18n>SO_VE_PARTNER_NAME}'          @sap.Label: '{i18n>SO_VE_PARTNER_NAME}';
    SO_AM_PARTNER               @title: '{i18n>SO_AM_PARTNER}'               @sap.Label: '{i18n>SO_AM_PARTNER}' @Common.IsDigitSequence: true;
    SO_AM_PARTNER_NAME          @title: '{i18n>SO_AM_PARTNER_NAME}'          @sap.Label: '{i18n>SO_AM_PARTNER_NAME}'  ;
    SO_KNREF_HEAD               @title: '{i18n>SO_KNREF_HEAD}'               @sap.Label: '{i18n>SO_KNREF_HEAD}';
    SO_VBUND                    @title: '{i18n>SO_VBUND}'                    @sap.Label: '{i18n>SO_VBUND}';
    SO_EDATU_REQUESTED          @title: '{i18n>SO_EDATU_REQUESTED}'          @sap.Label: '{i18n>SO_EDATU_REQUESTED}'  @sap.filter.restriction:'interval';
    SO_KWMENG                   @title: '{i18n>SO_KWMENG}'                   @sap.Label: '{i18n>SO_KWMENG}';
    SO_VRKME                    @title: '{i18n>SO_VRKME}'                    @sap.Label: '{i18n>SO_VRKME}';
    SO_EDATU_CONFIRMED          @title: '{i18n>SO_EDATU_CONFIRMED}'          @sap.Label: '{i18n>SO_EDATU_CONFIRMED}'  @sap.filter.restriction:'interval';
    SO_KBMENG                   @title: '{i18n>SO_KBMENG}'                   @sap.Label: '{i18n>SO_KBMENG}';
    SO_UNCONFIRMED_QTY          @title: '{i18n>SO_UNCONFIRMED_QTY}'          @sap.Label: '{i18n>SO_UNCONFIRMED_QTY}';
    SO_REQ_TEXT                 @title: '{i18n>SO_REQ_TEXT}'                 @sap.Label: '{i18n>SO_REQ_TEXT}';
    SO_FAKSP                    @title: '{i18n>SO_FAKSP}'                    @sap.Label: '{i18n>SO_FAKSP}';
    SO_FAKSP_VTEXT              @title: '{i18n>SO_FAKSP_VTEXT}'              @sap.Label: '{i18n>SO_FAKSP_VTEXT}';
    SO_SUPPLY_SITUATION         @title: '{i18n>SO_SUPPLY_SITUATION}'         @sap.Label: '{i18n>SO_SUPPLY_SITUATION}';
    SO_SUPPLY_SITUATION_DESCR   @title: '{i18n>SO_SUPPLY_SITUATION_DESCR}'   @sap.Label: '{i18n>SO_SUPPLY_SITUATION_DESCR}';
    SO_KBETR                    @title: '{i18n>SO_KBETR}'                    @sap.Label: '{i18n>SO_KBETR}';
    SO_WAERS                    @title: '{i18n>SO_WAERS}'                    @sap.Label: '{i18n>SO_WAERS}';
    SO_KPEIN                    @title: '{i18n>SO_KPEIN}'                    @sap.Label: '{i18n>SO_KPEIN}';
    SO_KMEIN                    @title: '{i18n>SO_KMEIN}'                    @sap.Label: '{i18n>SO_KMEIN}';
    SO_NETWR                    @title: '{i18n>SO_NETWR}'                    @sap.Label: '{i18n>SO_NETWR}';
    SO_WAERK                    @title: '{i18n>SO_WAERK}'                    @sap.Label: '{i18n>SO_WAERK}';
    SO_HTEXT                    @title: '{i18n>SO_HTEXT}'                    @sap.Label: '{i18n>SO_HTEXT}';
    SO_PSTYV                    @title: '{i18n>SO_PSTYV}'                    @sap.Label: '{i18n>SO_PSTYV}';
    SO_PSTYV_VTEXT              @title: '{i18n>SO_PSTYV_VTEXT}'              @sap.Label: '{i18n>SO_PSTYV_VTEXT}';
    SO_DISPO                    @title: '{i18n>SO_DISPO}'                    @sap.Label: '{i18n>SO_DISPO}';
    SO_KOSCH                    @title: '{i18n>SO_KOSCH}'                    @sap.Label: '{i18n>SO_KOSCH}';
    SO_VKBUR                    @title: '{i18n>SO_VKBUR}'                    @sap.Label: '{i18n>SO_VKBUR}';
    SO_VKBUR_BEZEI              @title: '{i18n>SO_VKBUR_BEZEI}'              @sap.Label: '{i18n>SO_VKBUR_BEZEI}';
    SO_ABGRU                    @title: '{i18n>SO_ABGRU}'                    @sap.Label: '{i18n>SO_ABGRU}';
    SO_ABGRU_BEZEI              @title: '{i18n>SO_ABGRU_BEZEI}'              @sap.Label: '{i18n>SO_ABGRU_BEZEI}';
    SO_ABSTA                    @title: '{i18n>SO_ABSTA}'                    @sap.Label: '{i18n>SO_ABSTA}';
    SO_KNUMV                    @title: '{i18n>SO_KNUMV}'                    @sap.Label: '{i18n>SO_KNUMV}';
    SO_SPART                    @title: '{i18n>SO_SPART}'                    @sap.Label: '{i18n>SO_SPART}';
    SO_INCO1                    @title: '{i18n>SO_INCO1}'                    @sap.Label: '{i18n>SO_INCO1}';
    SO_INCO2                    @title: '{i18n>SO_INCO2}'                    @sap.Label: '{i18n>SO_INCO2}';
    SO_ZTERM                    @title: '{i18n>SO_ZTERM}'                    @sap.Label: '{i18n>SO_ZTERM}';
    SO_PRSDT                    @title: '{i18n>SO_PRSDT}'                    @sap.Label: '{i18n>SO_PRSDT}';
    SO_ZZ0S2REVG2               @title: '{i18n>SO_ZZ0S2REVG2}'               @sap.Label: '{i18n>SO_ZZ0S2REVG2}';
    SO_ZZDKPPRODB               @title: '{i18n>SO_ZZDKPPRODB}'               @sap.Label: '{i18n>SO_ZZDKPPRODB}';
    SO_BSARK                    @title: '{i18n>SO_BSARK}'                    @sap.Label: '{i18n>SO_BSARK}';
    SO_BSARK_VTEXT              @title: '{i18n>SO_BSARK_VTEXT}'              @sap.Label: '{i18n>SO_BSARK_VTEXT}';
    SO_BASF_LOFCR               @title: '{i18n>SO_BASF_LOFCR}'               @sap.Label: '{i18n>SO_BASF_LOFCR}'     ; 
    SO_GUSCON_LEVEL             @title: '{i18n>SO_GUSCON_LEVEL}'               @sap.Label: '{i18n>SO_GUSCON_LEVEL}'     ;
    SO_I_VBELN                  @title: '{i18n>SO_I_VBELN}'                  @sap.Label: '{i18n>SO_I_VBELN}';
    SO_LEVEL_TYPE               @title: '{i18n>SO_LEVEL_TYPE}'               @sap.Label: '{i18n>SO_LEVEL_TYPE}';
    SO_N_VBELN                  @title: '{i18n>SO_N_VBELN}'                  @sap.Label: '{i18n>SO_N_VBELN}';
    SO_F_VBELN                  @title: '{i18n>SO_F_VBELN}'                  @sap.Label: '{i18n>SO_F_VBELN}';
    SO_F_POSNR                  @title: '{i18n>SO_F_POSNR}'                  @sap.Label: '{i18n>SO_F_POSNR}';
    SO_VBTYP                    @title: '{i18n>SO_VBTYP}'                    @sap.Label: '{i18n>SO_VBTYP}';
    SO_BSTKD                    @title: '{i18n>SO_BSTKD}'                    @sap.Label: '{i18n>SO_BSTKD}';
    SO_TRAGR                    @title: '{i18n>SO_TRAGR}'                    @sap.Label: '{i18n>SO_TRAGR}'            @Common.IsDigitSequence: true;
    SO_TRAGR_VTEXT              @title: '{i18n>SO_TRAGR_VTEXT}'              @sap.Label: '{i18n>SO_TRAGR_VTEXT}' ; 
    SO_VKGRP                    @title: '{i18n>SO_VKGRP}'                    @sap.Label: '{i18n>SO_VKGRP}';
    SO_VKGRP_BEZEI              @title: '{i18n>SO_VKGRP_BEZEI}'              @sap.Label: '{i18n>SO_VKGRP_BEZEI}';
    SO_ROUTE                    @title: '{i18n>SO_ROUTE}'                    @sap.Label: '{i18n>SO_ROUTE}';
    SO_F_WERKS                  @title: '{i18n>SO_F_WERKS}'                  @sap.Label: '{i18n>SO_F_WERKS}';
    SO_F_VKORG                  @title: '{i18n>SO_F_VKORG}'                  @sap.Label: '{i18n>SO_F_VKORG}';
    SO_F_VKORG_VTEXT            @title: '{i18n>SO_F_VKORG_VTEXT}'            @sap.Label: '{i18n>SO_F_VKORG_VTEXT}';
    SO_F_AS_PARTNER             @title: '{i18n>SO_F_AS_PARTNER}'             @sap.Label: '{i18n>SO_F_AS_PARTNER}'     @Common.IsDigitSequence: true;
    SO_F_AS_PARTNER_NAME        @title: '{i18n>SO_F_AS_PARTNER_NAME}'        @sap.Label: '{i18n>SO_F_AS_PARTNER_NAME}';
    SO_F_LDDAT                  @title: '{i18n>SO_F_LDDAT}'                  @sap.Label: '{i18n>SO_F_LDDAT}'          @sap.filter.restriction:'interval';
    SO_F_LGORT                  @title: '{i18n>SO_LGORT}'                    @sap.Label: '{i18n>SO_LGORT}';                 
    SO_F_TDDAT                  @title: '{i18n>SO_F_TDDAT}'                  @sap.Label: '{i18n>SO_F_TDDAT}'          @sap.filter.restriction:'interval';
    SO_F_ZZ0S2MATUG             @title: '{i18n>SO_F_ZZ0S2MATUG}'             @sap.Label: '{i18n>SO_F_ZZ0S2MATUG}';
    SO_F_AUFNR                  @title: '{i18n>SO_F_AUFNR}'                  @sap.Label: '{i18n>SO_F_AUFNR}';
    SO_F_DGLTP                  @title: '{i18n>SO_F_DGLTP}'                  @sap.Label: '{i18n>SO_F_DGLTP}'          @sap.filter.restriction:'interval';
    SO_F_AMEIN                  @title: '{i18n>SO_F_AMEIN}'                  @sap.Label: '{i18n>SO_F_AMEIN}';
    SO_F_PSMNG                  @title: '{i18n>SO_F_PSMNG}'                  @sap.Label: '{i18n>SO_F_PSMNG}';
    SO_F_VSBED                  @title: '{i18n>SO_F_VSBED}'                  @sap.Label: '{i18n>SO_F_VSBED}';
    SO_F_VSBED_VTEXT            @title: '{i18n>SO_F_VSBED_VTEXT}'            @sap.Label: '{i18n>SO_F_VSBED_VTEXT}';
    LAST_NOTE                   @title: '{i18n>LAST_NOTE}'                   @sap.Label: '{i18n>LAST_NOTE}';
    DL_VBELN                    @title: '{i18n>DL_VBELN}'                    @sap.Label: '{i18n>DL_VBELN}';
    DL_POSNR                    @title: '{i18n>DL_POSNR}'                    @sap.Label: '{i18n>DL_POSNR}'            @Common.IsDigitSequence: true;
    DL_CHARG                    @title: '{i18n>DL_CHARG}'                    @sap.Label: '{i18n>DL_CHARG}';
    DL_LFDAT                    @title: '{i18n>DL_LFDAT}'                    @sap.Label: '{i18n>DL_LFDAT}'            @sap.filter.restriction:'interval';
    DL_HSDAT                    @title: '{i18n>DL_HSDAT}'                    @sap.Label: '{i18n>DL_HSDAT}'            @sap.filter.restriction:'interval';
    DL_VFDAT                    @title: '{i18n>DL_VFDAT}'                    @sap.Label: '{i18n>DL_VFDAT}'            @sap.filter.restriction:'interval';
    DL_LFIMG                    @title: '{i18n>DL_LFIMG}'                    @sap.Label: '{i18n>DL_LFIMG}';
    DL_VRKME                    @title: '{i18n>DL_VRKME}'                    @sap.Label: '{i18n>DL_VRKME}';
    DL_POSAR                    @title: '{i18n>DL_POSAR}'                    @sap.Label: '{i18n>DL_POSAR}';
    DL_VGBEL                    @title: '{i18n>DL_VGBEL}'                    @sap.Label: '{i18n>DL_VGBEL}';
    DL_VGPOS                    @title: '{i18n>DL_VGPOS}'                    @sap.Label: '{i18n>DL_VGPOS}'            @Common.IsDigitSequence: true;
    DL_LFART                    @title: '{i18n>DL_LFART}'                    @sap.Label: '{i18n>DL_LFART}';
    DL_LFART_VTEXT              @title: '{i18n>DL_LFART_VTEXT}'              @sap.Label: '{i18n>DL_LFART_VTEXT}';
    DL_TRAID                    @title: '{i18n>DL_TRAID}'                    @sap.Label: '{i18n>DL_TRAID}';
    DL_ZZ0S2BLNR                @title: '{i18n>DL_ZZ0S2BLNR}'                @sap.Label: '{i18n>DL_ZZ0S2BLNR}';      
    DL_PEND_DEL_QUAN            @title: '{i18n>DL_PEND_DEL_QUAN}'            @sap.Label: '{i18n>DL_PEND_DEL_QUAN}';
    DL_WADAT                    @title: '{i18n>DL_WADAT}'                    @sap.Label: '{i18n>DL_WADAT}'            @sap.filter.restriction:'interval';
    DL_WADAT_IST                @title: '{i18n>DL_WADAT_IST}'                @sap.Label: '{i18n>DL_WADAT_IST}'        @sap.filter.restriction:'interval';
    TM_TKNUM                    @title: '{i18n>TM_TKNUM}'                    @sap.Label: '{i18n>TM_TKNUM}';
    TM_VSART                    @title: '{i18n>TM_VSART}'                    @sap.Label: '{i18n>TM_VSART}';
    TM_VSART_BEZEI              @title: '{i18n>TM_VSART_BEZEI}'              @sap.Label: '{i18n>TM_VSART_BEZEI}';
    TM_EXTI1                    @title: '{i18n>TM_EXTI1}'                    @sap.Label: '{i18n>TM_EXTI1}';
    TM_DPTBG                    @title: '{i18n>TM_DPTBG}'                    @sap.Label: '{i18n>TM_DPTBG}'            @sap.filter.restriction:'interval';
    TM_DATBG                    @title: '{i18n>TM_DATBG}'                    @sap.Label: '{i18n>TM_DATBG}'            @sap.filter.restriction:'interval';
    TM_DPTEN                    @title: '{i18n>TM_DPTEN}'                    @sap.Label: '{i18n>TM_DPTEN}'            @sap.filter.restriction:'interval';
    TM_DATEN                    @title: '{i18n>TM_DATEN}'                    @sap.Label: '{i18n>TM_DATEN}'            @sap.filter.restriction:'interval';
    TM_AR_DATE                  @title: '{i18n>TM_AR_DATE}'                  @sap.Label: '{i18n>TM_AR_DATE}'          @sap.filter.restriction:'interval';
    TM_TDLNR                    @title: '{i18n>TM_TDLNR}'                    @sap.Label: '{i18n>TM_TDLNR}'            @Common.IsDigitSequence: true;
    TM_TDLNR_NAME1              @title: '{i18n>TM_TDLNR_NAME1}'              @sap.Label: '{i18n>TM_TDLNR_NAME1}';
    TM_TRACKING_ID_COMP         @title: '{i18n>TM_TRACKING_ID_COMP}'         @sap.Label: '{i18n>TM_TRACKING_ID_COMP}';
    TM_TRACKING_ID_ELEM         @title: '{i18n>TM_TRACKING_ID_ELEM}'         @sap.Label: '{i18n>TM_TRACKING_ID_ELEM}';
    TM_STTRG                    @title: '{i18n>TM_STTRG}'                    @sap.Label: '{i18n>TM_STTRG}';
    TM_STTRG_DDTEXT             @title: '{i18n>TM_STTRG_DDTEXT}'             @sap.Label: '{i18n>TM_STTRG_DDTEXT}';
    TM_SHIPMENT_ALERT           @title: '{i18n>TM_SHIPMENT_ALERT}'           @sap.Label: '{i18n>TM_SHIPMENT_ALERT}';
    TM_SHIPMENT_CURRENT_STATUS  @title: '{i18n>TM_SHIPMENT_CURRENT_STATUS}'  @sap.Label: '{i18n>TM_SHIPMENT_CURRENT_STATUS}';
    SO_NPS                      @title: '{i18n>SO_NPS}'                      @sap.Label: '{i18n>SO_NPS}';
    SO_NPS_DESCRIPTION          @title: '{i18n>SO_NPS}'                      @sap.Label: '{i18n>SO_NPS}';
    SO_ISSUE                    @title: '{i18n>SO_ISSUE}'                    @sap.Label: '{i18n>SO_ISSUE}';
    SO_ISSUE_DESCRIPTION        @title: '{i18n>SO_ISSUE}'                    @sap.Label: '{i18n>SO_ISSUE}';
    SO_DCP_ITEM_STATUS                      @title: '{i18n>SO_DCP_ITEM_STATUS}'                      @sap.Label: '{i18n>SO_DCP_ITEM_STATUS}';
    SO_DCP_ITEM_STATUS_DESCRIPTION          @title: '{i18n>SO_DCP_ITEM_STATUS}'                      @sap.Label: '{i18n>SO_DCP_ITEM_STATUS}';
    SO_DUE_DATE                 @title: '{i18n>SO_DUE_DATE}'                 @sap.Label: '{i18n>SO_DUE_DATE}'         @sap.filter.restriction:'interval';
    SO_ISSUE_LOCATION           @title: '{i18n>SO_ISSUE_LOCATION}'           @sap.Label: '{i18n>SO_ISSUE_LOCATION}';
    SO_ISSUE_LOCATION_ITEM      @title: '{i18n>SO_ISSUE_LOCATION_ITEM}'      @sap.Label: '{i18n>SO_ISSUE_LOCATION_ITEM}';
    criticalityDueDate          @title: '{i18n>dueDateCriticality}'          @sap.Label: '{i18n>dueDateCriticality}' ;
    TM_SHIPMENT_ETA_UPDATED     @title: '{i18n>TM_SHIPMENT_ETA_UPDATED}'     @sap.Label: '{i18n>TM_SHIPMENT_ETA_UPDATED}';
    BL_VBELN_INV_FIRST          @title: '{i18n>BL_VBELN_INV_FIRST}'          @sap.Label: '{i18n>BL_VBELN_INV_FIRST}' @Common.IsDigitSequence: true;
    BL_POSNR_INV_FIRST          @title: '{i18n>BL_POSNR_INV_FIRST}'          @sap.Label: '{i18n>BL_POSNR_INV_FIRST}' @Common.IsDigitSequence: true;
    BL_FKIMG_FIRST              @title: '{i18n>BL_FKIMG_FIRST}'              @sap.Label: '{i18n>BL_FKIMG_FIRST}';
    BL_VRKME_FIRST              @title: '{i18n>BL_VRKME_FIRST}'              @sap.Label: '{i18n>BL_VRKME_LAST}';
    BL_FKART_FIRST              @title: '{i18n>BL_FKART_FIRST}'              @sap.Label: '{i18n>BL_FKART_FIRST}';
    BL_VBELN_INV_LAST           @title: '{i18n>BL_VBELN_INV_LAST}'           @sap.Label: '{i18n>BL_VBELN_INV_LAST}'  @Common.IsDigitSequence: true;
    BL_POSNR_INV_LAST           @title: '{i18n>BL_POSNR_INV_LAST}'           @sap.Label: '{i18n>BL_POSNR_INV_LAST}'   @Common.IsDigitSequence: true;
    BL_FKIMG_LAST               @title: '{i18n>BL_FKIMG_LAST}'               @sap.Label: '{i18n>BL_FKIMG_LAST}';
    BL_FKART_LAST               @title: '{i18n>BL_FKART_LAST}'               @sap.Label: '{i18n>BL_FKART_LAST}';
    BL_VRKME_LAST               @title: '{i18n>BL_VRKME_LAST}'               @sap.Label: '{i18n>BL_POSNR_INV_FIRST}';
    BL_XBLNR                    @title: '{i18n>BL_XBLNR}'                    @sap.Label: '{i18n>BL_XBLNR}';
    SO_FOLLOWUP_NOTES_LANG      @title: '{i18n>SO_FOLLOWUP_NOTES_LANG}'      @sap.Label: '{i18n>SO_FOLLOWUP_NOTES_LANG}';
    SO_REASON_CODE_01_LANG      @title: '{i18n>SO_REASON_CODE_01_LANG}'      @sap.Label: '{i18n>SO_REASON_CODE_01_LANG}';
    SO_REASON_CODE_02_LANG      @title: '{i18n>SO_REASON_CODE_02_LANG}'      @sap.Label: '{i18n>SO_REASON_CODE_02_LANG}';
    SO_REASON_CODE_03_LANG      @title: '{i18n>SO_REASON_CODE_03_LANG}'      @sap.Label: '{i18n>SO_REASON_CODE_03_LANG}';
    SO_REASON_CODE_04_LANG      @title: '{i18n>SO_REASON_CODE_04_LANG}'      @sap.Label: '{i18n>SO_REASON_CODE_04_LANG}';
    SO_REASON_CODE_05_LANG      @title: '{i18n>SO_REASON_CODE_05_LANG}'      @sap.Label: '{i18n>SO_REASON_CODE_05_LANG}';
    SO_DEV_CONF_DATE            @title: '{i18n>SO_DEV_CONF_DATE}'            @sap.Label: '{i18n>SO_DEV_CONF_DATE}';
    SO_EMAIL                    @title: '{i18n>SO_EMAIL}'                    @sap.Label: '{i18n>SO_EMAIL}';
    SO_EMAIL_SEND_DATE_F        @title: '{i18n>SO_EMAIL_SEND_DATE_F}'        @sap.Label: '{i18n>SO_EMAIL_SEND_DATE_F}';
    SO_EMAIL_SENT_ON            @title: '{i18n>SO_EMAIL_SENT_ON}'            @sap.Label: '{i18n>SO_EMAIL_SENT_ON}';
    SO_MDB                      @title: '{i18n>SO_MDB}'                      @sap.Label: '{i18n>SO_MDB}';
    SO_MDB_TEXT                 @title: '{i18n>SO_MDB_TEXT}'                 @sap.Label: '{i18n>SO_MDB_TEXT}';
    DL_ERDAT                    @title: '{i18n>DL_ERDAT}'                    @sap.Label: '{i18n>DL_ERDAT}'            @sap.filter.restriction:'interval';
    DL_LDDAT                    @title: '{i18n>DL_LDDAT}'                    @sap.Label: '{i18n>DL_LDDAT}'            @sap.filter.restriction:'interval';
    SO_PERFK                    @title: '{i18n>SO_PERFK}'                    @sap.Label: '{i18n>SO_PERFK}';
    SO_PERFK_LTEXT_LANG         @title: '{i18n>SO_PERFK}'                    @sap.Label: '{i18n>SO_PERFK}';
    SO_F_MBDAT                  @title: '{i18n>SO_F_MBDAT}'                  @sap.Label: '{i18n>SO_F_MBDAT}'          @sap.filter.restriction:'interval';
    DL_POSNR_BATCH               @title: '{i18n>DL_POSNR_BATCH}'                  @sap.Label: '{i18n>DL_POSNR_BATCH}'      ;   
    DL_LFIMG_BATCH               @title: '{i18n>DL_LFIMG_BATCH}'                  @sap.Label: '{i18n>DL_LFIMG_BATCH}'       ;  
    SO_MANDT                        @title: '{i18n>SO_MANDT}'                    @sap.Label: '{i18n>SO_MANDT}';
    DL_MANDT                        @title: '{i18n>DL_MANDT}'                    @sap.Label: '{i18n>DL_MANDT}';
    TM_MANDT                        @title: '{i18n>TM_MANDT}'                    @sap.Label: '{i18n>TM_MANDT}';
    BL_MANDT_INV_FIRST              @title: '{i18n>BL_MANDT_INV_FIRST}'          @sap.Label: '{i18n>BL_MANDT_INV_FIRST}';
    BL_MANDT_INV_LAST               @title: '{i18n>BL_MANDT_INV_LAST}'           @sap.Label: '{i18n>BL_MANDT_INV_LAST}';
    SO_FIRST_SO_MANDT               @title: '{i18n>SO_FIRST_SO_MANDT}'           @sap.Label: '{i18n>SO_FIRST_SO_MANDT}';
    SO_FINAL_SO_MANDT               @title: '{i18n>SO_FINAL_SO_MANDT}'           @sap.Label: '{i18n>SO_FINAL_SO_MANDT}';
    PO_MANDT                 @title: '{i18n>PO_MANDT}'             @sap.Label: '{i18n>PO_MANDT}';
    PO_EBELN                        @title: '{i18n>PO_EBELN}'                    @sap.Label: '{i18n>PO_EBELN}'            @Common.IsDigitSequence: true;
    PO_EBELP                        @title: '{i18n>PO_EBELP}'                    @sap.Label: '{i18n>PO_EBELP}'            @Common.IsDigitSequence: true;
    PO_AEDAT_HEAD                   @title: '{i18n>PO_AEDAT_HEAD}'               @sap.Label: '{i18n>PO_AEDAT_HEAD}';
    PO_AEDAT_ITEM                   @title: '{i18n>PO_AEDAT_ITEM}'               @sap.Label: '{i18n>PO_AEDAT_ITEM}';
    PO_BSART                        @title: '{i18n>PO_BSART}'                    @sap.Label: '{i18n>PO_BSART}';
    PO_BSART_BATXT                  @title: '{i18n>PO_BSART_BATXT}'              @sap.Label: '{i18n>PO_BSART_BATXT}';
    PO_EKORG                        @title: '{i18n>PO_EKORG}'                    @sap.Label: '{i18n>PO_EKORG}';
    PO_EKOTX                        @title: '{i18n>PO_EKOTX}'                    @sap.Label: '{i18n>PO_EKOTX}';
    PO_EKGRP                        @title: '{i18n>PO_EKGRP}'                    @sap.Label: '{i18n>PO_EKGRP}';
    PO_EKNAM                        @title: '{i18n>PO_EKNAM}'                    @sap.Label: '{i18n>PO_EKNAM}';
    PO_EMATN                        @title: '{i18n>PO_EMATN}'                    @sap.Label: '{i18n>PO_EMATN}';
    PO_WERKS_PO                     @title: '{i18n>PO_WERKS_PO}'                 @sap.Label: '{i18n>PO_WERKS_PO}';
    PO_MENGE                        @title: '{i18n>PO_MENGE}'                    @sap.Label: '{i18n>PO_MENGE}';
    PO_MEINS                        @title: '{i18n>PO_MEINS}'                    @sap.Label: '{i18n>PO_MEINS}';
    PO_KUNNR                        @title: '{i18n>PO_KUNNR}'                    @sap.Label: '{i18n>PO_KUNNR}';
    PO_KUNNR_NAME                   @title: '{i18n>PO_KUNNR_NAME}'               @sap.Label: '{i18n>PO_KUNNR_NAME}';
    PO_PARTNER_9A_HEAD              @title: '{i18n>PO_PARTNER_9A_HEAD}'          @sap.Label: '{i18n>PO_PARTNER_9A_HEAD}';
    PO_PARTNER_9A_HEAD_NAME         @title: '{i18n>PO_PARTNER_9A_HEAD_NAME}'     @sap.Label: '{i18n>PO_PARTNER_9A_HEAD_NAME}';
    PO_PARTNER_9O_HEAD              @title: '{i18n>PO_PARTNER_9O_HEAD}'          @sap.Label: '{i18n>PO_PARTNER_9O_HEAD}';
    PO_PARTNER_9O_HEAD_NAME         @title: '{i18n>PO_PARTNER_9O_HEAD_NAME}'     @sap.Label: '{i18n>PO_PARTNER_9O_HEAD_NAME}';
    // SO_BSTNK         @title: '{i18n>SO_BSTNK}'     @sap.Label: '{i18n>SO_BSTNK}';

};

annotate service.allIssues with {
    SO_KWMENG          @Measures.Unit          : SO_VRKME;
    SO_VRKME           @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_KBMENG          @Measures.Unit          : SO_VRKME;
    SO_UNCONFIRMED_QTY @Measures.Unit          : SO_VRKME;
    SO_KBETR           @Measures.ISOCurrency   : SO_WAERS;
    SO_WAERS           @Semantics.currencyCode;
    SO_KPEIN           @Measures.Unit          : SO_KMEIN;
    SO_KMEIN           @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_NETWR           @Measures.ISOCurrency   : SO_WAERK;
    SO_WAERK           @Semantics.currencyCode;
    SO_F_PSMNG         @Measures.Unit          : SO_F_AMEIN;
    SO_F_AMEIN         @Semantics.unitOfMeasure: 'unit-of-measure';
    DL_LFIMG           @Measures.Unit          : DL_VRKME;
    DL_LFIMG_BATCH     @Measures.Unit          : DL_VRKME;
    DL_VRKME           @Semantics.unitOfMeasure: 'unit-of-measure';
    DL_PEND_DEL_QUAN   @Measures.Unit          : DL_VRKME;
    id                 @UI                     : {Hidden: true};
    SO_DOC_TYP         @UI                     : {Hidden: true};
    SO_IGNORED         @UI                     : {Hidden: true};     
    // SO_MANDT           @UI                     : {Hidden: true};     
    // DL_MANDT           @UI                     : {Hidden: true};
    // TM_MANDT            @UI                     : {Hidden: true};

    // BL_MANDT_INV_FIRST  @UI                     : {Hidden: true};
    // BL_MANDT_INV_LAST   @UI                     : {Hidden: true};           
    BL_FKART_FIRST      @UI                     : {Hidden: true};           
    BL_FKART_LAST       @UI                     : {Hidden: true};    
    BL_FKIMG_FIRST       @UI                     : {Hidden: true};    
    BL_FKIMG_LAST        @UI                     : {Hidden: true};    
    BL_FKIMG_FIRST    @Measures.Unit          : BL_VRKME_FIRST;                                       
    BL_FKIMG_LAST     @Measures.Unit          : BL_VRKME_LAST;                                       
    BL_VRKME_FIRST   @Semantics.unitOfMeasure: 'unit-of-measure';
    BL_VRKME_LAST     @Semantics.unitOfMeasure: 'unit-of-measure';
    PO_KUNNR_NAME                  @UI                     : {Hidden: true};
    PO_PARTNER_9A_HEAD_NAME        @UI                     : {Hidden: true};
    PO_PARTNER_9O_HEAD_NAME        @UI                     : {Hidden: true};
    PO_BSART_BATXT  @UI                     : {Hidden: true};
    PO_MENGE                       @Measures.Unit          : PO_MEINS;
    PO_MEINS                       @Semantics.unitOfMeasure: 'unit-of-measure';
    

};

annotate service.allIssues with {
    @Common.Text           : SO_DCP_ITEM_STATUS_DESCRIPTION
    @Common.TextArrangement: #TextFirst
    SO_DCP_ITEM_STATUS   @title: '{i18n>SO_DCP_ITEM_STATUS}'   @sap.Label: '{i18n>SO_DCP_ITEM_STATUS}';
    @Common.TextFor
    SO_DCP_ITEM_STATUS_DESCRIPTION;
    @Common.Text           : SO_NPS_DESCRIPTION
    @Common.TextArrangement: #TextFirst
    SO_NPS               @title: '{i18n>SO_NPS}'               @sap.Label: '{i18n>SO_NPS}';
    @Common.TextFor
    SO_NPS_DESCRIPTION;
    @Common.Text           : SO_ISSUE_DESCRIPTION
    @Common.TextArrangement: #TextFirst
    SO_ISSUE             @title: '{i18n>SO_ISSUE}'             @sap.Label: '{i18n>SO_ISSUE}';
    @Common.TextFor
    SO_ISSUE_DESCRIPTION;
    @Common.Text           : SO_LANDX
    @Common.TextArrangement: #TextFirst
    SO_LAND1             @title: '{i18n>SO_LAND1}'             @sap.Label: '{i18n>SO_LAND1}';
    @Common.TextFor
    SO_LANDX;
    @Common.Text           : SO_MAKTX
    @Common.TextArrangement: #TextFirst
    SO_MATNR             @title: '{i18n>SO_MAKTX}'             @sap.Label: '{i18n>SO_MATNR}';
    @Common.TextFor
    SO_MAKTX;
    @Common.Text           : SO_AG_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_AG_PARTNER        @title: '{i18n>SO_AG_PARTNER_NAME}'   @sap.Label: '{i18n>SO_AG_PARTNER}';
    @Common.TextFor
    SO_AG_PARTNER_NAME;
    @Common.Text           : SO_WE_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_WE_PARTNER        @title: '{i18n>SO_WE_PARTNER_NAME}'   @sap.Label: '{i18n>SO_WE_PARTNER}';
    @Common.TextFor
    SO_WE_PARTNER_NAME;
    @Common.Text           : SO_VKORG_NAME1
    @Common.TextArrangement: #TextFirst
    SO_VKORG             @title: '{i18n>SO_VKORG_NAME1}'       @sap.Label: '{i18n>SO_VKORG}';
    @Common.TextFor
    SO_VKORG_NAME1;
    @Common.Text           : SO_FAKSP_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_FAKSP             @title: '{i18n>SO_FAKSP}'             @sap.Label: '{i18n>SO_FAKSP}';
    @Common.TextFor
    SO_FAKSP_VTEXT;
    @Common.Text           : SO_SUPPLY_SITUATION_DESCR
    @Common.TextArrangement: #TextFirst
    SO_SUPPLY_SITUATION  @title: '{i18n>SO_SUPPLY_SITUATION}'  @sap.Label: '{i18n>SO_SUPPLY_SITUATION}';
    @Common.TextFor
    SO_SUPPLY_SITUATION_DESCR;
    @Common.Text           : SO_PSTYV_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_PSTYV             @title: '{i18n>SO_PSTYV}'             @sap.Label: '{i18n>SO_PSTYV}';
    @Common.TextFor
    SO_PSTYV_VTEXT;
    @Common.Text           : SO_VKBUR_BEZEI
    @Common.TextArrangement: #TextFirst
    SO_VKBUR             @title: '{i18n>SO_VKBUR}'             @sap.Label: '{i18n>SO_VKBUR}';
    @Common.TextFor
    SO_VKBUR_BEZEI;
    @Common.Text           : SO_ABGRU_BEZEI
    @Common.TextArrangement: #TextFirst
    SO_ABGRU             @title: '{i18n>SO_ABGRU}'             @sap.Label: '{i18n>SO_ABGRU}';
    @Common.TextFor
    SO_ABGRU_BEZEI;
    @Common.Text           : SO_CO_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_CO_PARTNER        @title: '{i18n>SO_CO_PARTNER}'        @sap.Label: '{i18n>SO_CO_PARTNER}';
    @Common.TextFor
    SO_CO_PARTNER_NAME;
    @Common.Text           : SO_NY_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_NY_PARTNER        @title: '{i18n>SO_NY_PARTNER}'        @sap.Label: '{i18n>SO_NY_PARTNER}';
    @Common.TextFor
    SO_NY_PARTNER_NAME;
    @Common.Text           : SO_AS_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_AS_PARTNER        @title: '{i18n>SO_AS_PARTNER}'        @sap.Label: '{i18n>SO_AS_PARTNER}';
    @Common.TextFor
    SO_AS_PARTNER_NAME;
    @Common.Text           : SO_VE_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_VE_PARTNER        @title: '{i18n>SO_VE_PARTNER}'        @sap.Label: '{i18n>SO_VE_PARTNER}';
    @Common.TextFor
    SO_VE_PARTNER_NAME;
    @Common.Text           : SO_AM_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_AM_PARTNER        @title: '{i18n>SO_AM_PARTNER}'        @sap.Label: '{i18n>SO_AM_PARTNER}';
    @Common.TextFor
    SO_AM_PARTNER_NAME;
    @Common.Text           : SO_BSARK_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_BSARK             @title: '{i18n>SO_BSARK}'             @sap.Label: '{i18n>SO_BSARK}';
    @Common.TextFor
    SO_BSARK_VTEXT;
    @Common.Text           : SO_TRAGR_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_TRAGR             @title: '{i18n>SO_TRAGR}'             @sap.Label: '{i18n>SO_TRAGR}';
    @Common.TextFor
    SO_TRAGR_VTEXT;
    @Common.Text           : SO_VKGRP_BEZEI
    @Common.TextArrangement: #TextFirst
    SO_VKGRP             @title: '{i18n>SO_VKGRP}'             @sap.Label: '{i18n>SO_VKGRP}';
    @Common.TextFor
    SO_VKGRP_BEZEI;
    @Common.Text           : SO_F_VSBED_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_F_VSBED           @title: '{i18n>SO_F_VSBED}'           @sap.Label: '{i18n>SO_TRAGR}';
    @Common.TextFor
    SO_F_VSBED_VTEXT;
    @Common.Text           : SO_F_VKORG_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_F_VKORG           @title: '{i18n>SO_F_VKORG}'           @sap.Label: '{i18n>SO_F_VKORG}';
    @Common.TextFor
    SO_F_VKORG_VTEXT;
    @Common.Text           : SO_F_AS_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_F_AS_PARTNER      @title: '{i18n>SO_F_AS_PARTNER}'      @sap.Label: '{i18n>SO_F_AS_PARTNER}';
    @Common.TextFor
    SO_F_AS_PARTNER_NAME;
    @Common.Text           : DL_LFART_VTEXT
    @Common.TextArrangement: #TextFirst
    DL_LFART             @title: '{i18n>DL_LFART}'             @sap.Label: '{i18n>DL_LFART}';
    @Common.TextFor
    DL_LFART_VTEXT;
    @Common.Text           : TM_VSART_BEZEI
    @Common.TextArrangement: #TextFirst
    TM_VSART             @title: '{i18n>TM_VSART}'             @sap.Label: '{i18n>TM_VSART}';
    @Common.TextFor
    TM_VSART_BEZEI;
    @Common.Text           : TM_TDLNR_NAME1
    @Common.TextArrangement: #TextFirst
    TM_TDLNR             @title: '{i18n>TM_TDLNR}'             @sap.Label: '{i18n>TM_TDLNR}';
    @Common.TextFor
    TM_TDLNR_NAME1;
    @Common.Text           : TM_STTRG_DDTEXT
    @Common.TextArrangement: #TextFirst
    TM_STTRG             @title: '{i18n>TM_STTRG}'             @sap.Label: '{i18n>TM_STTRG}';
    @Common.TextFor
    TM_STTRG_DDTEXT;
    @Common.Text           : SO_MDB_TEXT
    @Common.TextArrangement: #TextFirst
    SO_MDB               @title: '{i18n>SO_MDB}'               @sap.Label: '{i18n>SO_MDB}';
    @Common.TextFor
    SO_MDB_TEXT;
    @Common.Text           : SO_PERFK_LTEXT_LANG
    @Common.TextArrangement: #TextLast
    SO_PERFK             @title: '{i18n>SO_PERFK}'             @sap.Label: '{i18n>SO_PERFK}';
    @Common.TextFor
    SO_PERFK_LTEXT_LANG;
    @Common.Text           : PO_KUNNR_NAME
    @Common.TextArrangement: #TextLast
    PO_KUNNR                    @title: '{i18n>PO_KUNNR}'                    @sap.Label: '{i18n>PO_KUNNR}';
    @Common.TextFor
    PO_KUNNR_NAME;
    @Common.Text           : PO_PARTNER_9A_HEAD_NAME
    @Common.TextArrangement: #TextLast
    PO_PARTNER_9A_HEAD          @title: '{i18n>PO_PARTNER_9A_HEAD}'          @sap.Label: '{i18n>PO_PARTNER_9A_HEAD}';
    @Common.TextFor
    PO_PARTNER_9A_HEAD_NAME;
    @Common.Text           : PO_PARTNER_9O_HEAD_NAME
    @Common.TextArrangement: #TextLast
    PO_PARTNER_9O_HEAD          @title: '{i18n>PO_PARTNER_9O_HEAD}'          @sap.Label: '{i18n>PO_PARTNER_9O_HEAD}';
    @Common.TextFor
    PO_PARTNER_9O_HEAD_NAME;
    @Common.Text           : PO_BSART_BATXT
    @Common.TextArrangement: #TextLast
    PO_BSART                    @title: '{i18n>PO_BSART}'                    @sap.Label: '{i18n>PO_BSART}';
    @Common.TextFor
    PO_BSART_BATXT;
    // BL_VBELN_INV_FIRST          @title: '{i18n>BL_VBELN_INV_FIRST}'          @sap.Label: '{i18n>BL_VBELN_INV_FIRST}';
    // BL_VBELN_INV_LAST           @title: '{i18n>BL_VBELN_INV_LAST}'           @sap.Label: '{i18n>BL_VBELN_INV_LAST}';
    // BL_XBLNR                    @title: '{i18n>BL_XBLNR}'                    @sap.Label: '{i18n>BL_XBLNR}';
}

annotate service.allIssues with {
    criticalityDueDate             @UI: {Hidden: true};
    // SO_MANDT                  @UI                     : {Hidden: true};
    SO_CO_PARTNER_NAME             @UI: {Hidden: true};
    SO_NY_PARTNER_NAME             @UI: {Hidden: true};
    SO_AS_PARTNER_NAME             @UI: {Hidden: true};
    SO_VE_PARTNER_NAME             @UI: {Hidden: true};
    SO_AM_PARTNER_NAME             @UI: {Hidden: true};
    SO_AG_PARTNER_NAME             @UI: {Hidden: true};
    SO_WE_PARTNER_NAME             @UI: {Hidden: true};
    SO_MAKTX                       @UI: {Hidden: true};
    SO_LANDX                       @UI: {Hidden: true};
    SO_NPS_DESCRIPTION             @UI: {Hidden: true};
    SO_ISSUE_DESCRIPTION           @UI: {Hidden: true};
    SO_DCP_ITEM_STATUS_DESCRIPTION @UI: {Hidden: true};
    SO_SPART                       @UI: {Hidden: true};
    SO_ABGRU_BEZEI                 @UI: {Hidden: true};
    SO_ABSTA                       @UI: {Hidden: true};
    SO_KNUMV                       @UI: {Hidden: true};
    SO_VKORG_NAME1                 @UI: {Hidden: true};
    SO_FAKSP_VTEXT                 @UI: {Hidden: true};
    SO_SUPPLY_SITUATION_DESCR      @UI: {Hidden: true};
    SO_PSTYV_VTEXT                 @UI: {Hidden: true};
    SO_BSARK_VTEXT                 @UI: {Hidden: true};
    SO_VKBUR_BEZEI                 @UI: {Hidden: true};
    SO_F_POSNR                     @UI: {Hidden: true};
    SO_I_POSNR                     @UI: {Hidden: true};
    SO_VBTYP                       @UI: {Hidden: true};
    SO_TRAGR_VTEXT                 @UI: {Hidden: true};
    SO_VKGRP_BEZEI                 @UI: {Hidden: true};
    SO_F_VSBED_VTEXT               @UI: {Hidden: true};
    SO_KNREF_ITM                   @UI: {Hidden: true};
    SO_VRKME                       @UI: {Hidden: true};
    SO_WAERS                       @UI: {Hidden: true};
    SO_KPEIN                       @UI: {Hidden: true};
    SO_KMEIN                       @UI: {Hidden: true};
    SO_WAERK                       @UI: {Hidden: true};
    SO_F_VKORG_VTEXT               @UI: {Hidden: true};
    SO_F_AMEIN                     @UI: {Hidden: true};
    SO_F_AS_PARTNER_NAME           @UI: {Hidden: true};
    DL_LFART_VTEXT                 @UI: {Hidden: true};
    BL_VRKME_FIRST                 @UI: {Hidden: true};
    BL_VRKME_LAST                  @UI: {Hidden: true};
    // id                        @UI                     : {Hidden: true};
    // DL_MANDT                  @UI                     : {Hidden: true};
    // TM_MANDT                  @UI                     : {Hidden: true};
    // BL_MANDT_INV_FIRST     @UI                     : {Hidden: true};
    // BL_MANDT_INV_LAST      @UI                     : {Hidden: true};
    DL_HSDAT                       @UI: {Hidden: true};
    DL_VFDAT                       @UI: {Hidden: true};
    // Shipment Details Texts
    TM_VSART_BEZEI                 @UI: {Hidden: true};
    TM_TDLNR_NAME1                 @UI: {Hidden: true};
    TM_STTRG_DDTEXT                @UI: {Hidden: true};
    TM_TRACKING_ID_COMP            @UI: {Hidden: true};
    DL_VGBEL                       @UI: {Hidden: true};
    TM_TRACKING_ID_ELEM            @UI: {Hidden: true};
    DL_VGPOS                       @UI: {Hidden: true};
    DL_POSAR                       @UI: {Hidden: true};
    DL_VRKME                       @UI: {Hidden: true};
    SO_MDB_TEXT                    @UI: {Hidden: true};
    SO_PERFK_LTEXT_LANG            @UI: {Hidden: true};
}

// ------------------------------Value Helps All Issues----------------------------
annotate service.allIssues with {
    SO_VRKME
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VRKME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VRKME,
            ValueListProperty: 'SO_VRKME'
        }]
    }
}

annotate service.allIssues with {
    SO_KMEIN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KMEIN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_KMEIN,
            ValueListProperty: 'SO_KMEIN'
        }]
    }
}

annotate service.allIssues with {
    DL_VRKME
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_VRKME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_VRKME,
            ValueListProperty: 'DL_VRKME'
        }]
    }
}

annotate service.allIssues with {
    SO_WAERK
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_WAERK}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_WAERK,
            ValueListProperty: 'SO_WAERK'
        }]
    }
}

annotate service.allIssues with {
    SO_WAERS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_WAERS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_WAERS,
            ValueListProperty: 'SO_WAERS'
        }]
    }
}


annotate service.allIssues with {
    SO_VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VBELN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VBELN,
            ValueListProperty: 'SO_VBELN'
        }]
    }
}

annotate service.allIssues with {
    SO_POSNR
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_POSNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_POSNR,
            ValueListProperty: 'SO_POSNR'
        }]
    }
    @Common.IsDigitSequence: true
}

annotate service.allIssues with {
    SO_AUART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_AUART}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_AUART,
            ValueListProperty: 'SO_AUART'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_WERKS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_WERKS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_WERKS,
            ValueListProperty: 'SO_WERKS'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_VTWEG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VTWEG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VTWEG,
            ValueListProperty: 'SO_VTWEG'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_MATNR
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_MAKTX}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_MATNR,
                ValueListProperty: 'SO_MATNR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_MAKTX'
            }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    SO_KDMAT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KDMAT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_KDMAT,
            ValueListProperty: 'SO_KDMAT'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_AG_PARTNER
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_AG_PARTNER_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_AG_PARTNER,
                ValueListProperty: 'SO_AG_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_AG_PARTNER_NAME'
            }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    SO_WE_PARTNER
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_WE_PARTNER_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_WE_PARTNER,
                ValueListProperty: 'SO_WE_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_WE_PARTNER_NAME'
            }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    SO_LAND1
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_LAND1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_LAND1,
                ValueListProperty: 'SO_LAND1'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_LANDX'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_ORT01
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ORT01}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ORT01,
            ValueListProperty: 'SO_ORT01'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_VKORG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VKORG_NAME1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_VKORG,
                ValueListProperty: 'SO_VKORG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VKORG_NAME1'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_VBUND
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VBUND}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VBUND,
            ValueListProperty: 'SO_VBUND'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_KWMENG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KWMENG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_KWMENG,
                ValueListProperty: 'SO_KWMENG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VRKME'
            },
        ]
    }
};

annotate service.allIssues with {
    SO_KBMENG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KBMENG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_KBMENG,
                ValueListProperty: 'SO_KBMENG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VRKME'
            },
        ]
    }
};

annotate service.allIssues with {
    SO_UNCONFIRMED_QTY
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_UNCONFIRMED_QTY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_UNCONFIRMED_QTY,
                ValueListProperty: 'SO_UNCONFIRMED_QTY'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VRKME'
            },
        ]
    }
};

annotate service.allIssues with {
    SO_REQ_TEXT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REQ_TEXT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REQ_TEXT,
            ValueListProperty: 'SO_REQ_TEXT'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_FAKSP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_FAKSP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_FAKSP,
                ValueListProperty: 'SO_FAKSP'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_FAKSP_VTEXT'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_F_LGORT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_LGORT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_LGORT,
            ValueListProperty: 'SO_F_LGORT'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_SUPPLY_SITUATION
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_SUPPLY_SITUATION}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_SUPPLY_SITUATION,
                ValueListProperty: 'SO_SUPPLY_SITUATION'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_SUPPLY_SITUATION_DESCR'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_KBETR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KBETR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_KBETR,
                ValueListProperty: 'SO_KBETR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_WAERS'
            },
        ]
    }
};

annotate service.allIssues with {
    SO_KPEIN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KPEIN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_KPEIN,
                ValueListProperty: 'SO_KPEIN'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_KMEIN'
            }
        ]
    }
};

annotate service.allIssues with {
    SO_NETWR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_NETWR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_NETWR,
                ValueListProperty: 'SO_NETWR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_WAERK'
            }
        ]
    }
};

annotate service.allIssues with {
    SO_HTEXT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_HTEXT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_HTEXT,
            ValueListProperty: 'SO_HTEXT'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_PSTYV
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_PSTYV}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_PSTYV,
                ValueListProperty: 'SO_PSTYV'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_PSTYV_VTEXT'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_DISPO
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_DISPO}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_DISPO,
            ValueListProperty: 'SO_DISPO'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_KOSCH
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KOSCH}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_KOSCH,
            ValueListProperty: 'SO_KOSCH'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_VKBUR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VKBUR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_VKBUR,
                ValueListProperty: 'SO_VKBUR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VKBUR_BEZEI'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_CO_PARTNER
    @Common.IsDigitSequence: true
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_CO_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_CO_PARTNER,
                ValueListProperty: 'SO_CO_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_CO_PARTNER_NAME'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_NY_PARTNER
    @Common.IsDigitSequence: true
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_NY_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_NY_PARTNER,
                ValueListProperty: 'SO_NY_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_NY_PARTNER_NAME'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_AS_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_AS_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_AS_PARTNER,
                ValueListProperty: 'SO_AS_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_AS_PARTNER_NAME'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_VE_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VE_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_VE_PARTNER,
                ValueListProperty: 'SO_VE_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VE_PARTNER_NAME'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_AM_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_AM_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_AM_PARTNER,
                ValueListProperty: 'SO_AM_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_AM_PARTNER_NAME'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_INCO1
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_INCO1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_INCO1,
            ValueListProperty: 'SO_INCO1'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_INCO2
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_INCO2}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_INCO2,
            ValueListProperty: 'SO_INCO2'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_ZTERM
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ZTERM}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ZTERM,
            ValueListProperty: 'SO_ZTERM'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_ZZ0S2REVG2
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ZZ0S2REVG2}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ZZ0S2REVG2,
            ValueListProperty: 'SO_ZZ0S2REVG2'
        }

        ]
    }
};

// annotate service.allIssues with {
//     SO_BSTNK
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_BSTNK}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_BSTNK,
//             ValueListProperty: 'SO_BSTNK'
//         }

//         ]
//     }
// };

annotate service.allIssues with {
    SO_ZZDKPPRODB
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ZZDKPPRODB}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ZZDKPPRODB,
            ValueListProperty: 'SO_ZZDKPPRODB'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_BSARK
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_BSARK}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_BSARK,
                ValueListProperty: 'SO_BSARK'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_BSARK_VTEXT'
            }

        ]
    }
};


annotate service.allIssues with {
    DL_VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_VBELN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_VBELN,
            ValueListProperty: 'DL_VBELN'
        }

        ]
    }
};

annotate service.allIssues with {
    DL_POSNR
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_POSNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_POSNR,
            ValueListProperty: 'DL_POSNR'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    DL_CHARG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_CHARG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_CHARG,
            ValueListProperty: 'DL_CHARG'
        }

        ]
    }
};

annotate service.allIssues with {
    DL_LFIMG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_LFIMG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DL_LFIMG,
                ValueListProperty: 'DL_LFIMG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DL_VRKME'
            }
        ]
    }
};

annotate service.allIssues with {
    DL_POSAR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_POSAR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_POSAR,
            ValueListProperty: 'DL_POSAR'
        }

        ]
    }
};

annotate service.allIssues with {
    DL_VGBEL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_VGBEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_VGBEL,
            ValueListProperty: 'DL_VGBEL'
        }

        ]
    }
};

// annotate service.allIssues with {
//     DL_VGPOS
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>DL_VGPOS}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: DL_VGPOS,
//             ValueListProperty: 'DL_VGPOS'
//         }

//         ]
//     }
//     @Common.IsDigitSequence: true
// };

annotate service.allIssues with {
    DL_LFART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_LFART}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DL_LFART,
                ValueListProperty: 'DL_LFART'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DL_LFART_VTEXT'
            }

        ]
    }
};

annotate service.allIssues with {
    DL_TRAID
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_TRAID}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_TRAID,
            ValueListProperty: 'DL_TRAID'
        }

        ]
    }
};

annotate service.allIssues with {
    DL_ZZ0S2BLNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_ZZ0S2BLNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_ZZ0S2BLNR,
            ValueListProperty: 'DL_ZZ0S2BLNR'
        }

        ]
    }
};

annotate service.allIssues with {
    TM_TKNUM
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_TKNUM}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_TKNUM,
            ValueListProperty: 'TM_TKNUM'
        }

        ]
    }
};

annotate service.allIssues with {
    TM_VSART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_VSART}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: TM_VSART,
                ValueListProperty: 'TM_VSART'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'TM_VSART_BEZEI'
            }

        ]
    }
};

annotate service.allIssues with {
    TM_EXTI1
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_EXTI1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_EXTI1,
            ValueListProperty: 'TM_EXTI1'
        }

        ]
    }
};

annotate service.allIssues with {
    TM_TDLNR
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_TDLNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: TM_TDLNR,
                ValueListProperty: 'TM_TDLNR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'TM_TDLNR_NAME1'
            }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    TM_TRACKING_ID_COMP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_TRACKING_ID_COMP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_TRACKING_ID_COMP,
            ValueListProperty: 'TM_TRACKING_ID_COMP'
        }

        ]
    }
};

annotate service.allIssues with {
    TM_TRACKING_ID_ELEM
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_TRACKING_ID_ELEM}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_TRACKING_ID_ELEM,
            ValueListProperty: 'TM_TRACKING_ID_ELEM'
        }

        ]
    }
};

annotate service.allIssues with {
    DL_PEND_DEL_QUAN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_PEND_DEL_QUAN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DL_PEND_DEL_QUAN,
                ValueListProperty: 'DL_PEND_DEL_QUAN'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DL_VRKME'
            }
        ]
    }
};

annotate service.allIssues with {
    SO_BASF_LOFCR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_BASF_LOFCR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_BASF_LOFCR,
            ValueListProperty: 'SO_BASF_LOFCR'
        }

        ]
    }

};

annotate service.allIssues with {
    SO_GUSCON_LEVEL
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_GUSCON_LEVEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_GUSCON_LEVEL,
            ValueListProperty: 'SO_GUSCON_LEVEL'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    SO_I_VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_I_VBELN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_I_VBELN,
            ValueListProperty: 'SO_I_VBELN'
        }

        ]
    }
};

// annotate service.allIssues with {
//     SO_ISCOMPLETED
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_ISCOMPLETED}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_ISCOMPLETED,
//             ValueListProperty: 'SO_ISCOMPLETED'
//         }

//         ]
//     }
// };

annotate service.allIssues with {
    SO_LEVEL_TYPE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_LEVEL_TYPE}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_LEVEL_TYPE,
            ValueListProperty: 'SO_LEVEL_TYPE'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_N_VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_N_VBELN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_N_VBELN,
            ValueListProperty: 'SO_N_VBELN'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_F_VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_VBELN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_VBELN,
            ValueListProperty: 'SO_F_VBELN'
        }

        ]
    }
};

// annotate service.allIssues with {
//     SO_F_POSNR
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_F_POSNR}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_F_POSNR,
//             ValueListProperty: 'SO_F_POSNR'
//         }

//         ]
//     }
// };

annotate service.allIssues with {
    SO_VBTYP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VBTYP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VBTYP,
            ValueListProperty: 'SO_VBTYP'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_BSTKD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_BSTKD}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_BSTKD,
            ValueListProperty: 'SO_BSTKD'
        }

        ]
    }
};

annotate service.allIssues with {
    BL_VBELN_INV_FIRST
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_VBELN_INV_FIRST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_VBELN_INV_FIRST,
            ValueListProperty: 'BL_VBELN_INV_FIRST'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    BL_VBELN_INV_LAST
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_VBELN_INV_LAST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_VBELN_INV_LAST,
            ValueListProperty: 'BL_VBELN_INV_LAST'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    BL_XBLNR
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_XBLNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_XBLNR,
            ValueListProperty: 'BL_XBLNR'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    SO_TRAGR
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_TRAGR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_TRAGR,
                ValueListProperty: 'SO_TRAGR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_TRAGR_VTEXT'
            }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    SO_VKGRP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VKGRP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_VKGRP,
                ValueListProperty: 'SO_VKGRP'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VKGRP_BEZEI'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_ROUTE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ROUTE}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ROUTE,
            ValueListProperty: 'SO_ROUTE'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_F_ZZ0S2MATUG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_ZZ0S2MATUG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_ZZ0S2MATUG,
            ValueListProperty: 'SO_F_ZZ0S2MATUG'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_F_VSBED
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_VSBED}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_F_VSBED,
                ValueListProperty: 'SO_F_VSBED'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_F_VSBED_VTEXT'
            }

        ]
    }
};

annotate service.allIssues with {
    TM_SHIPMENT_CURRENT_STATUS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_SHIPMENT_CURRENT_STATUS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_SHIPMENT_CURRENT_STATUS,
            ValueListProperty: 'TM_SHIPMENT_CURRENT_STATUS'
        }

        ]
    }
};

annotate service.allIssues with {
    TM_SHIPMENT_ALERT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_SHIPMENT_ALERT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_SHIPMENT_ALERT,
            ValueListProperty: 'TM_SHIPMENT_ALERT'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_F_VKORG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_VKORG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_F_VKORG,
                ValueListProperty: 'SO_F_VKORG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_F_VKORG_VTEXT'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_F_WERKS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_WERKS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_WERKS,
            ValueListProperty: 'SO_F_WERKS'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_F_AUFNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_AUFNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_AUFNR,
            ValueListProperty: 'SO_F_AUFNR'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_F_AMEIN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_AMEIN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_AMEIN,
            ValueListProperty: 'SO_F_AMEIN'
        }]
    }
}


annotate service.allIssues with {
    SO_F_PSMNG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_PSMNG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_F_PSMNG,
                ValueListProperty: 'SO_F_PSMNG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_F_AMEIN'
            }
        ]
    }
};


annotate service.allIssues with {
    SO_F_AS_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_AS_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_F_AS_PARTNER,
                ValueListProperty: 'SO_F_AS_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_F_AS_PARTNER_NAME'
            }

        ]
    }
};

annotate service.allIssues with {
    TM_STTRG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_STTRG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: TM_STTRG,
                ValueListProperty: 'TM_STTRG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'TM_STTRG_DDTEXT'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_KNREF_HEAD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KNREF_HEAD}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_KNREF_HEAD,
            ValueListProperty: 'SO_KNREF_HEAD'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_NPS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_NPS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_NPS,
            ValueListProperty: 'SO_NPS'
        }]
    }
};

annotate service.allIssues with {
    SO_ISSUE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ISSUE}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ISSUE,
            ValueListProperty: 'SO_ISSUE'
        }]
    }
};

annotate service.allIssues with {
    SO_DCP_ITEM_STATUS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_DCP_ITEM_STATUS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_DCP_ITEM_STATUS,
            ValueListProperty: 'SO_DCP_ITEM_STATUS'
        }]
    }
};

annotate service.allIssues with {
    SO_ISSUE_LOCATION
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ISSUE_LOCATION}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ISSUE_LOCATION,
            ValueListProperty: 'SO_ISSUE_LOCATION'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_ISSUE_LOCATION_ITEM
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ISSUE_LOCATION_ITEM}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ISSUE_LOCATION_ITEM,
            ValueListProperty: 'SO_ISSUE_LOCATION_ITEM'
        }

        ]
    }
};

annotate service.allIssues with {
    TM_SHIPMENT_ETA_UPDATED
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_SHIPMENT_ETA_UPDATED}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_SHIPMENT_ETA_UPDATED,
            ValueListProperty: 'TM_SHIPMENT_ETA_UPDATED'
        }

        ]
    }
};

annotate service.allIssues with {
    BL_POSNR_INV_FIRST
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_POSNR_INV_FIRST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_POSNR_INV_FIRST,
            ValueListProperty: 'BL_POSNR_INV_FIRST'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    BL_POSNR_INV_LAST
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_POSNR_INV_LAST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_POSNR_INV_LAST,
            ValueListProperty: 'BL_POSNR_INV_LAST'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.allIssues with {
    BL_FKIMG_FIRST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_FKIMG_FIRST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: BL_FKIMG_FIRST,
                ValueListProperty: 'BL_FKIMG_FIRST'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'BL_VRKME_FIRST'
            }
        ]
    }
};

annotate service.allIssues with {
    BL_FKIMG_LAST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_FKIMG_LAST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: BL_FKIMG_LAST,
                ValueListProperty: 'BL_FKIMG_LAST'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'BL_VRKME_LAST'
            }
        ]
    }
};

annotate service.allIssues with {
    SO_FOLLOWUP_NOTES_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_FOLLOWUP_NOTES_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_FOLLOWUP_NOTES_LANG,
            ValueListProperty: 'SO_FOLLOWUP_NOTES_LANG'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_REASON_CODE_01_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REASON_CODE_01_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REASON_CODE_01_LANG,
            ValueListProperty: 'SO_REASON_CODE_01_LANG'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_REASON_CODE_02_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REASON_CODE_02_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REASON_CODE_02_LANG,
            ValueListProperty: 'SO_REASON_CODE_02_LANG'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_REASON_CODE_03_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REASON_CODE_03_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REASON_CODE_03_LANG,
            ValueListProperty: 'SO_REASON_CODE_03_LANG'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_REASON_CODE_04_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REASON_CODE_04_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REASON_CODE_04_LANG,
            ValueListProperty: 'SO_REASON_CODE_04_LANG'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_REASON_CODE_05_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REASON_CODE_05_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REASON_CODE_05_LANG,
            ValueListProperty: 'SO_REASON_CODE_05_LANG'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_DEV_CONF_DATE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_DEV_CONF_DATE}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_DEV_CONF_DATE,
            ValueListProperty: 'SO_DEV_CONF_DATE'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_EMAIL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_EMAIL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_EMAIL,
            ValueListProperty: 'SO_EMAIL'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_EMAIL_SEND_DATE_F
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_EMAIL_SEND_DATE_F}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_EMAIL_SEND_DATE_F,
            ValueListProperty: 'SO_EMAIL_SEND_DATE_F'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_MDB
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_MDB}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_MDB,
                ValueListProperty: 'SO_MDB'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_MDB_TEXT'
            }

        ]
    }
};

annotate service.allIssues with {
    SO_EMAIL_SENT_ON
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_EMAIL_SENT_ON}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_EMAIL_SENT_ON,
            ValueListProperty: 'SO_EMAIL_SENT_ON'
        }

        ]
    }
};

annotate service.allIssues with {
    SO_PERFK
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_PERFK}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_PERFK,
                ValueListProperty: 'SO_PERFK'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_PERFK_LTEXT_LANG'
            }

        ]
    }
};

annotate service.allIssues with {
    DL_POSNR_BATCH
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_POSNR_BATCH}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_POSNR_BATCH,
            ValueListProperty: 'DL_POSNR_BATCH'
        }

        ]
    }
};

annotate service.allIssues with {
    DL_LFIMG_BATCH
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_LFIMG_BATCH}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DL_LFIMG_BATCH,
                ValueListProperty: 'DL_LFIMG_BATCH'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DL_VRKME'
            }
        ]
    }
};
annotate service.allIssues with {
    SO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_MANDT,
            ValueListProperty: 'SO_MANDT'
        }]
    }
}

annotate service.allIssues with {
    DL_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_MANDT,
            ValueListProperty: 'DL_MANDT'
        }]
    }
}

annotate service.allIssues with {
    TM_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_MANDT,
            ValueListProperty: 'TM_MANDT'
        }]
    }
}

annotate service.allIssues with {
    BL_MANDT_INV_FIRST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_MANDT_INV_FIRST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_MANDT_INV_FIRST,
            ValueListProperty: 'BL_MANDT_INV_FIRST'
        }]
    }
}

annotate service.allIssues with {
    BL_MANDT_INV_LAST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_MANDT_INV_LAST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_MANDT_INV_LAST,
            ValueListProperty: 'BL_MANDT_INV_LAST'
        }]
    }
}

annotate service.allIssues with {
    SO_FIRST_SO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_FIRST_SO_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_FIRST_SO_MANDT,
            ValueListProperty: 'SO_FIRST_SO_MANDT'
        }]
    }
}

annotate service.allIssues with {
    SO_FINAL_SO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_FINAL_SO_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_FINAL_SO_MANDT,
            ValueListProperty: 'SO_FINAL_SO_MANDT'
        }]
    }
}

annotate service.allIssues with {
    PO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_MANDT,
            ValueListProperty: 'PO_MANDT'
        }]
    }
}

annotate service.allIssues with {
    PO_EBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EBELN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EBELN,
            ValueListProperty: 'PO_EBELN'
        }]
    }
}

annotate service.allIssues with {
    PO_EBELP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EBELP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EBELP,
            ValueListProperty: 'PO_EBELP'
        }]
    }
}

annotate service.allIssues with {
    PO_BSART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_BSART_BATXT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_BSART,
                ValueListProperty: 'PO_BSART'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'PO_BSART_BATXT'
            }

        ]
    }
};

annotate service.allIssues with {
    PO_EKORG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EKORG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EKORG,
            ValueListProperty: 'PO_EKORG'
        }]
    }
}

annotate service.allIssues with {
    PO_EKOTX
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EKOTX}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EKOTX,
            ValueListProperty: 'PO_EKOTX'
        }]
    }
}

annotate service.allIssues with {
    PO_EKGRP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EKGRP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EKGRP,
            ValueListProperty: 'PO_EKGRP'
        }]
    }
}

annotate service.allIssues with {
    PO_EMATN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EMATN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EMATN,
            ValueListProperty: 'PO_EMATN'
        }]
    }
}

annotate service.allIssues with {
    PO_EKNAM
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EKNAM}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EKNAM,
            ValueListProperty: 'PO_EKNAM'
        }]
    }
}

annotate service.allIssues with {
    PO_WERKS_PO
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_WERKS_PO}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_WERKS_PO,
            ValueListProperty: 'PO_WERKS_PO'
        }]
    }
}

annotate service.allIssues with {
    PO_KUNNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_KUNNR_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_KUNNR,
                ValueListProperty: 'PO_KUNNR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'PO_KUNNR_NAME'
            }

        ]
    }
};

annotate service.allIssues with {
    PO_PARTNER_9A_HEAD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_PARTNER_9A_HEAD_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_PARTNER_9A_HEAD,
                ValueListProperty: 'PO_PARTNER_9A_HEAD'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'PO_PARTNER_9A_HEAD_NAME'
            }

        ]
    }
};

annotate service.allIssues with {
    PO_PARTNER_9O_HEAD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_PARTNER_9O_HEAD_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_PARTNER_9O_HEAD,
                ValueListProperty: 'PO_PARTNER_9O_HEAD'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'PO_PARTNER_9O_HEAD_NAME'
            }

        ]
    }
};
// ------------------------------Value Helps All Issues----------------------------
