using openOrdersSrv as service from './service-amoo.cds';
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
    isSubtotal                      @UI:{Hidden: true};
    SO_NPS_DESCRIPTION              @UI: {Hidden: true};
    
};