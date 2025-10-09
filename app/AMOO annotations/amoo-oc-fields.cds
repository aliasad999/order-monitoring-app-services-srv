using openOrdersSrv as service from '../../srv/order-monitoring-amoo-services.cds';

// ------------- ORDER CREATION LINE ITEM -------
annotate service.orderCreation with @UI.LineItem: {$value: [
    {Value: PO_EBELN},
    {Value: PO_EBELP},
    {Value: PO_AEDAT_HEAD},
    {Value: PO_AEDAT_ITEM},
    {Value: PO_ISSUE},
    {Value: PO_NPS},
    {Value: PO_ERROR_TEXT},
    {Value: PO_DUE_DATE}
]};

// ------------- ORDER CREATION SELECTION FIELDS -------
annotate service.orderCreation with @(UI: {SelectionFields: [
    PO_EBELN,
    PO_EBELP,
    PO_AEDAT_HEAD,
    PO_AEDAT_ITEM,
    PO_ISSUE,
    PO_NPS,
    PO_ERROR_TEXT,
    PO_DUE_DATE
],

});

// ------------- ORDER CREATION FIELD ANNOTATIONS -------
annotate service.baseOrderCreation with {
    PO_EBELN            @title: '{i18n>PO_EBELN}'            @sap.Label: '{i18n>PO_EBELN}'            @Common.IsDigitSequence : true;
    PO_EBELP            @title: '{i18n>PO_EBELP}'            @sap.Label: '{i18n>PO_EBELP}'            @Common.IsDigitSequence : true;
    PO_AEDAT_HEAD       @title: '{i18n>PO_AEDAT_HEAD}'       @sap.Label: '{i18n>PO_AEDAT_HEAD}'       @sap.filter.restriction : 'interval';
    PO_AEDAT_ITEM       @title: '{i18n>PO_AEDAT_ITEM}'       @sap.Label: '{i18n>PO_AEDAT_ITEM}'       @sap.filter.restriction : 'interval';
    PO_EKORG            @title: '{i18n>PO_EKORG}'            @sap.Label: '{i18n>PO_EKORG}';
    PO_EKOTX            @title: '{i18n>PO_EKOTX}'            @sap.Label: '{i18n>PO_EKOTX}';
    PO_EKGRP            @title: '{i18n>PO_EKGRP}'            @sap.Label: '{i18n>PO_EKGRP}';
    PO_EKNAM            @title: '{i18n>PO_EKNAM}'            @sap.Label: '{i18n>PO_EKNAM}';
    PO_EMATN            @title: '{i18n>PO_EMATN}'            @sap.Label: '{i18n>PO_EMATN}'            @Common.IsDigitSequence : true;
    PO_WERKS            @title: '{i18n>PO_WERKS_PO}'         @sap.Label: '{i18n>PO_WERKS_PO}';
    PO_MENGE            @title: '{i18n>PO_MENGE}'            @sap.Label: '{i18n>PO_MENGE}'            @Measures.Unit          : PO_MEINS;
    PO_MEINS            @title: '{i18n>PO_MEINS}'            @sap.Label: '{i18n>PO_MEINS}'            @Semantics.unitOfMeasure: 'unit-of-measure';
    PO_DUE_DATE         @title: '{i18n>so_due_date}'         @sap.Label: '{i18n>so_due_date}';
    PO_ERROR_TEXT       @title: '{i18n>PO_ERROR_TEXT}'       @sap.Label: '{i18n>PO_ERROR_TEXT}';
    PO_KUNNR            @title: '{i18n>PO_KUNNR}'            @sap.Label: '{i18n>PO_KUNNR}'            @Common.IsDigitSequence : true;
    PO_KUNNR_NAME       @title: '{i18n>PO_KUNNR_NAME}'       @sap.Label: '{i18n>PO_KUNNR_NAME}';
    PO_PARTNER_9A_HEAD  @title: '{i18n>PO_PARTNER_9A_HEAD}'  @sap.Label: '{i18n>PO_PARTNER_9A_HEAD}'  @Common.IsDigitSequence : true;
    PO_PARTNER_9O_HEAD  @title: '{i18n>PO_PARTNER_9O_HEAD}'  @sap.Label: '{i18n>PO_PARTNER_9O_HEAD}'  @Common.IsDigitSequence : true;
    PO_BSART_BATXT      @title: '{i18n>PO_BSART}'            @sap.Label: '{i18n>PO_BSART}';
    PO_MANDT_TEXT       @title: '{i18n>PO_MANDT}'            @sap.Label: '{i18n>PO_MANDT}';

    @Common.Text           : PO_ISSUE_TEXT
    @Common.TextArrangement: #TextOnly
    PO_ISSUE            @title: '{i18n>SO_ISSUE}'            @sap.Label: '{i18n>SO_ISSUE}';
    @Common.TextFor
    PO_ISSUE_TEXT;

    @Common.Text           : PO_NPS_TEXT
    @Common.TextArrangement: #TextOnly
    PO_NPS              @title: '{i18n>SO_NPS}'              @sap.Label: '{i18n>SO_NPS}';
    @Common.TextFor
    PO_NPS_TEXT;
}

