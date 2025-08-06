using openOrdersSrv as service from './service-amoo.cds';

// // ----------------- Analytical Table -----------------------
// // Generic Analytical Semantics
annotate service.OpenOrdersAnalytics with @(
    UI.PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem'],
            SortOrder     : [{
                $Type     : 'Common.SortOrderType',
                Property  : SO_VBELN,
                Descending: false
            }],
            GroupBy       : [SO_VBELN]
        }
    );
// // annotate service.OpenOrdersAnalytics with @(Aggregation.CustomAggregate #SO_KWMENG: 'Edm.Decimal',

// // ) {
// //     SO_KWMENG @Aggregation.default: #SUM;
// //     SO_KBMENG @Aggregation.default: #SUM;
// //     SO_NETWR  @Aggregation.default: #SUM;
// //     SO_KBETR  @Aggregation.default: #SUM;
// // };

// annotate service.OpenOrdersAnalytics with @Aggregation.ApplySupported: {
//     Transformations       : [
//         'aggregate',
//         'topcount',
//         'bottomcount',
//         'identity',
//         'concat',
//         'groupby',
//         'filter',
//         'top',
//         'skip',
//         'orderby',
//         'search'
//     ],
//     GroupableProperties   : [
//         'SO_VBELN',
//         'SO_POSNR',
//         'SO_ERDAT_ITEM',
//         'DL_WADAT_IST',
//         'SO_F_ZZ0S2MATUG',
//         'SO_FAKSP',
//         'BL_VBELN_INV_LAST',
//         'SO_ERDAT_ORDER',
//         'SO_BSTKD',
//         'DL_VBELN',
//         'DL_POSNR',
//         'BL_POSNR_INV_LAST',
//         'SO_F_VBELN',
//         'SO_INCO1',
//         'SO_INCO2',
//         'SO_ZTERM',
//         'SO_F_LDDAT',
//         'DL_LDDAT',
//         'SO_MATNR',
//         'SO_AUART',
//         'TM_STTRG',
//         'DL_WADAT',
//         'SO_WERKS',
//         'SO_ABGRU',
//         'SO_EDATU_REQUESTED',
//         'SO_WE_PARTNER',
//         'SO_F_VSBED',
//         'SO_AG_PARTNER',
//         'SO_F_TDDAT',
//         'TM_TKNUM',
//         'SO_VBTYP'
//     ],
//     AggregatableProperties: [
//         {Property: SO_KWMENG},
//         {Property: SO_KBMENG},
//         {Property: SO_NETWR},
//         {Property: SO_KBETR}
//     ]
// };

// // OData V2 additional semantics
// @sap.semantics: 'aggregate'
// annotate service.OpenOrdersAnalytics with {

//     SO_KWMENG          @sap.aggregation.role: 'measure'  @sap.unit: 'SO_VRKME';
//     SO_KBMENG          @sap.aggregation.role: 'measure'  @sap.unit: 'SO_VRKME';
//     SO_NETWR           @sap.aggregation.role: 'measure'  @sap.unit: 'SO_WAERK';
//     SO_KBETR           @sap.aggregation.role: 'measure'  @sap.unit: 'SO_WAERS';
//     SO_VBELN           @sap.aggregation.role: 'dimension';
//     // SO_POSNR           @sap.aggregation.role: 'dimension';
//     SO_ERDAT_ITEM      @sap.aggregation.role: 'dimension';
//     DL_WADAT_IST       @sap.aggregation.role: 'dimension';
//     SO_F_ZZ0S2MATUG    @sap.aggregation.role: 'dimension';
//     SO_FAKSP           @sap.aggregation.role: 'dimension';
//     BL_VBELN_INV_LAST  @sap.aggregation.role: 'dimension';
//     SO_ERDAT_ORDER     @sap.aggregation.role: 'dimension';
//     SO_BSTKD           @sap.aggregation.role: 'dimension';
//     DL_VBELN           @sap.aggregation.role: 'dimension';
//     DL_POSNR           @sap.aggregation.role: 'dimension';
//     BL_POSNR_INV_LAST  @sap.aggregation.role: 'dimension';
//     SO_F_VBELN         @sap.aggregation.role: 'dimension';
//     SO_INCO1           @sap.aggregation.role: 'dimension';
//     SO_INCO2           @sap.aggregation.role: 'dimension';
//     SO_ZTERM           @sap.aggregation.role: 'dimension';
//     SO_F_LDDAT         @sap.aggregation.role: 'dimension';
//     DL_LDDAT           @sap.aggregation.role: 'dimension';
//     SO_MATNR           @sap.aggregation.role: 'dimension';
//     SO_AUART           @sap.aggregation.role: 'dimension';
//     TM_STTRG           @sap.aggregation.role: 'dimension';
//     DL_WADAT           @sap.aggregation.role: 'dimension';
//     SO_WERKS           @sap.aggregation.role: 'dimension';
//     SO_ABGRU           @sap.aggregation.role: 'dimension';
//     SO_EDATU_REQUESTED @sap.aggregation.role: 'dimension';
//     SO_WE_PARTNER      @sap.aggregation.role: 'dimension';
//     SO_F_VSBED         @sap.aggregation.role: 'dimension';
//     SO_AG_PARTNER      @sap.aggregation.role: 'dimension';
//     SO_F_TDDAT         @sap.aggregation.role: 'dimension';
//     TM_TKNUM           @sap.aggregation.role: 'dimension';
//     SO_VBTYP           @sap.aggregation.role: 'dimension';

