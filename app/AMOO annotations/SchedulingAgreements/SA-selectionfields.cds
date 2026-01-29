using openOrdersSrv as service from '../../../srv/order-monitoring-amoo-services.cds';

annotate service.schedulingAgreements with @(UI: {SelectionFields: [
    SO_VBELN,
    SO_VKORG,
    SO_VTWEG,
    SO_EDATU_REQUESTED,
    SO_AG_PARTNER,
    SO_WE_PARTNER,
    SO_ISSUE
], });