annotate service.orderCreation with {
    // FIELDS WITH TEXT ARRANGEMENT
    @Common.Text           : PO_KUNNR_NAME
    @Common.TextArrangement: #TextLast
    PO_KUNNR            @title: '{i18n>PO_KUNNR}'            @sap.Label: '{i18n>PO_KUNNR}';
    @Common.TextFor
    PO_KUNNR_NAME;

    PO_PARTNER_9A_HEAD  @title: '{i18n>PO_PARTNER_9A_HEAD}'  @sap.Label: '{i18n>PO_PARTNER_9A_HEAD}';
    PO_PARTNER_9O_HEAD  @title: '{i18n>PO_PARTNER_9O_HEAD}'  @sap.Label: '{i18n>PO_PARTNER_9O_HEAD}';

    @Common.Text           : PO_BSART_BATXT
    @Common.TextArrangement: #TextLast
    PO_BSART            @title: '{i18n>PO_BSART}'            @sap.Label: '{i18n>PO_BSART}';
    @Common.TextFor
    PO_BSART_BATXT;

    @Common.Text           : PO_MANDT_TEXT
    @Common.TextArrangement: #TextLast
    PO_MANDT            @title: '{i18n>PO_MANDT}'            @sap.Label: '{i18n>PO_MANDT}';
    @Common.TextFor
    PO_MANDT_TEXT;

    @Common.Text           : PO_EKOTX
    @Common.TextArrangement: #TextLast
    PO_EKORG            @title: '{i18n>PO_EKORG}'            @sap.Label: '{i18n>PO_EKORG}';
    @Common.TextFor
    PO_EKOTX;

    @Common.Text           : PO_EKNAM
    @Common.TextArrangement: #TextLast
    PO_EKGRP            @title: '{i18n>PO_EKGRP}'            @sap.Label: '{i18n>PO_EKGRP}';
    @Common.TextFor
    PO_EKNAM;

    // HIDDEN FIELDS
    PO_KUNNR_NAME       @UI: {Hidden: true};
    PO_BSART_BATXT      @UI: {Hidden: true};
    PO_BIM_ERROR_ID     @UI: {Hidden: true};
    PO_MEINS            @UI: {Hidden: true};
    Id                  @UI: {Hidden: true};
    PO_MANDT_TEXT       @UI: {Hidden: true};
    PO_EKNAM            @UI: {Hidden: true};
    PO_EKOTX            @UI: {Hidden: true};
    PO_ISSUE_TEXT       @UI: {Hidden: true};
    PO_NPS_TEXT         @UI: {Hidden: true};
}