// };


annotate service.OpenOrdersAnalytics with @UI.LineItem: {
    ![@UI.Criticality]: 5,
    $value            : [
        {Value: SO_VBELN},
        {Value: SO_POSNR},
        {Value: SO_NPS},
        {Value: SO_ISSUE},
        {Value: SO_ERDAT_ITEM},
        {Value: DL_WADAT_IST},
        {Value: SO_F_ZZ0S2MATUG},
        {Value: SO_FAKSP},
        {Value: BL_VBELN_INV_LAST},
        {Value: SO_ERDAT_ORDER},
        {Value: SO_BSTKD},
        {Value: DL_VBELN},
        {Value: DL_POSNR},
        {Value: BL_POSNR_INV_LAST},
        {Value: SO_F_VBELN},
        {Value: SO_INCO1},
        {Value: SO_INCO2},
        {Value: SO_ZTERM},
        {Value: SO_F_LDDAT},
        {Value: DL_LDDAT},
        {Value: SO_MATNR},
        {Value: SO_MAKTX},
        {Value: SO_AUART},
        {Value: TM_STTRG},
        {Value: DL_WADAT},
        {Value: SO_WERKS},
        {Value: SO_ABGRU},
        {Value: SO_EDATU_REQUESTED},
        {Value: SO_WE_PARTNER},
        {Value: SO_F_VSBED},
        {Value: SO_AG_PARTNER},
        {Value: SO_F_TDDAT},
        {Value: TM_TKNUM},
        {Value: SO_VBTYP},
        {Value: SO_KWMENG},
    ]
};

