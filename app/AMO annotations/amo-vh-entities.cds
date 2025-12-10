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
annotate service.PredefFollowupNotes with {
    @Common.Text           : FollowUpNoteContent
    @Common.TextArrangement: #TextOnly
    FollowUpNoteId  @title: '{i18n>SO_FOLLOWUP_NOTES_LANG}'  @sap.Label: '{i18n>SO_FOLLOWUP_NOTES_LANG}';
    @Common.TextFor
    FollowUpNoteContent;
};
annotate service.PredefReasonComments01 with {
    @Common.Text           : ReasonComment
    @Common.TextArrangement: #TextOnly
    ReasonCodeKey  @title: '{i18n>SO_REASON_CODE_01_LANG}'  @sap.Label: '{i18n>SO_REASON_CODE_01_LANG}';
    @Common.TextFor
    ReasonComment;
};
annotate service.PredefReasonComments02 with {
    @Common.Text           : ReasonComment
    @Common.TextArrangement: #TextOnly
    ReasonCodeKey  @title: '{i18n>SO_REASON_CODE_02_LANG}'  @sap.Label: '{i18n>SO_REASON_CODE_02_LANG}';
    @Common.TextFor
    ReasonComment;
};
annotate service.PredefReasonComments03 with {
    @Common.Text           : ReasonComment
    @Common.TextArrangement: #TextOnly
    ReasonCodeKey  @title: '{i18n>SO_REASON_CODE_03_LANG}'  @sap.Label: '{i18n>SO_REASON_CODE_03_LANG}';
    @Common.TextFor
    ReasonComment;
};
annotate service.PredefReasonComments04 with {
    @Common.Text           : ReasonComment
    @Common.TextArrangement: #TextOnly
    ReasonCodeKey  @title: '{i18n>SO_REASON_CODE_04_LANG}'  @sap.Label: '{i18n>SO_REASON_CODE_04_LANG}';
    @Common.TextFor
    ReasonComment;
};
annotate service.PredefReasonComments05 with {
    @Common.Text           : ReasonComment
    @Common.TextArrangement: #TextOnly
    ReasonCodeKey  @title: '{i18n>SO_REASON_CODE_05_LANG}'  @sap.Label: '{i18n>SO_REASON_CODE_05_LANG}';
    @Common.TextFor
    ReasonComment;
};