annotate service.BIMGeneralErrors with @UI.LineItem: {$value: [
    {Value: BIM_ERROR_ID},
    {Value: PURCHASE_ORDER},
    {Value: PURCHASEORDER_ITEM},
    {Value: SOURCE_SYSTEM},
    {Value: TARGET_SYSTEM},
    {Value: ERROR_TEXT},
    {Value: SHORT_ERROR_TEXT},
    {Value: OUTBOUND_DELIVERY},
    {Value: SALES_ORG},
    {Value: CUSTOMER},
    {Value: DISTRIBUTION_CHANNEL},
    {Value: DIVISION},
    {Value: CHANNEL},
    {Value: SOLUTION},
    {Value: STEP},
    {Value: CREATED_AT},
    {Value: CHANGED_AT},
    {Value: CHANGED_BY},
    {$Type: 'UI.DataFieldForAction', Action: 'openOrdersSrv.resolve' }
]};

annotate service.BIMGeneralErrors with @(UI: {SelectionFields: [
    BIM_ERROR_ID,
    PURCHASE_ORDER,
    SOURCE_SYSTEM,
    ERROR_TEXT,
    CUSTOMER,
    SOLUTION,
    STEP,
    DISTRIBUTION_CHANNEL
]});


annotate service.BIMGeneralErrors with {
    BIM_ERROR_ID          @title: '{i18n>BIM_ERROR_ID}'          @sap.Label: '{i18n>BIM_ERROR_ID}';
    PURCHASE_ORDER        @title: '{i18n>PO_EBELN}'              @sap.Label: '{i18n>PO_EBELN}'   @Common.IsDigitSequence: true;
    PURCHASEORDER_ITEM    @title: '{i18n>PO_EBELP}'              @sap.Label: '{i18n>PO_EBELP}'   @Common.IsDigitSequence: true;
    SOURCE_SYSTEM         @title: '{i18n>BIM_SOURCE_SYSTEM}'     @sap.Label: '{i18n>BIM_SOURCE_SYSTEM}';
    TARGET_SYSTEM         @title: '{i18n>BIM_TARGET_SYSTEM}'     @sap.Label: '{i18n>BIM_TARGET_SYSTEM}';
    ERROR_TEXT            @title: '{i18n>PO_ERROR_TEXT}'         @sap.Label: '{i18n>PO_ERROR_TEXT}';
    SHORT_ERROR_TEXT      @title: '{i18n>BIM_SHORT_ERROR_TEXT}'  @sap.Label: '{i18n>BIM_SHORT_ERROR_TEXT}';
    OUTBOUND_DELIVERY     @title: '{i18n>DELIVERY}'              @sap.Label: '{i18n>DELIVERY}';
    SALES_ORG             @title: '{i18n>SO_VKORG}'              @sap.Label: '{i18n>SO_VKORG}';
    CUSTOMER              @title: '{i18n>PO_KUNNR}'              @sap.Label: '{i18n>PO_KUNNR}';
    DISTRIBUTION_CHANNEL  @title: '{i18n>SO_VTWEG}'              @sap.Label: '{i18n>SO_VTWEG}';
    DIVISION              @title: '{i18n>SO_SPART}'              @sap.Label: '{i18n>SO_SPART}';
    CHANNEL               @title: '{i18n>BIM_CHANNEL}'           @sap.Label: '{i18n>BIM_CHANNEL}';
    SOLUTION              @title: '{i18n>BIM_SOLUTION}'          @sap.Label: '{i18n>BIM_SOLUTION}';
    STEP                  @title: '{i18n>BIM_STEP}'              @sap.Label: '{i18n>BIM_STEP}';
    CREATED_AT            @title: '{i18n>CreatedAt}'             @sap.Label: '{i18n>ChangedAt}'  @sap.filter.restriction: 'interval';
    CHANGED_AT            @title: '{i18n>ChangedAt}'             @sap.Label: '{i18n>ChangedAt}'  @sap.filter.restriction: 'interval';
    CHANGED_BY            @title: '{i18n>ChangedBy}'             @sap.Label: '{i18n>ChangedBy}';
}