annotate service.OpenOrdersAnalytics with {
    // SO_VBELN              @title: '{i18n>SO_VBELN}'            @sap.Label: '{i18n>SO_VBELN}';
    // SO_POSNR              @title: '{i18n>SO_POSNR}'            @sap.Label: '{i18n>SO_POSNR}'            @Common.IsDigitSequence: true;
    // SO_ERDAT_ORDER        @title: '{i18n>SO_ERDAT_ORDER}'      @sap.Label: '{i18n>SO_ERDAT_ORDER}'      @sap.filter.restriction: 'interval';
    // SO_ERDAT_ITEM         @title: '{i18n>SO_ERDAT_ITEM}'       @sap.Label: '{i18n>SO_ERDAT_ITEM}'       @sap.filter.restriction: 'interval';
    // SO_AUART              @title: '{i18n>SO_AUART}'            @sap.Label: '{i18n>SO_AUART}';
    // SO_WERKS              @title: '{i18n>SO_WERKS}'            @sap.Label: '{i18n>SO_WERKS}';
    // SO_MATNR              @title: '{i18n>SO_MATNR}'            @sap.Label: '{i18n>SO_MATNR}'            @Common.IsDigitSequence: true;
    // SO_MAKTX              @title: '{i18n>SO_MAKTX}'            @sap.Label: '{i18n>SO_MAKTX}';
    // SO_AG_PARTNER         @title: '{i18n>SO_AG_PARTNER}'       @sap.Label: '{i18n>SO_AG_PARTNER}'       @Common.IsDigitSequence: true;
    // SO_AG_PARTNER_NAME    @title: '{i18n>SO_AG_PARTNER_NAME}'  @sap.Label: '{i18n>SO_AG_PARTNER_NAME}';
    // SO_WE_PARTNER         @title: '{i18n>SO_WE_PARTNER}'       @sap.Label: '{i18n>SO_WE_PARTNER}'       @Common.IsDigitSequence: true;
    // SO_WE_PARTNER_NAME    @title: '{i18n>SO_WE_PARTNER_NAME}'  @sap.Label: '{i18n>SO_WE_PARTNER_NAME}';
    // SO_EDATU_REQUESTED    @title: '{i18n>SO_EDATU_REQUESTED}'  @sap.Label: '{i18n>SO_EDATU_REQUESTED}'  @sap.filter.restriction: 'interval';
    // SO_KWMENG             @title: '{i18n>SO_KWMENG}'           @sap.Label: '{i18n>SO_KWMENG}';
    // SO_VRKME              @title: '{i18n>SO_VRKME}'            @sap.Label: '{i18n>SO_VRKME}';
    // SO_KBMENG             @title: '{i18n>SO_KBMENG}'           @sap.Label: '{i18n>SO_KBMENG}';
    // SO_FAKSP              @title: '{i18n>SO_FAKSP}'            @sap.Label: '{i18n>SO_FAKSP}';
    // SO_FAKSP_VTEXT        @title: '{i18n>SO_FAKSP_VTEXT}'      @sap.Label: '{i18n>SO_FAKSP_VTEXT}';
    // SO_KBETR              @title: '{i18n>SO_KBETR}'            @sap.Label: '{i18n>SO_KBETR}';
    // SO_WAERS              @title: '{i18n>SO_WAERS}'            @sap.Label: '{i18n>SO_WAERS}';
    // SO_NETWR              @title: '{i18n>SO_NETWR}'            @sap.Label: '{i18n>SO_NETWR}';
    // SO_WAERK              @title: '{i18n>SO_WAERK}'            @sap.Label: '{i18n>SO_WAERK}';
    // SO_ABGRU              @title: '{i18n>SO_ABGRU}'            @sap.Label: '{i18n>SO_ABGRU}';
    // SO_ABGRU_BEZEI        @title: '{i18n>SO_ABGRU_BEZEI}'      @sap.Label: '{i18n>SO_ABGRU_BEZEI}';
    // SO_INCO1              @title: '{i18n>SO_INCO1}'            @sap.Label: '{i18n>SO_INCO1}';
    // SO_INCO2              @title: '{i18n>SO_INCO2}'            @sap.Label: '{i18n>SO_INCO2}';
    // SO_ZTERM              @title: '{i18n>SO_ZTERM}'            @sap.Label: '{i18n>SO_ZTERM}';
    // SO_VBTYP              @title: '{i18n>SO_VBTYP}'            @sap.Label: '{i18n>SO_VBTYP}';
    // SO_BSTKD              @title: '{i18n>SO_BSTKD}'            @sap.Label: '{i18n>SO_BSTKD}';
    // SO_F_LDDAT            @title: '{i18n>SO_F_LDDAT}'          @sap.Label: '{i18n>SO_F_LDDAT}'          @sap.filter.restriction: 'interval';
    // SO_F_TDDAT            @title: '{i18n>SO_F_TDDAT}'          @sap.Label: '{i18n>SO_F_TDDAT}'          @sap.filter.restriction: 'interval';
    // SO_F_ZZ0S2MATUG       @title: '{i18n>SO_F_ZZ0S2MATUG}'     @sap.Label: '{i18n>SO_F_ZZ0S2MATUG}';
    // SO_F_VSBED            @title: '{i18n>SO_F_VSBED}'          @sap.Label: '{i18n>SO_F_VSBED}';
    // SO_F_VSBED_VTEXT      @title: '{i18n>SO_F_VSBED_VTEXT}'    @sap.Label: '{i18n>SO_F_VSBED_VTEXT}';
    // DL_VBELN              @title: '{i18n>DL_VBELN}'            @sap.Label: '{i18n>DL_VBELN}';
    // DL_POSNR              @title: '{i18n>DL_POSNR}'            @sap.Label: '{i18n>DL_POSNR}'            @Common.IsDigitSequence: true;
    // DL_WADAT              @title: '{i18n>DL_WADAT}'            @sap.Label: '{i18n>DL_WADAT}'            @sap.filter.restriction: 'interval';
    // DL_WADAT_IST          @title: '{i18n>DL_WADAT_IST}'        @sap.Label: '{i18n>DL_WADAT_IST}'        @sap.filter.restriction: 'interval';
    // TM_TKNUM              @title: '{i18n>TM_TKNUM}'            @sap.Label: '{i18n>TM_TKNUM}';
    // TM_STTRG              @title: '{i18n>TM_STTRG}'            @sap.Label: '{i18n>TM_STTRG}';
    // TM_STTRG_DDTEXT       @title: '{i18n>TM_STTRG_DDTEXT}'     @sap.Label: '{i18n>TM_STTRG_DDTEXT}';
    // SO_NPS                @title: '{i18n>SO_NPS}'              @sap.Label: '{i18n>SO_NPS}';
    // SO_NPS_DESCRIPTION    @title: '{i18n>SO_NPS}'              @sap.Label: '{i18n>SO_NPS}';
    // SO_ISSUE              @title: '{i18n>SO_ISSUE}'            @sap.Label: '{i18n>SO_ISSUE}';
    // SO_ISSUE_DESCRIPTION  @title: '{i18n>SO_ISSUE}'            @sap.Label: '{i18n>SO_ISSUE}';
    // SO_MANDT              @title: '{i18n>SO_MANDT}'            @sap.Label: '{i18n>SO_MANDT}';
    // DL_MANDT              @title: '{i18n>DL_MANDT}'            @sap.Label: '{i18n>DL_MANDT}';
    // TM_MANDT              @title: '{i18n>TM_MANDT}'            @sap.Label: '{i18n>TM_MANDT}';
    // BL_MANDT_INV_LAST     @title: '{i18n>BL_MANDT_INV_LAST}'   @sap.Label: '{i18n>BL_MANDT_INV_LAST}';
    // SO_FINAL_SO_MANDT     @title: '{i18n>SO_FINAL_SO_MANDT}'   @sap.Label: '{i18n>SO_FINAL_SO_MANDT}';
    // DL_MANDT_TEXT                   @UI: {Hidden: true};
    // SO_MANDT_TEXT                   @UI: {Hidden: true};
    // SO_FINAL_SO_MANDT_TEXT          @UI: {Hidden: true};
    // BL_MANDT_INV_LAST_TEXT          @UI: {Hidden: true};
    // TM_MANDT_TEXT                   @UI: {Hidden: true};
    // id                              @UI: {Hidden: true};
    // SO_IGNORED                      @UI: {Hidden: true};
    // SO_AG_PARTNER_NAME              @UI: {Hidden: true};
    // SO_WE_PARTNER_NAME              @UI: {Hidden: true};
    // SO_NPS_DESCRIPTION              @UI: {Hidden: true};
    // SO_ISSUE_DESCRIPTION            @UI: {Hidden: true};
    // SO_ABGRU_BEZEI                  @UI: {Hidden: true};
    // SO_FAKSP_VTEXT                  @UI: {Hidden: true};
    // SO_VBTYP                        @UI: {Hidden: true};
    // SO_F_VSBED_VTEXT                @UI: {Hidden: true};
    // SO_VRKME                        @UI: {Hidden: true};
    // SO_WAERS                        @UI: {Hidden: true};
    // SO_WAERK                        @UI: {Hidden: true};
    // TM_STTRG_DDTEXT                 @UI: {Hidden: true};
    isSubtotal                      @UI:{Hidden: true};
    SO_NPS_DESCRIPTION              @UI: {Hidden: true};
    
};



