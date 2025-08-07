using srvOpenOrders as service from '../../srv/order-monitoring-amo-services.cds';

annotate service.Results with @(UI: {SelectionFields: [
    SO_VBELN,
    SO_VKORG,
    SO_VTWEG,
    SO_AG_PARTNER,
    SO_WE_PARTNER


],

});
