using openOrdersSrv as service from '../../../srv/order-monitoring-amoo-services.cds';

// Text arrangement annotations (only for SAValueHelps)
annotate service.SAValueHelps with {
    @Common.Text           : SO_NPS_DESCRIPTION
    @Common.TextArrangement: #TextOnly
    SO_NPS                         @title: '{i18n>SO_NPS}'              @sap.Label: '{i18n>SO_NPS}';
    SO_NPS_DESCRIPTION             @UI: {Hidden: true};
    @Common.Text           : SO_ISSUE_DESCRIPTION
    @Common.TextArrangement: #TextOnly
    SO_ISSUE                       @title: '{i18n>SO_ISSUE}'            @sap.Label: '{i18n>SO_ISSUE}';
    SO_ISSUE_DESCRIPTION           @UI: {Hidden: true};
    @Common.Text           : SO_DCP_ITEM_STATUS_DESCRIPTION
    @Common.TextArrangement: #TextOnly
    SO_DCP_ITEM_STATUS             @title: '{i18n>SO_DCP_ITEM_STATUS}'  @sap.Label: '{i18n>SO_DCP_ITEM_STATUS}';
    SO_DCP_ITEM_STATUS_DESCRIPTION @UI: {Hidden: true};
}