// annotate service.OpenOrdersAnalytics with {
//     SO_F_ZZ0S2MATUG
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_F_ZZ0S2MATUG}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_F_ZZ0S2MATUG,
//             ValueListProperty: 'SO_F_ZZ0S2MATUG'
//         }

//         ]
//     }
// };


// annotate service.OpenOrdersAnalytics with {
//     SO_FAKSP
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_FAKSP}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_FAKSP,
//             ValueListProperty: 'SO_FAKSP'
//         },
//         {
//             $Type            : 'Common.ValueListParameterDisplayOnly',
//             ValueListProperty: 'SO_FAKSP_VTEXT'
//         }

//         ]
//     }
// };


// // annotate service.OpenOrdersAnalytics with {
// //     BL_VBELN_INV_LAST
// //     @Common.ValueList: {
// //         $Type                  : 'Common.ValueListType',
// //         Label                  : '{@i18n>BL_VBELN_INV_LAST}',
// //         CollectionPath         : 'valueHelps',
// //         DistinctValuesSupported: true,
// //         SearchSupported        : true,
// //         Parameters             : [{
// //             $Type            : 'Common.ValueListParameterInOut',
// //             LocalDataProperty: BL_VBELN_INV_LAST,
// //             ValueListProperty: 'BL_VBELN_INV_LAST'
// //         }

// //         ]
// //     }
// // };

