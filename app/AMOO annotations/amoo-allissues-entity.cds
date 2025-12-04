using openOrdersSrv as service from '../../srv/order-monitoring-amoo-services.cds';

// Text arrangement annotations (only for allIssues)
annotate service.allIssues with {
    @Common.Text           : SO_DCP_ITEM_STATUS_DESCRIPTION
    @Common.TextArrangement: #TextOnly
    SO_DCP_ITEM_STATUS       @title: '{i18n>SO_DCP_ITEM_STATUS}'               @sap.Label: '{i18n>SO_DCP_ITEM_STATUS}';
    @Common.TextFor
    SO_DCP_ITEM_STATUS_DESCRIPTION;
    @Common.Text           : SO_NPS_DESCRIPTION
    @Common.TextArrangement: #TextOnly
    SO_NPS                   @title: '{i18n>SO_NPS}'                           @sap.Label: '{i18n>SO_NPS}';
    @Common.TextFor
    SO_NPS_DESCRIPTION;
    @Common.Text           : SO_ISSUE_DESCRIPTION
    @Common.TextArrangement: #TextOnly
    SO_ISSUE                 @title: '{i18n>SO_ISSUE}'                         @sap.Label: '{i18n>SO_ISSUE}';
    @Common.TextFor
    SO_ISSUE_DESCRIPTION;
    @Common.Text           : SO_LANDX
    @Common.TextArrangement: #TextFirst
    SO_LAND1                 @title: '{i18n>SO_LAND1}'                         @sap.Label: '{i18n>SO_LAND1}';
    @Common.TextFor
    SO_LANDX;
    @Common.Text           : SO_MAKTX
    @Common.TextArrangement: #TextSeparate
    SO_MATNR                 @title: '{i18n>SO_MATNR}'                         @sap.Label: '{i18n>SO_MATNR}';
    @Common.TextFor
    SO_MAKTX;
    @Common.Text           : SO_AG_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_AG_PARTNER            @title: '{i18n>SO_AG_PARTNER_NAME}'               @sap.Label: '{i18n>SO_AG_PARTNER}';
    @Common.TextFor
    SO_AG_PARTNER_NAME;
    @Common.Text           : SO_WE_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_WE_PARTNER            @title: '{i18n>SO_WE_PARTNER_NAME}'               @sap.Label: '{i18n>SO_WE_PARTNER}';
    @Common.TextFor
    SO_WE_PARTNER_NAME;
    @Common.Text           : SO_VKORG_NAME1
    @Common.TextArrangement: #TextFirst
    SO_VKORG                 @title: '{i18n>SO_VKORG_NAME1}'                   @sap.Label: '{i18n>SO_VKORG}';
    @Common.TextFor
    SO_VKORG_NAME1;
    @Common.Text           : SO_FAKSP_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_FAKSP                 @title: '{i18n>SO_FAKSP}'                         @sap.Label: '{i18n>SO_FAKSP}';
    @Common.TextFor
    SO_FAKSP_VTEXT;
    @Common.Text           : SO_SUPPLY_SITUATION_DESCR
    @Common.TextArrangement: #TextFirst
    SO_SUPPLY_SITUATION      @title: '{i18n>SO_SUPPLY_SITUATION}'              @sap.Label: '{i18n>SO_SUPPLY_SITUATION}';
    @Common.TextFor
    SO_SUPPLY_SITUATION_DESCR;
    @Common.Text           : SO_PSTYV_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_PSTYV                 @title: '{i18n>SO_PSTYV}'                         @sap.Label: '{i18n>SO_PSTYV}';
    @Common.TextFor
    SO_PSTYV_VTEXT;
    @Common.Text           : SO_VKBUR_BEZEI
    @Common.TextArrangement: #TextFirst
    SO_VKBUR                 @title: '{i18n>SO_VKBUR}'                         @sap.Label: '{i18n>SO_VKBUR}';
    @Common.TextFor
    SO_VKBUR_BEZEI;
    @Common.Text           : SO_ABGRU_BEZEI
    @Common.TextArrangement: #TextFirst
    SO_ABGRU                 @title: '{i18n>SO_ABGRU}'                         @sap.Label: '{i18n>SO_ABGRU}';
    @Common.TextFor
    SO_ABGRU_BEZEI;
    @Common.Text           : SO_CO_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_CO_PARTNER            @title: '{i18n>SO_CO_PARTNER}'                    @sap.Label: '{i18n>SO_CO_PARTNER}';
    @Common.TextFor
    SO_CO_PARTNER_NAME;
    @Common.Text           : SO_NY_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_NY_PARTNER            @title: '{i18n>SO_NY_PARTNER}'                    @sap.Label: '{i18n>SO_NY_PARTNER}';
    @Common.TextFor
    SO_NY_PARTNER_NAME;
    @Common.Text           : SO_AS_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_AS_PARTNER            @title: '{i18n>SO_AS_PARTNER}'                    @sap.Label: '{i18n>SO_AS_PARTNER}';
    @Common.TextFor
    SO_AS_PARTNER_NAME;
    @Common.Text           : SO_VE_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_VE_PARTNER            @title: '{i18n>SO_VE_PARTNER}'                    @sap.Label: '{i18n>SO_VE_PARTNER}';
    @Common.TextFor
    SO_VE_PARTNER_NAME;
    @Common.Text           : SO_AM_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_AM_PARTNER            @title: '{i18n>SO_AM_PARTNER}'                    @sap.Label: '{i18n>SO_AM_PARTNER}';
    @Common.TextFor
    SO_AM_PARTNER_NAME;
    @Common.Text           : SO_BSARK_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_BSARK                 @title: '{i18n>SO_BSARK}'                         @sap.Label: '{i18n>SO_BSARK}';
    @Common.TextFor
    SO_BSARK_VTEXT;
    @Common.Text           : SO_TRAGR_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_TRAGR                 @title: '{i18n>SO_TRAGR}'                         @sap.Label: '{i18n>SO_TRAGR}';
    @Common.TextFor
    SO_TRAGR_VTEXT;
    @Common.Text           : SO_VKGRP_BEZEI
    @Common.TextArrangement: #TextFirst
    SO_VKGRP                 @title: '{i18n>SO_VKGRP}'                         @sap.Label: '{i18n>SO_VKGRP}';
    @Common.TextFor
    SO_VKGRP_BEZEI;
    @Common.Text           : SO_F_VSBED_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_F_VSBED               @title: '{i18n>SO_F_VSBED}'                       @sap.Label: '{i18n>SO_TRAGR}';
    @Common.TextFor
    SO_F_VSBED_VTEXT;
    @Common.Text           : SO_F_VKORG_VTEXT
    @Common.TextArrangement: #TextFirst
    SO_F_VKORG               @title: '{i18n>SO_F_VKORG}'                       @sap.Label: '{i18n>SO_F_VKORG}';
    @Common.TextFor
    SO_F_VKORG_VTEXT;
    @Common.Text           : SO_F_AS_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_F_AS_PARTNER          @title: '{i18n>SO_F_AS_PARTNER}'                  @sap.Label: '{i18n>SO_F_AS_PARTNER}';
    @Common.TextFor
    SO_F_AS_PARTNER_NAME;
    @Common.Text           : DL_LFART_VTEXT
    @Common.TextArrangement: #TextFirst
    DL_LFART                 @title: '{i18n>DL_LFART}'                         @sap.Label: '{i18n>DL_LFART}';
    @Common.TextFor
    DL_LFART_VTEXT;
    @Common.Text           : TM_VSART_BEZEI
    @Common.TextArrangement: #TextFirst
    TM_VSART                 @title: '{i18n>TM_VSART}'                         @sap.Label: '{i18n>TM_VSART}';
    @Common.TextFor
    TM_VSART_BEZEI;
    @Common.Text           : TM_TDLNR_NAME1
    @Common.TextArrangement: #TextFirst
    TM_TDLNR                 @title: '{i18n>TM_TDLNR}'                         @sap.Label: '{i18n>TM_TDLNR}';
    @Common.TextFor
    TM_TDLNR_NAME1;
    @Common.Text           : TM_STTRG_DDTEXT
    @Common.TextArrangement: #TextFirst
    TM_STTRG                 @title: '{i18n>TM_STTRG}'                         @sap.Label: '{i18n>TM_STTRG}';
    @Common.TextFor
    TM_STTRG_DDTEXT;
    @Common.Text           : SO_MDB_TEXT
    @Common.TextArrangement: #TextFirst
    SO_MDB                   @title: '{i18n>SO_MDB}'                           @sap.Label: '{i18n>SO_MDB}';
    @Common.TextFor
    SO_MDB_TEXT;
    @Common.Text           : SO_PERFK_LTEXT_LANG
    @Common.TextArrangement: #TextLast
    SO_PERFK                 @title: '{i18n>SO_PERFK}'                         @sap.Label: '{i18n>SO_PERFK}';
    @Common.TextFor
    SO_PERFK_LTEXT_LANG;
    @Common.Text           : PO_KUNNR_NAME
    @Common.TextArrangement: #TextLast
    PO_KUNNR                 @title: '{i18n>PO_KUNNR}'                         @sap.Label: '{i18n>PO_KUNNR}';
    @Common.TextFor
    PO_KUNNR_NAME;
    PO_PARTNER_9A_HEAD       @title: '{i18n>PO_PARTNER_9A_HEAD}'               @sap.Label: '{i18n>PO_PARTNER_9A_HEAD}';
    PO_PARTNER_9O_HEAD       @title: '{i18n>PO_PARTNER_9O_HEAD}'               @sap.Label: '{i18n>PO_PARTNER_9O_HEAD}';
    @Common.Text           : PO_BSART_BATXT
    @Common.TextArrangement: #TextLast
    PO_BSART                 @title: '{i18n>PO_BSART}'                         @sap.Label: '{i18n>PO_BSART}';
    @Common.TextFor
    PO_BSART_BATXT;
    @Common.Text           : SO_Z5_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_Z5_PARTNER            @title: '{i18n>SO_Z5_PARTNER}'                    @sap.Label: '{i18n>SO_Z5_PARTNER}';
    @Common.TextFor
    SO_Z5_PARTNER_NAME;

    @Common.Text           : SO_SB_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_SB_PARTNER            @title: '{i18n>SO_SB_PARTNER}'                    @sap.Label: '{i18n>SO_SB_PARTNER}';
    @Common.TextFor
    SO_SB_PARTNER_NAME;

    @Common.Text           : SO_AD_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_AD_PARTNER            @title: '{i18n>SO_AD_PARTNER}'                    @sap.Label: '{i18n>SO_AD_PARTNER}';
    @Common.TextFor
    SO_AD_PARTNER_NAME;

    ///// Mandants
    @Common.Text           : SO_MANDT_TEXT
    @Common.TextArrangement: #TextOnly
    SO_MANDT                 @title: '{i18n>SO_MANDT}'                         @sap.Label: '{i18n>SO_MANDT}';
    @Common.TextFor
    SO_MANDT_TEXT;

    @Common.Text           : DL_MANDT_TEXT
    @Common.TextArrangement: #TextOnly
    DL_MANDT                 @title: '{i18n>DL_MANDT}'                         @sap.Label: '{i18n>DL_MANDT}';
    @Common.TextFor
    DL_MANDT_TEXT;

    @Common.Text           : TM_MANDT_TEXT
    @Common.TextArrangement: #TextOnly
    TM_MANDT                 @title: '{i18n>TM_MANDT}'                         @sap.Label: '{i18n>TM_MANDT}';
    @Common.TextFor
    TM_MANDT_TEXT;

    @Common.Text           : BL_MANDT_INV_FIRST_TEXT
    @Common.TextArrangement: #TextOnly
    BL_MANDT_INV_FIRST       @title: '{i18n>BL_MANDT_INV_FIRST}'               @sap.Label: '{i18n>BL_MANDT_INV_FIRST}';
    @Common.TextFor
    BL_MANDT_INV_FIRST_TEXT;

    @Common.Text           : BL_MANDT_INV_LAST_TEXT
    @Common.TextArrangement: #TextOnly
    BL_MANDT_INV_LAST        @title: '{i18n>BL_MANDT_INV_LAST}'                @sap.Label: '{i18n>BL_MANDT_INV_LAST}';
    @Common.TextFor
    BL_MANDT_INV_LAST_TEXT;

    @Common.Text           : SO_FIRST_SO_MANDT_TEXT
    @Common.TextArrangement: #TextOnly
    SO_FIRST_SO_MANDT        @title: '{i18n>SO_FIRST_SO_MANDT}'                @sap.Label: '{i18n>SO_FIRST_SO_MANDT}';
    @Common.TextFor
    SO_FIRST_SO_MANDT_TEXT;

    @Common.Text           : SO_FINAL_SO_MANDT_TEXT
    @Common.TextArrangement: #TextOnly
    SO_FINAL_SO_MANDT        @title: '{i18n>SO_FINAL_SO_MANDT}'                @sap.Label: '{i18n>SO_FINAL_SO_MANDT}';
    @Common.TextFor
    SO_FINAL_SO_MANDT_TEXT;

    @Common.Text           : PO_MANDT_TEXT
    @Common.TextArrangement: #TextOnly
    PO_MANDT                 @title: '{i18n>PO_MANDT}'                         @sap.Label: '{i18n>PO_MANDT}';
    @Common.TextFor
    PO_MANDT_TEXT;

    @Common.Text           : SO_ISSUE_LOCATION_MANDT_TEXT
    @Common.TextArrangement: #TextOnly
    SO_ISSUE_LOCATION_MANDT  @title: '{i18n>SO_ISSUE_LOCATION_MANDT}'          @sap.Label: '{i18n>SO_ISSUE_LOCATION_MANDT}';
    @Common.TextFor
    SO_ISSUE_LOCATION_MANDT_TEXT;

    @Common.Text           : DL_TRMTYP_MAKTX
    @Common.TextArrangement: #TextLast
    DL_TRMTYP                @title: '{i18n>DL_TRMTYP_MAKTX_LANG}'             @sap.Label: '{i18n>DL_TRMTYP}';
    @Common.TextFor
    DL_TRMTYP_MAKTX;

    @Common.Text           : SO_AUGRU_BEZEI_LANG
    @Common.TextArrangement: #TextLast
    SO_AUGRU                 @title: '{i18n>SO_AUGRU_BEZEI_LANG}'              @sap.Label: '{i18n>SO_AUGRU}';
    @Common.TextFor
    SO_AUGRU_BEZEI_LANG;

    @Common.Text           : SO_KDGRP_KTEXT_LANG
    @Common.TextArrangement: #TextLast
    SO_KDGRP                 @title: '{i18n>SO_KDGRP_KTEXT_LANG}'              @sap.Label: '{i18n>SO_KDGRP}';
    @Common.TextFor
    SO_KDGRP_KTEXT_LANG;

    @Common.Text           : SO_WE_PARTNER_REGION_BEZEI_LANG
    @Common.TextArrangement: #TextLast
    SO_WE_PARTNER_REGION     @title: '{i18n>SO_WE_PARTNER_REGION_BEZEI_LANG}'  @sap.Label: '{i18n>SO_WE_PARTNER_REGION}';
    @Common.TextFor
    SO_WE_PARTNER_REGION_BEZEI_LANG;

    @Common.Text           : SO_TO_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_TO_PARTNER            @title: '{i18n>SO_TO_PARTNER}'                    @sap.Label: '{i18n>SO_TO_PARTNER}';
    @Common.TextFor
    SO_TO_PARTNER_NAME;
    @Common.TextFor
    SO_ZTERM_VTEXT_LANG;
    @Common.Text           : SO_ZTERM_VTEXT_LANG
    @Common.TextArrangement: #TextFirst
    SO_ZTERM                 @title: '{i18n>SO_ZTERM}'                         @sap.Label: '{i18n>SO_ZTERM}';
    @Common.Text           : SO_MFRGR_BEZEI_LANG
    @Common.TextArrangement: #TextFirst
    SO_MFRGR                 @title: '{i18n>SO_MFRGR}'                         @sap.Label: '{i18n>SO_MFRGR}';
    @Common.TextFor
    SO_MFRGR_BEZEI_LANG      @title: '{i18n>SO_MFRGR_BEZEI_LANG}'              @sap.Label: '{i18n>SO_MFRGR_BEZEI_LANG}';
    @Common.Text           : TM_TS_PARTNER_NAME1
    @Common.TextArrangement: #TextFirst
    TM_TS_PARTNER                 @title: '{i18n>TM_TS_PARTNER}'               @sap.Label: '{i18n>TM_TS_PARTNER}';
    @Common.TextFor
    TM_TS_PARTNER_NAME1      @title: '{i18n>TM_TS_PARTNER_NAME1}'              @sap.Label: '{i18n>TM_TS_PARTNER_NAME1}';
    
    @Common.Text           : SO_OM_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_OM_PARTNER               @title: '{i18n>SO_OM_PARTNER}'                    @sap.Label: '{i18n>SO_OM_PARTNER}'    @Common.IsDigitSequence: true;
    @Common.TextFor
    SO_OM_PARTNER_NAME          @title: '{i18n>SO_OM_PARTNER_NAME}'               @sap.Label: '{i18n>SO_OM_PARTNER_NAME}';

    @Common.Text           : SO_AH_PARTNER_NAME
    @Common.TextArrangement: #TextFirst
    SO_AH_PARTNER               @title: '{i18n>SO_AH_PARTNER}'                    @sap.Label: '{i18n>SO_AH_PARTNER}'    @Common.IsDigitSequence: true;
    @Common.TextFor
    SO_AH_PARTNER_NAME          @title: '{i18n>SO_AH_PARTNER_NAME}'               @sap.Label: '{i18n>SO_AH_PARTNER_NAME}';

    @Common.Text           : SO_KVGR5_TEXT
    @Common.TextArrangement: #TextFirst
    SO_KVGR5               @title: '{i18n>SO_KVGR5}'                    @sap.Label: '{i18n>SO_KVGR5}'    @Common.IsDigitSequence: true;
    @Common.TextFor
    SO_KVGR5_TEXT          @title: '{i18n>SO_KVGR5_TEXT}'               @sap.Label: '{i18n>SO_KVGR5_TEXT}';
}
/// UI visibility of fields
annotate service.allIssues with {
    SO_KWMENG                       @Measures.Unit          : SO_VRKME;
    SO_VRKME                        @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_KBMENG                       @Measures.Unit          : SO_VRKME;
    SO_UNCONFIRMED_QTY              @Measures.Unit          : SO_VRKME;
    SO_KBETR                        @Measures.ISOCurrency   : SO_WAERS;
    SO_WAERS                        @Semantics.currencyCode;
    SO_KPEIN                        @Measures.Unit          : SO_KMEIN;
    SO_KMEIN                        @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_NETWR                        @Measures.ISOCurrency   : SO_WAERK;
    SO_WAERK                        @Semantics.currencyCode;
    SO_F_PSMNG                      @Measures.Unit          : SO_F_AMEIN;
    SO_F_AMEIN                      @Semantics.unitOfMeasure: 'unit-of-measure';
    DL_LFIMG                        @Measures.Unit          : DL_VRKME;
    DL_LFIMG_BATCH                  @Measures.Unit          : DL_VRKME;
    DL_VRKME                        @Semantics.unitOfMeasure: 'unit-of-measure';
    DL_PEND_DEL_QUAN                @Measures.Unit          : DL_VRKME;
    BL_FKIMG_FIRST                  @Measures.Unit          : BL_VRKME_FIRST;
    BL_FKIMG_LAST                   @Measures.Unit          : BL_VRKME_LAST;
    BL_VRKME_FIRST                  @Semantics.unitOfMeasure: 'unit-of-measure';
    BL_VRKME_LAST                   @Semantics.unitOfMeasure: 'unit-of-measure';
    BL_NETWR_LAST                   @Measures.ISOCurrency   : BL_WAERK_LAST;
    BL_WAERK_LAST                   @Semantics.currencyCode;
    PO_MENGE                        @Measures.Unit          : PO_MEINS;
    PO_MEINS                        @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_ZMENG                        @Measures.Unit          : SO_ZIEME;
    SO_ZIEME                        @Semantics.unitOfMeasure: 'unit-of-measure';
    id                              @UI                     : {Hidden: true};
    SO_DOC_TYP                      @UI                     : {Hidden: true};
    SO_IGNORED                      @UI                     : {Hidden: true};
    BL_FKART_FIRST                  @UI                     : {Hidden: true};
    BL_FKART_LAST                   @UI                     : {Hidden: true};
    BL_FKIMG_FIRST                  @UI                     : {Hidden: true};
    SO_MANDT_TEXT                   @UI                     : {Hidden: true};
    DL_MANDT_TEXT                   @UI                     : {Hidden: true};
    TM_MANDT_TEXT                   @UI                     : {Hidden: true};
    BL_MANDT_INV_FIRST_TEXT         @UI                     : {Hidden: true};
    BL_MANDT_INV_LAST_TEXT          @UI                     : {Hidden: true};
    SO_FINAL_SO_MANDT_TEXT          @UI                     : {Hidden: true};
    SO_FIRST_SO_MANDT_TEXT          @UI                     : {Hidden: true};
    PO_MANDT_TEXT                   @UI                     : {Hidden: true};
    SO_ISSUE_LOCATION_MANDT_TEXT    @UI                     : {Hidden: true};
    PO_EKNAM                        @UI                     : {Hidden: true};
    PO_EKOTX                        @UI                     : {Hidden: true};
    PO_EBELN                        @UI                     : {Hidden: true};
    PO_KUNNR_NAME                   @UI                     : {Hidden: true};
    PO_BSART_BATXT                  @UI                     : {Hidden: true};
    criticalityDueDate              @UI                     : {Hidden: true};
    SO_CO_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_NY_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_AS_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_VE_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_AM_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_AG_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_WE_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_LANDX                        @UI                     : {Hidden: true};
    SO_NPS_DESCRIPTION              @UI                     : {Hidden: true};
    SO_ISSUE_DESCRIPTION            @UI                     : {Hidden: true};
    SO_DCP_ITEM_STATUS_DESCRIPTION  @UI                     : {Hidden: true};
    SO_ABGRU_BEZEI                  @UI                     : {Hidden: true};
    SO_ABSTA                        @UI                     : {Hidden: true};
    SO_KNUMV                        @UI                     : {Hidden: true};
    SO_VKORG_NAME1                  @UI                     : {Hidden: true};
    SO_FAKSP_VTEXT                  @UI                     : {Hidden: true};
    SO_SUPPLY_SITUATION_DESCR       @UI                     : {Hidden: true};
    SO_PSTYV_VTEXT                  @UI                     : {Hidden: true};
    SO_BSARK_VTEXT                  @UI                     : {Hidden: true};
    SO_VKBUR_BEZEI                  @UI                     : {Hidden: true};
    SO_F_POSNR                      @UI                     : {Hidden: true};
    SO_N_POSNR                      @UI                     : {Hidden: true};
    SO_I_POSNR                      @UI                     : {Hidden: true};
    SO_VBTYP                        @UI                     : {Hidden: true};
    SO_TRAGR_VTEXT                  @UI                     : {Hidden: true};
    SO_VKGRP_BEZEI                  @UI                     : {Hidden: true};
    SO_F_VSBED_VTEXT                @UI                     : {Hidden: true};
    SO_KNREF_ITM                    @UI                     : {Hidden: true};
    SO_VRKME                        @UI                     : {Hidden: true};
    SO_WAERS                        @UI                     : {Hidden: true};
    SO_KMEIN                        @UI                     : {Hidden: true};
    SO_WAERK                        @UI                     : {Hidden: true};
    SO_F_VKORG_VTEXT                @UI                     : {Hidden: true};
    SO_F_AMEIN                      @UI                     : {Hidden: true};
    SO_F_AS_PARTNER_NAME            @UI                     : {Hidden: true};
    DL_LFART_VTEXT                  @UI                     : {Hidden: true};
    BL_VRKME_FIRST                  @UI                     : {Hidden: true};
    BL_VRKME_LAST                   @UI                     : {Hidden: true};
    DL_TRMTYP_MAKTX                 @UI                     : {Hidden: true};
    TM_VSART_BEZEI                  @UI                     : {Hidden: true};
    TM_TDLNR_NAME1                  @UI                     : {Hidden: true};
    TM_STTRG_DDTEXT                 @UI                     : {Hidden: true};
    DL_VGBEL                        @UI                     : {Hidden: true};
    DL_VGPOS                        @UI                     : {Hidden: true};
    DL_POSAR                        @UI                     : {Hidden: true};
    DL_VRKME                        @UI                     : {Hidden: true};
    SO_MDB_TEXT                     @UI                     : {Hidden: true};
    SO_PERFK_LTEXT_LANG             @UI                     : {Hidden: true};
    SO_Z5_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_SB_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_AD_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_AUGRU_BEZEI_LANG             @UI                     : {Hidden: true};
    SO_KDGRP_KTEXT_LANG             @UI                     : {Hidden: true};
    SO_WE_PARTNER_REGION_BEZEI_LANG @UI                     : {Hidden: true};
    SO_TO_PARTNER_NAME              @UI                     : {Hidden: true};
    TM_ETA_EVENT_SOURCE             @UI                     : {Hidden: true};
    SO_ZTERM_VTEXT_LANG             @UI                     : {Hidden: true};
    SO_MVGR2_BEZEI_LANG             @UI                     : {Hidden: true};
    SO_DGSTA_DDTEXT_LANG            @UI                     : {Hidden: true};
    TM_OLD_ETA_VISTA_DATE           @UI                     : {Hidden: true};
    SO_MFRGR_BEZEI_LANG             @UI                     : {Hidden: true};
    TM_TS_PARTNER_NAME1             @UI                     : {Hidden: true};
    SO_OM_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_AH_PARTNER_NAME              @UI                     : {Hidden: true};
    SO_KVGR5_TEXT                   @UI                     : {Hidden: true};
    SO_ZIEME                        @UI                     : {Hidden: true};
}
