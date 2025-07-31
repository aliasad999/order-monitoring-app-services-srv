using srvOpenOrders as service from '../../srv/order-monitoring-amo-services.cds';

annotate service.SAPSystems with {
    @Common.Text           : mandantText
    @Common.TextArrangement: #TextOnly
    mandantKey  @title: '{i18n>SO_MANDT}'  @sap.Label: '{i18n>SO_MANDT}';
    @Common.TextFor
    mandantText;
};

annotate service.DCPStatus with {
    @Common.Text           : DCPStatusText
    @Common.TextArrangement: #TextOnly
    DCPStatusKey  @title: '{i18n>SO_DCP_ITEM_STATUS}}'  @sap.Label: '{i18n>SO_DCP_ITEM_STATUS}';
    @Common.TextFor
    DCPStatusText;
};