// // annotate service.OpenOrdersAnalytics with {
// //     SO_F_VBELN
// //     @Common.ValueList: {
// //         $Type                  : 'Common.ValueListType',
// //         Label                  : '{@i18n>SO_F_VBELN}',
// //         CollectionPath         : 'valueHelps',
// //         DistinctValuesSupported: true,
// //         SearchSupported        : true,
// //         Parameters             : [{
// //             $Type            : 'Common.ValueListParameterInOut',
// //             LocalDataProperty: SO_F_VBELN,
// //             ValueListProperty: 'SO_F_VBELN'
// //         }

// //         ]
// //     }
// // };


// // annotate service.OpenOrdersAnalytics with {
// //     SO_INCO1
// //     @Common.ValueList: {
// //         $Type                  : 'Common.ValueListType',
// //         Label                  : '{@i18n>SO_INCO1}',
// //         CollectionPath         : 'valueHelps',
// //         DistinctValuesSupported: true,
// //         SearchSupported        : true,
// //         Parameters             : [{
// //             $Type            : 'Common.ValueListParameterInOut',
// //             LocalDataProperty: SO_INCO1,
// //             ValueListProperty: 'SO_INCO1'
// //         }

// //         ]
// //     }
// // };


// // annotate service.OpenOrdersAnalytics with {
// //     SO_INCO2
// //     @Common.ValueList: {
// //         $Type                  : 'Common.ValueListType',
// //         Label                  : '{@i18n>SO_INCO2}',
// //         CollectionPath         : 'valueHelps',
// //         DistinctValuesSupported: true,
// //         SearchSupported        : true,
// //         Parameters             : [{
// //             $Type            : 'Common.ValueListParameterInOut',
// //             LocalDataProperty: SO_INCO2,
// //             ValueListProperty: 'SO_INCO2'
// //         }

// //         ]
// //     }
// // };


// annotate service.OpenOrdersAnalytics with {
//     SO_ZTERM
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_ZTERM}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_ZTERM,
//             ValueListProperty: 'SO_ZTERM'
//         },
//         {
//             $Type            : 'Common.ValueListParameterDisplayOnly',
//             ValueListProperty: 'SO_ZTERM_VTEXT_LANG'
//         }

//         ]
//     }
// };


// annotate service.OpenOrdersAnalytics with {
//     SO_MATNR
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_MATNR}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_MATNR,
//             ValueListProperty: 'SO_MATNR'
//         }

//         ]
//     }
// };


// annotate service.OpenOrdersAnalytics with {
//     SO_AUART
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_AUART}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_AUART,
//             ValueListProperty: 'SO_AUART'
//         }

//         ]
//     }
// };


// annotate service.OpenOrdersAnalytics with {
//     TM_STTRG
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>TM_STTRG}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: TM_STTRG,
//             ValueListProperty: 'TM_STTRG'
//         }

//         ]
//     }
// };


// // annotate service.OpenOrdersAnalytics with {
// //     SO_WERKS
// //     @Common.ValueList: {
// //         $Type                  : 'Common.ValueListType',
// //         Label                  : '{@i18n>SO_WERKS}',
// //         CollectionPath         : 'valueHelps',
// //         DistinctValuesSupported: true,
// //         SearchSupported        : true,
// //         Parameters             : [{
// //             $Type            : 'Common.ValueListParameterInOut',
// //             LocalDataProperty: SO_WERKS,
// //             ValueListProperty: 'SO_WERKS'
// //         }

// //         ]
// //     }
// // };


// annotate service.OpenOrdersAnalytics with {
//     SO_ABGRU
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_ABGRU}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_ABGRU,
//             ValueListProperty: 'SO_ABGRU'
//         }

//         ]
//     }
// };


// annotate service.OpenOrdersAnalytics with {
//     SO_WE_PARTNER
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_WE_PARTNER}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_WE_PARTNER,
//             ValueListProperty: 'SO_WE_PARTNER'
//         }

//         ]
//     }
// };


// annotate service.OpenOrdersAnalytics with {
//     SO_F_VSBED
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_F_VSBED}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_F_VSBED,
//             ValueListProperty: 'SO_F_VSBED'
//         }

//         ]
//     }
// };

// annotate service.OpenOrdersAnalytics with {
//     SO_AG_PARTNER
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_AG_PARTNER}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_AG_PARTNER,
//             ValueListProperty: 'SO_AG_PARTNER'
//         }

//         ]
//     }
// };


// annotate service.OpenOrdersAnalytics with {
//     SO_VBTYP
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_VBTYP}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_VBTYP,
//             ValueListProperty: 'SO_VBTYP'
//         }

//         ]
//     }
// };
