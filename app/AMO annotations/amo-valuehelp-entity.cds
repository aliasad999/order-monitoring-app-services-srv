using srvOpenOrders as service from '../../srv/order-monitoring-amo-services.cds';

annotate service.valueHelps with {
    TM_SHIPMENT_CURRENT_STATUS  @title: '{i18n>TM_SHIPMENT_CURRENT_STATUS}'  @sap.Label: '{i18n>TM_SHIPMENT_CURRENT_STATUS}';
}

