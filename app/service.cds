using srvOpenOrders as service from '../srv/order-monitoring-app-services.cds';

annotate service.valueHelps with {

    SO_VBELN                   @title: '{i18n>salesOrder}'                 @sap.Label: '{i18n>salesOrder}';
    SO_POSNR                   @title: '{i18n>salesOrderItem}'             @sap.Label: '{i18n>salesOrderItem}';
    SO_ERDAT_ORDER             @title: '{i18n>CREATION_DATE}'              @sap.Label: '{i18n>CREATION_DATE}';
    SO_ERDAT_ITEM              @title: '{i18n>createdOn}'                  @sap.Label: '{i18n>createdOn}';
    SO_AUART                   @title: '{i18n>SO_AUART}'                   @sap.Label: '{i18n>SO_AUART}';
    SO_WERKS                   @title: '{i18n>SO_WERKS}'                   @sap.Label: '{i18n>SO_WERKS}';
    SO_VTWEG                   @title: '{i18n>SO_VTWEG}'                   @sap.Label: '{i18n>SO_VTWEG}';
    @Common.Text           : SO_MAKTX
    @Common.TextArrangement: #TextLast
    SO_MATNR                   @title: '{i18n>MaterialNo}'                 @sap.Label: '{i18n>MaterialNo}';
    @Common.TextFor
    SO_MAKTX                   @title: '{i18n>MaterialName}'               @sap.Label: '{i18n>MaterialName}';
    SO_KDMAT                   @title: '{i18n>SO_KDMAT}'                   @sap.Label: '{i18n>SO_KDMAT}';
    SO_BSTNK                   @title: '{i18n>SO_BSTNK}'                   @sap.Label: '{i18n>SO_BSTNK}';
    @Common.Text           : SO_AG_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_AG_PARTNER              @title: '{i18n>SoldToParty}'                @sap.Label: '{i18n>SoldToParty}';
    @Common.TextFor
    SO_AG_PARTNER_NAME;
    @Common.Text           : SO_WE_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_WE_PARTNER              @title: '{i18n>wePartnerNo}'                @sap.Label: '{i18n>wePartnerNo}';
    @Common.TextFor
    SO_WE_PARTNER_NAME;
    @Common.Text           : SO_LANDX
    @Common.TextArrangement: #TextLast
    SO_LAND1                   @title: '{i18n>SO_LAND1}'                   @sap.Label: '{i18n>SO_LAND1}';
    @Common.TextFor
    SO_LANDX                   @title: '{i18n>SO_LANDX}'                   @sap.Label: '{i18n>SO_LANDX}';
    SO_ORT01                   @title: '{i18n>ort1}'                       @sap.Label: '{i18n>ort1}';
    @Common.Text           : SO_VKORG_NAME1
    @Common.TextArrangement: #TextLast
    SO_VKORG                   @title: '{i18n>SO_VKORG}'                   @sap.Label: '{i18n>SO_VKORG}';
    @Common.TextFor
    SO_VKORG_NAME1             @title: '{i18n>vkorgName}'                  @sap.Label: '{i18n>vkorgName}';
    SO_KNREF_HEAD              @title: '{i18n>KNREF}'                      @sap.Label: '{i18n>KNREF}';
    //SO_KNREF_ITM     @title: '{i18n>SO_BSTNK}' @sap.Label: '{i18n>SO_BSTNK}'
    SO_VBUND                   @title: '{i18n>SO_VBUND}'                   @sap.Label: '{i18n>SO_VBUND}';
    SO_EDATU_REQUESTED         @title: '{i18n>SO_EDATU_REQUESTED}'         @sap.Label: '{i18n>SO_EDATU_REQUESTED}';
    SO_KWMENG                  @title: '{i18n>SO_KWMENG}'                  @sap.Label: '{i18n>SO_KWMENG}';
    SO_VRKME                   @title: '{i18n>SO_VRKME}'                   @sap.Label: '{i18n>SO_VRKME}';
    SO_EDATU_CONFIRMED         @title: '{i18n>ConfDelDate}'                @sap.Label: '{i18n>ConfDelDate}';
    SO_KBMENG                  @title: '{i18n>CONFIRMED_QUANTITY}'         @sap.Label: '{i18n>CONFIRMED_QUANTITY}';
    SO_LDDAT                   @title: '{i18n>LoadingDate}'                @sap.Label: '{i18n>LoadingDate}';
    SO_UNCONFIRMED_QTY         @title: '{i18n>UNCONFIRMED_QUANTITY}'       @sap.Label: '{i18n>UNCONFIRMED_QUANTITY}';
    SO_REQ_TEXT                @title: '{i18n>SO_REQ_TEXT}'                @sap.Label: '{i18n>SO_REQ_TEXT}';
    @Common.Text           : SO_FAKSP_VTEXT
    @Common.TextArrangement: #TextLast
    SO_FAKSP                   @title: '{i18n>SO_FAKSP}'                   @sap.Label: '{i18n>SO_FAKSP}';
    @Common.TextFor
    SO_FAKSP_VTEXT             @title: '{i18n>SO_FAKSP_VTEXT}'             @sap.Label: '{i18n>SO_FAKSP_VTEXT}';
    SO_LGORT                   @title: '{i18n>STORAGE_LOCATION}'           @sap.Label: '{i18n>STORAGE_LOCATION}';
    @Common.Text           : SO_SUPPLY_SITUATION_DESCR
    @Common.TextArrangement: #TextLast
    SO_SUPPLY_SITUATION        @title: '{i18n>SO_SUPPLY_SITUATION}'        @sap.Label: '{i18n>SO_SUPPLY_SITUATION}';
    @Common.TextFor
    SO_SUPPLY_SITUATION_DESCR  @title: '{i18n>SO_SUPPLY_SITUATION_DESCR}'  @sap.Label: '{i18n>SO_SUPPLY_SITUATION_DESCR}';
    SO_KBETR                   @title: '{i18n>SO_KBETR}'                   @sap.Label: '{i18n>SO_KBETR}';
    SO_WAERS                   @title: '{i18n>SO_WAERS}'                   @sap.Label: '{i18n>SO_WAERS}';
    SO_KPEIN                   @title: '{i18n>SO_KPEIN}'                   @sap.Label: '{i18n>SO_KPEIN}';
    SO_KMEIN                   @title: '{i18n>SO_KMEIN}'                   @sap.Label: '{i18n>SO_KMEIN}';
    SO_NETWR                   @title: '{i18n>NET_AMOUNT}'                 @sap.Label: '{i18n>NET_AMOUNT}';
    SO_WAERK                   @title: '{i18n>SO_WAERK}'                   @sap.Label: '{i18n>SO_WAERK}';
    SO_HTEXT                   @title: '{i18n>SO_HTEXT}'                   @sap.Label: '{i18n>SO_HTEXT}';
    @Common.Text           : SO_PSTYV_VTEXT
    @Common.TextArrangement: #TextLast
    SO_PSTYV                   @title: '{i18n>ITEM_CATEGORY}'              @sap.Label: '{i18n>ITEM_CATEGORY}';
    @Common.TextFor
    SO_PSTYV_VTEXT             @title: '{i18n>ITEM_CATEGORY_TEXT}'         @sap.Label: '{i18n>ITEM_CATEGORY_TEXT}';
    SO_DISPO                   @title: '{i18n>MRP_CONTROLLER}'             @sap.Label: '{i18n>MRP_CONTROLLER}';
    SO_KOSCH                   @title: '{i18n>SO_KOSCH}'                   @sap.Label: '{i18n>SO_KOSCH}';
    @Common.Text           : SO_VKBUR_BEZEI
    @Common.TextArrangement: #TextLast
    SO_VKBUR                   @title: '{i18n>SO_VKBUR}'                   @sap.Label: '{i18n>SO_VKBUR}';
    @Common.TextFor
    SO_VKBUR_BEZEI             @title: '{i18n>SO_VKBUR_BEZEI}'             @sap.Label: '{i18n>SO_VKBUR_BEZEI}';
    SO_ABGRU                   @title: '{i18n>SO_ABGRU}'                   @sap.Label: '{i18n>SO_ABGRU}';
    SO_ABSTA                   @title: '{i18n>SO_ABSTA}'                   @sap.Label: '{i18n>SO_ABSTA}';
    SO_KNUMV                   @title: '{i18n>SO_KNUMV}'                   @sap.Label: '{i18n>SO_KNUMV}';
    SO_SPART                   @title: '{i18n>SO_SPART}'                   @sap.Label: '{i18n>SO_SPART}';
    @Common.Text           : SO_CO_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_CO_PARTNER              @title: '{i18n>SO_CO_PARTNER}'              @sap.Label: '{i18n>SO_CO_PARTNER}';
    @Common.TextFor
    SO_CO_PARTNER_NAME         @title: '{i18n>SO_CO_PARTNER_NAME}'         @sap.Label: '{i18n>SO_CO_PARTNER_NAME}';
    @Common.Text           : SO_NY_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_NY_PARTNER              @title: '{i18n>SO_NY_PARTNER}'              @sap.Label: '{i18n>SO_NY_PARTNER}';
    @Common.TextFor
    SO_NY_PARTNER_NAME         @title: '{i18n>SO_NY_PARTNER_NAME}'         @sap.Label: '{i18n>SO_NY_PARTNER_NAME}';
    @Common.Text           : SO_AS_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_AS_PARTNER              @title: '{i18n>SO_AS_PARTNER}'              @sap.Label: '{i18n>SO_AS_PARTNER}';
    @Common.TextFor
    SO_AS_PARTNER_NAME         @title: '{i18n>SO_AS_PARTNER_NAME}'         @sap.Label: '{i18n>SO_AS_PARTNER_NAME}';
    @Common.Text           : SO_VE_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_VE_PARTNER              @title: '{i18n>SO_VE_PARTNER}'              @sap.Label: '{i18n>SO_VE_PARTNER}';
    @Common.TextFor
    SO_VE_PARTNER_NAME         @title: '{i18n>SO_VE_PARTNER_NAME}'         @sap.Label: '{i18n>SO_VE_PARTNER_NAME}';
    @Common.Text           : SO_AM_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_AM_PARTNER              @title: '{i18n>SO_AM_PARTNER}'              @sap.Label: '{i18n>SO_AM_PARTNER}';
    @Common.TextFor
    SO_AM_PARTNER_NAME         @title: '{i18n>SO_AM_PARTNER_NAME}'         @sap.Label: '{i18n>SO_AM_PARTNER_NAME}';
    SO_INCO1                   @title: '{i18n>inc01}'                      @sap.Label: '{i18n>inc01}';
    SO_INCO2                   @title: '{i18n>inc02}'                      @sap.Label: '{i18n>inc02}';
    SO_zterm                   @title: '{i18n>SO_zterm}'                   @sap.Label: '{i18n>SO_zterm}';
    SO_PRSDT                   @title: '{i18n>SO_PRSDT}'                   @sap.Label: '{i18n>SO_PRSDT}';
    SO_ZZ0S2REVG2              @title: '{i18n>custPo}'                     @sap.Label: '{i18n>custPo}';
    SO_ZZDKPPRODB              @title: '{i18n>SBU}'                        @sap.Label: '{i18n>SBU}';
    SO_BSARK                   @title: '{i18n>POType}'                     @sap.Label: '{i18n>POType}';
    DL_VBELN               @title: '{i18n>VBELN_DEL}'                  @sap.Label: '{i18n>VBELN_DEL}';
    DL_POSNR               @title: '{i18n>POSNR_DEL}'                  @sap.Label: '{i18n>POSNR_DEL}';
    DL_CHARG                   @title: '{i18n>CHARG}'                      @sap.Label: '{i18n>CHARG}';
    DL_LFIMG                   @title: '{i18n>LFIMG}'                      @sap.Label: '{i18n>LFIMG}';
    DL_VRKME               @title: '{i18n>vrkme_del}'                  @sap.Label: '{i18n>vrkme_del}';
    DL_POSAR                   @title: '{i18n>POSAR}'                      @sap.Label: '{i18n>POSAR}';
    DL_VGBEL                   @title: '{i18n>VGBEL}'                      @sap.Label: '{i18n>VGBEL}';
    DL_VGPOS                   @title: '{i18n>VGPOS}'                      @sap.Label: '{i18n>VGPOS}';
    @Common.Text           : DL_LFART_VTEXT
    @Common.TextArrangement: #TextLast
    DL_LFART                   @title: '{i18n>DELIVERY_TYPE}'              @sap.Label: '{i18n>DELIVERY_TYPE}';
    @Common.TextFor
    DL_LFART_VTEXT             @title: '{i18n>DELIVERY_TYPE_TEXT}'         @sap.Label: '{i18n>DELIVERY_TYPE_TEXT}';
    DL_LFDAT                   @title: '{i18n>lfdat}'                      @sap.Label: '{i18n>lfdat}';
    DL_HSDAT                   @title: '{i18n>HSDAT_DATE}'                 @sap.Label: '{i18n>HSDAT_DATE}';
    DL_VFDAT                   @title: '{i18n>VFDAT_DATE}'                 @sap.Label: '{i18n>VFDAT_DATE}';
    DL_TRAID                   @title: '{i18n>TRAID}'                      @sap.Label: '{i18n>TRAID}';
    DL_ZZ0S2BLNR               @title: '{i18n>ZZ0S2BLNR}'                  @sap.Label: '{i18n>ZZ0S2BLNR}';
    DL_PEND_DEL_QUAN           @title: '{i18n>PENDING_DEL_QTY}'            @sap.Label: '{i18n>PENDING_DEL_QTY}';
    LAST_NOTE                  @title: '{i18n>LAST_NOTE}'                  @sap.Label: '{i18n>LAST_NOTE}';
    TM_TKNUM                   @title: '{i18n>TKNUM}'                      @sap.Label: '{i18n>TKNUM}';
    @Common.Text           : DL_LFART_VTEXT
    @Common.TextArrangement: #TextLast
    TM_VSART                   @title: '{i18n>VSART}'                      @sap.Label: '{i18n>VSART}';
    @Common.TextFor
    TM_VSART_BEZEI;
    TM_EXTI1                   @title: '{i18n>EXTI1}'                      @sap.Label: '{i18n>EXTI1}';
    @Common.Text           : TM_TDLNR_NAME1
    @Common.TextArrangement: #TextLast
    TM_TDLNR                   @title: '{i18n>TDLNR}'                      @sap.Label: '{i18n>TDLNR}';
    @Common.TextFor
    TM_TDLNR_NAME1;
    TM_TRACKING_ID_COMP        @title: '{i18n>TRACKING_ID_COMP}'           @sap.Label: '{i18n>TRACKING_ID_COMP}';
    TM_TRACKING_ID_ELEM        @title: '{i18n>TRACKING_ID_ELEM}'           @sap.Label: '{i18n>TRACKING_ID_ELEM}';
    TM_DPTBG                   @title: '{i18n>DPTBG_DATE}'                 @sap.Label: '{i18n>DPTBG_DATE}';
    TM_DATBG                   @title: '{i18n>DATBG_DATE}'                 @sap.Label: '{i18n>DATBG_DATE}';
    TM_DPTEN                   @title: '{i18n>DPTEN_DATE}'                 @sap.Label: '{i18n>DPTEN_DATE}';
    TM_DATEN                   @title: '{i18n>DATEN_DATE}'                 @sap.Label: '{i18n>DATEN_DATE}';

};

annotate service.Results with {
    @Common.Text           : SO_LANDX
    @Common.TextArrangement: #TextLast
    SO_LAND1;
    @Common.TextFor
    SO_LANDX;
    SO_VBELN                   @title: '{i18n>salesOrder}'                 @sap.Label: '{i18n>salesOrder}';
    SO_POSNR                   @title: '{i18n>salesOrderItem}'             @sap.Label: '{i18n>salesOrderItem}';
    SO_ERDAT_ORDER             @title: '{i18n>CREATION_DATE}'              @sap.Label: '{i18n>CREATION_DATE}';
    SO_ERDAT_ITEM              @title: '{i18n>createdOn}'                  @sap.Label: '{i18n>createdOn}';
    SO_AUART                   @title: '{i18n>SO_AUART}'                   @sap.Label: '{i18n>SO_AUART}';
    SO_WERKS                   @title: '{i18n>SO_WERKS}'                   @sap.Label: '{i18n>SO_WERKS}';
    SO_VTWEG                   @title: '{i18n>SO_VTWEG}'                   @sap.Label: '{i18n>SO_VTWEG}';
    @Common.Text           : SO_MAKTX
    @Common.TextArrangement: #TextLast
    SO_MATNR                   @title: '{i18n>MaterialNo}'                 @sap.Label: '{i18n>MaterialNo}';
    @Common.TextFor
    SO_MAKTX                   @title: '{i18n>MaterialName}'               @sap.Label: '{i18n>MaterialName}';
    SO_KDMAT                   @title: '{i18n>SO_KDMAT}'                   @sap.Label: '{i18n>SO_KDMAT}';
    SO_BSTNK                   @title: '{i18n>SO_BSTNK}'                   @sap.Label: '{i18n>SO_BSTNK}';
    @Common.Text           : SO_AG_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_AG_PARTNER              @title: '{i18n>SoldToParty}'                @sap.Label: '{i18n>SoldToParty}';
    @Common.TextFor
    SO_AG_PARTNER_NAME;
    @Common.Text           : SO_WE_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_WE_PARTNER              @title: '{i18n>wePartnerNo}'                @sap.Label: '{i18n>wePartnerNo}';
    @Common.TextFor
    SO_WE_PARTNER_NAME;
    SO_LAND1                   @title: '{i18n>SO_LAND1}'                   @sap.Label: '{i18n>SO_LAND1}';
    SO_LANDX                   @title: '{i18n>SO_LANDX}'                   @sap.Label: '{i18n>SO_LANDX}';
    SO_ORT01                   @title: '{i18n>ort1}'                       @sap.Label: '{i18n>ort1}';
    @Common.Text           : SO_VKORG_NAME1
    @Common.TextArrangement: #TextLast
    SO_VKORG                   @title: '{i18n>SO_VKORG}'                   @sap.Label: '{i18n>SO_VKORG}';
    @Common.TextFor
    SO_VKORG_NAME1             @title: '{i18n>vkorgName}'                  @sap.Label: '{i18n>vkorgName}';
    SO_KNREF_HEAD              @title: '{i18n>KNREF}'                      @sap.Label: '{i18n>KNREF}';
    //SO_KNREF_ITM     @title: '{i18n>SO_BSTNK}' @sap.Label: '{i18n>SO_BSTNK}'
    SO_VBUND                   @title: '{i18n>SO_VBUND}'                   @sap.Label: '{i18n>SO_VBUND}';
    SO_EDATU_REQUESTED         @title: '{i18n>SO_EDATU_REQUESTED}'         @sap.Label: '{i18n>SO_EDATU_REQUESTED}';
    SO_KWMENG                  @title: '{i18n>SO_KWMENG}'                  @sap.Label: '{i18n>SO_KWMENG}';
    SO_VRKME                   @title: '{i18n>SO_VRKME}'                   @sap.Label: '{i18n>SO_VRKME}';
    SO_EDATU_CONFIRMED         @title: '{i18n>ConfDelDate}'                @sap.Label: '{i18n>ConfDelDate}';
    SO_KBMENG                  @title: '{i18n>CONFIRMED_QUANTITY}'         @sap.Label: '{i18n>CONFIRMED_QUANTITY}';
    SO_LDDAT                   @title: '{i18n>LoadingDate}'                @sap.Label: '{i18n>LoadingDate}';
    SO_UNCONFIRMED_QTY         @title: '{i18n>UNCONFIRMED_QUANTITY}'       @sap.Label: '{i18n>UNCONFIRMED_QUANTITY}';
    SO_REQ_TEXT                @title: '{i18n>SO_REQ_TEXT}'                @sap.Label: '{i18n>SO_REQ_TEXT}';
    @Common.Text           : SO_FAKSP_VTEXT
    @Common.TextArrangement: #TextLast
    SO_FAKSP                   @title: '{i18n>SO_FAKSP}'                   @sap.Label: '{i18n>SO_FAKSP}';
    @Common.TextFor
    SO_FAKSP_VTEXT             @title: '{i18n>SO_FAKSP_VTEXT}'             @sap.Label: '{i18n>SO_FAKSP_VTEXT}';
    SO_LGORT                   @title: '{i18n>STORAGE_LOCATION}'           @sap.Label: '{i18n>STORAGE_LOCATION}';
    @Common.Text           : SO_SUPPLY_SITUATION_DESCR
    @Common.TextArrangement: #TextLast
    SO_SUPPLY_SITUATION        @title: '{i18n>SO_SUPPLY_SITUATION}'        @sap.Label: '{i18n>SO_SUPPLY_SITUATION}';
    @Common.TextFor
    SO_SUPPLY_SITUATION_DESCR  @title: '{i18n>SO_SUPPLY_SITUATION_DESCR}'  @sap.Label: '{i18n>SO_SUPPLY_SITUATION_DESCR}';
    SO_KBETR                   @title: '{i18n>SO_KBETR}'                   @sap.Label: '{i18n>SO_KBETR}';
    SO_WAERS                   @title: '{i18n>SO_WAERS}'                   @sap.Label: '{i18n>SO_WAERS}';
    SO_KPEIN                   @title: '{i18n>SO_KPEIN}'                   @sap.Label: '{i18n>SO_KPEIN}';
    SO_KMEIN                   @title: '{i18n>SO_KMEIN}'                   @sap.Label: '{i18n>SO_KMEIN}';
    SO_NETWR                   @title: '{i18n>NET_AMOUNT}'                 @sap.Label: '{i18n>NET_AMOUNT}';
    SO_WAERK                   @title: '{i18n>SO_WAERK}'                   @sap.Label: '{i18n>SO_WAERK}';
    SO_HTEXT                   @title: '{i18n>SO_HTEXT}'                   @sap.Label: '{i18n>SO_HTEXT}';
    @Common.Text           : SO_PSTYV_VTEXT
    @Common.TextArrangement: #TextLast
    SO_PSTYV                   @title: '{i18n>ITEM_CATEGORY}'              @sap.Label: '{i18n>ITEM_CATEGORY}';
    @Common.TextFor
    SO_PSTYV_VTEXT             @title: '{i18n>ITEM_CATEGORY_TEXT}'         @sap.Label: '{i18n>ITEM_CATEGORY_TEXT}';
    SO_DISPO                   @title: '{i18n>MRP_CONTROLLER}'             @sap.Label: '{i18n>MRP_CONTROLLER}';
    SO_KOSCH                   @title: '{i18n>SO_KOSCH}'                   @sap.Label: '{i18n>SO_KOSCH}';
    @Common.Text           : SO_VKBUR_BEZEI
    @Common.TextArrangement: #TextLast
    SO_VKBUR                   @title: '{i18n>SO_VKBUR}'                   @sap.Label: '{i18n>SO_VKBUR}';
    @Common.TextFor
    SO_VKBUR_BEZEI             @title: '{i18n>SO_VKBUR_BEZEI}'             @sap.Label: '{i18n>SO_VKBUR_BEZEI}';
    SO_ABGRU                   @title: '{i18n>SO_ABGRU}'                   @sap.Label: '{i18n>SO_ABGRU}';
    SO_ABSTA                   @title: '{i18n>SO_ABSTA}'                   @sap.Label: '{i18n>SO_ABSTA}';
    SO_KNUMV                   @title: '{i18n>SO_KNUMV}'                   @sap.Label: '{i18n>SO_KNUMV}';
    SO_SPART                   @title: '{i18n>SO_SPART}'                   @sap.Label: '{i18n>SO_SPART}';
    @Common.Text           : SO_CO_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_CO_PARTNER              @title: '{i18n>SO_CO_PARTNER}'              @sap.Label: '{i18n>SO_CO_PARTNER}';
    @Common.TextFor
    SO_CO_PARTNER_NAME         @title: '{i18n>SO_CO_PARTNER_NAME}'         @sap.Label: '{i18n>SO_CO_PARTNER_NAME}';
    @Common.Text           : SO_NY_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_NY_PARTNER              @title: '{i18n>SO_NY_PARTNER}'              @sap.Label: '{i18n>SO_NY_PARTNER}';
    @Common.TextFor
    SO_NY_PARTNER_NAME         @title: '{i18n>SO_NY_PARTNER_NAME}'         @sap.Label: '{i18n>SO_NY_PARTNER_NAME}';
    @Common.Text           : SO_AS_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_AS_PARTNER              @title: '{i18n>SO_AS_PARTNER}'              @sap.Label: '{i18n>SO_AS_PARTNER}';
    @Common.TextFor
    SO_AS_PARTNER_NAME         @title: '{i18n>SO_AS_PARTNER_NAME}'         @sap.Label: '{i18n>SO_AS_PARTNER_NAME}';
    @Common.Text           : SO_VE_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_VE_PARTNER              @title: '{i18n>SO_VE_PARTNER}'              @sap.Label: '{i18n>SO_VE_PARTNER}';
    @Common.TextFor
    SO_VE_PARTNER_NAME         @title: '{i18n>SO_VE_PARTNER_NAME}'         @sap.Label: '{i18n>SO_VE_PARTNER_NAME}';
    @Common.Text           : SO_AM_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_AM_PARTNER              @title: '{i18n>SO_AM_PARTNER}'              @sap.Label: '{i18n>SO_AM_PARTNER}';
    @Common.TextFor
    SO_AM_PARTNER_NAME         @title: '{i18n>SO_AM_PARTNER_NAME}'         @sap.Label: '{i18n>SO_AM_PARTNER_NAME}';
    SO_INCO1                   @title: '{i18n>inc01}'                      @sap.Label: '{i18n>inc01}';
    SO_INCO2                   @title: '{i18n>inc02}'                      @sap.Label: '{i18n>inc02}';
    SO_zterm                   @title: '{i18n>SO_zterm}'                   @sap.Label: '{i18n>SO_zterm}';
    SO_PRSDT                   @title: '{i18n>SO_PRSDT}'                   @sap.Label: '{i18n>SO_PRSDT}';
    SO_ZZ0S2REVG2              @title: '{i18n>custPo}'                     @sap.Label: '{i18n>custPo}';
    SO_ZZDKPPRODB              @title: '{i18n>SBU}'                        @sap.Label: '{i18n>SBU}';
    SO_BSARK                   @title: '{i18n>POType}'                     @sap.Label: '{i18n>POType}';
    DL_VBELN               @title: '{i18n>VBELN_DEL}'                  @sap.Label: '{i18n>VBELN_DEL}';
    DL_POSNR               @title: '{i18n>POSNR_DEL}'                  @sap.Label: '{i18n>POSNR_DEL}';
    DL_CHARG                   @title: '{i18n>CHARG}'                      @sap.Label: '{i18n>CHARG}';
    DL_LFIMG                   @title: '{i18n>LFIMG}'                      @sap.Label: '{i18n>LFIMG}';
    DL_VRKME               @title: '{i18n>vrkme_del}'                  @sap.Label: '{i18n>vrkme_del}';
    DL_POSAR                   @title: '{i18n>POSAR}'                      @sap.Label: '{i18n>POSAR}';
    DL_VGBEL                   @title: '{i18n>VGBEL}'                      @sap.Label: '{i18n>VGBEL}';
    DL_VGPOS                   @title: '{i18n>VGPOS}'                      @sap.Label: '{i18n>VGPOS}';
    @Common.Text           : DL_LFART_VTEXT
    @Common.TextArrangement: #TextLast
    DL_LFART                   @title: '{i18n>DELIVERY_TYPE}'              @sap.Label: '{i18n>DELIVERY_TYPE}';
    @Common.TextFor
    DL_LFART_VTEXT             @title: '{i18n>DELIVERY_TYPE_TEXT}'         @sap.Label: '{i18n>DELIVERY_TYPE_TEXT}';
    DL_LFDAT                   @title: '{i18n>lfdat}'                      @sap.Label: '{i18n>lfdat}';
    DL_HSDAT                   @title: '{i18n>HSDAT_DATE}'                 @sap.Label: '{i18n>HSDAT_DATE}';
    DL_VFDAT                   @title: '{i18n>VFDAT_DATE}'                 @sap.Label: '{i18n>VFDAT_DATE}';
    DL_TRAID                   @title: '{i18n>TRAID}'                      @sap.Label: '{i18n>TRAID}';
    DL_ZZ0S2BLNR               @title: '{i18n>ZZ0S2BLNR}'                  @sap.Label: '{i18n>ZZ0S2BLNR}';
    DL_PEND_DEL_QUAN           @title: '{i18n>PENDING_DEL_QTY}'            @sap.Label: '{i18n>PENDING_DEL_QTY}';
    LAST_NOTE                  @title: '{i18n>LAST_NOTE}'                  @sap.Label: '{i18n>LAST_NOTE}';
    TM_TKNUM                   @title: '{i18n>TKNUM}'                      @sap.Label: '{i18n>TKNUM}';
    @Common.Text           : DL_LFART_VTEXT
    @Common.TextArrangement: #TextLast
    TM_VSART                   @title: '{i18n>VSART}'                      @sap.Label: '{i18n>VSART}';
    @Common.TextFor
    TM_VSART_BEZEI;
    TM_EXTI1                   @title: '{i18n>EXTI1}'                      @sap.Label: '{i18n>EXTI1}';
    @Common.Text           : TM_TDLNR_NAME1
    @Common.TextArrangement: #TextLast
    TM_TDLNR                   @title: '{i18n>TDLNR}'                      @sap.Label: '{i18n>TDLNR}';
    @Common.TextFor
    TM_TDLNR_NAME1;
    TM_TRACKING_ID_COMP        @title: '{i18n>TRACKING_ID_COMP}'           @sap.Label: '{i18n>TRACKING_ID_COMP}';
    TM_TRACKING_ID_ELEM        @title: '{i18n>TRACKING_ID_ELEM}'           @sap.Label: '{i18n>TRACKING_ID_ELEM}';
    TM_DPTBG                   @title: '{i18n>DPTBG_DATE}'                 @sap.Label: '{i18n>DPTBG_DATE}';
    TM_DATBG                   @title: '{i18n>DATBG_DATE}'                 @sap.Label: '{i18n>DATBG_DATE}';
    TM_DPTEN                   @title: '{i18n>DPTEN_DATE}'                 @sap.Label: '{i18n>DPTEN_DATE}';
    TM_DATEN                   @title: '{i18n>DATEN_DATE}'                 @sap.Label: '{i18n>DATEN_DATE}';


}

annotate service.Results with {

    SO_KWMENG                 @Measures.Unit          : SO_VRKME;
    SO_VRKME                  @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_KBMENG                 @Measures.Unit          : SO_VRKME;
    SO_UNCONFIRMED_QTY        @Measures.Unit          : SO_VRKME;
    SO_KBETR                  @Measures.ISOCurrency   : 'SO_WAERS';
    SO_WAERS                  @Semantics.currencyCode;
    SO_KPEIN                  @Measures.Unit          : SO_KMEIN;
    SO_KMEIN                  @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_NETWR                  @Measures.ISOCurrency   : SO_WAERK;
    SO_WAERK                  @Semantics.currencyCode;
    DL_LFIMG                  @Measures.Unit          : DL_VRKME;
    DL_VRKME              @Semantics.unitOfMeasure: 'unit-of-measure';
    DL_PEND_DEL_QUAN          @Measures.Unit          : DL_VRKME;
    SO_CO_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_NY_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_AS_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_VE_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_AM_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_AG_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_WE_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_MAKTX                  @UI                     : {Hidden: true};
    SO_LANDX                  @UI                     : {Hidden: true};
    SO_VKORG_NAME1            @UI                     : {Hidden: true};
    SO_FAKSP_VTEXT            @UI                     : {Hidden: true};
    SO_SUPPLY_SITUATION_DESCR @UI                     : {Hidden: true};
    SO_PSTYV_VTEXT            @UI                     : {Hidden: true};
    SO_BSARK_VTEXT            @UI                     : {Hidden: true};
    SO_VKBUR_BEZEI            @UI                     : {Hidden: true};
    DL_LFART_VTEXT            @UI                     : {Hidden: true};
    id                        @UI                     : {Hidden: true};
    MANDT                     @UI                     : {Hidden: true};
    SO_SPART                  @UI                     : {Hidden: true};
    SO_ABGRU                  @UI                     : {Hidden: true};
    SO_ABSTA                  @UI                     : {Hidden: true};
    SO_KNUMV                  @UI                     : {Hidden: true};
    LANGUAGE                  @UI                     : {Hidden: true};
    DL_HSDAT                  @UI                     : {Hidden: true};
    DL_VFDAT                  @UI                     : {Hidden: true};
    // Shipment Details Texts
    TM_VSART_BEZEI            @UI                     : {Hidden: true};
    TM_TDLNR_NAME1            @UI                     : {Hidden: true};
}

annotate service.valueHelps with {
    SO_KWMENG                 @Measures.Unit          : SO_VRKME;
    SO_VRKME                  @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_KBMENG                 @Measures.Unit          : SO_VRKME;
    SO_UNCONFIRMED_QTY        @Measures.Unit          : SO_VRKME;
    SO_KBETR                  @Measures.ISOCurrency   : 'SO_WAERS';
    SO_WAERS                  @Semantics.currencyCode;
    SO_KPEIN                  @Measures.Unit          : SO_KMEIN;
    SO_KMEIN                  @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_NETWR                  @Measures.ISOCurrency   : SO_WAERK;
    SO_WAERK                  @Semantics.currencyCode;
    DL_LFIMG                  @Measures.Unit          : DL_VRKME;
    DL_VRKME              @Semantics.unitOfMeasure: 'unit-of-measure';
    DL_PEND_DEL_QUAN          @Measures.Unit          : DL_VRKME;
    SO_CO_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_NY_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_AS_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_VE_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_AM_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_AG_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_WE_PARTNER_NAME        @UI                     : {Hidden: true};
    SO_MAKTX                  @UI                     : {Hidden: true};
    SO_LANDX                  @UI                     : {Hidden: true};
    SO_VKORG_NAME1            @UI                     : {Hidden: true};
    SO_FAKSP_VTEXT            @UI                     : {Hidden: true};
    SO_SUPPLY_SITUATION_DESCR @UI                     : {Hidden: true};
    SO_PSTYV_VTEXT            @UI                     : {Hidden: true};
    SO_VKBUR_BEZEI            @UI                     : {Hidden: true};
    DL_LFART_VTEXT            @UI                     : {Hidden: true};
    SO_ABGRU                  @UI                     : {Hidden: true};
    SO_SPART                  @UI                     : {Hidden: true};
    SO_ABSTA                  @UI                     : {Hidden: true};
    SO_KNUMV                  @UI                     : {Hidden: true};
    SO_BSARK_VTEXT            @UI                     : {Hidden: true};
    LANGUAGE                  @UI                     : {Hidden: true};
    DL_HSDAT                  @UI                     : {Hidden: true};
    DL_VFDAT                  @UI                     : {Hidden: true};
    // Shipment Details Texts
    TM_VSART_BEZEI            @UI                     : {Hidden: true};
    TM_TDLNR_NAME1            @UI                     : {Hidden: true};


}

annotate service.Results with {
    SO_VRKME
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VRKME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VRKME,
            ValueListProperty: 'SO_VRKME'
        }]
    }
}

annotate service.Results with {
    SO_KMEIN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KMEIN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_KMEIN,
            ValueListProperty: 'SO_KMEIN'
        }]
    }
}

annotate service.Results with {
    DL_VRKME
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VRKME_DEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_VRKME,
            ValueListProperty: 'DL_VRKME'
        }]
    }
}

annotate service.Results with {
    SO_WAERK
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_WAERK}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_WAERK,
            ValueListProperty: 'SO_WAERK'
        }]
    }
}

annotate service.Results with {
    SO_WAERS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_WAERS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_WAERS,
            ValueListProperty: 'SO_WAERS'
        }]
    }
}


annotate service.Results with {
    SO_VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>salesOrder}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VBELN,
            ValueListProperty: 'SO_VBELN'
        }]
    }
}

annotate service.Results with {
    SO_POSNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>salesOrderItem}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_POSNR,
            ValueListProperty: 'SO_POSNR'
        }]
    }
}

annotate service.Results with {
    SO_AUART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_AUART}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_AUART,
            ValueListProperty: 'SO_AUART'
        }

        ]
    }
};

annotate service.Results with {
    SO_WERKS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_WERKS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_AUART,
            ValueListProperty: 'SO_AUART'
        }

        ]
    }
};

annotate service.Results with {
    SO_VTWEG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VTWEG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VTWEG,
            ValueListProperty: 'SO_VTWEG'
        }

        ]
    }
};

annotate service.Results with {
    SO_MATNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>MaterialNo}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_MATNR,
            ValueListProperty: 'SO_MATNR'
        }

        ]
    }
};

annotate service.Results with {
    SO_KDMAT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KDMAT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_KDMAT,
            ValueListProperty: 'SO_KDMAT'
        }

        ]
    }
};

annotate service.Results with {
    SO_BSTNK
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_BSTNK}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_BSTNK,
            ValueListProperty: 'SO_BSTNK'
        }

        ]
    }
};

annotate service.Results with {
    SO_AG_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>agPartnerNo}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_AG_PARTNER,
            ValueListProperty: 'SO_AG_PARTNER'
        }

        ]
    }
};

annotate service.Results with {
    SO_WE_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>wePartnerNo}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_WE_PARTNER,
            ValueListProperty: 'SO_WE_PARTNER'
        }

        ]
    }
};

annotate service.Results with {
    SO_LAND1
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_LAND1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_LAND1,
            ValueListProperty: 'SO_LAND1'
        }

        ]
    }
};

annotate service.Results with {
    SO_ORT01
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ort1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ORT01,
            ValueListProperty: 'SO_ORT01'
        }

        ]
    }
};

annotate service.Results with {
    SO_VKORG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VKORG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VKORG,
            ValueListProperty: 'SO_VKORG'
        }

        ]
    }
};

annotate service.Results with {
    SO_VBUND
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VBUND}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VBUND,
            ValueListProperty: 'SO_VBUND'
        }

        ]
    }
};

annotate service.Results with {
    SO_KWMENG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KWMENG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_KWMENG,
                ValueListProperty: 'SO_KWMENG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VRKME'
            },

        ]
    }
};

annotate service.Results with {
    SO_KBMENG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>CONFIRMED_QUANTITY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_KBMENG,
                ValueListProperty: 'SO_KBMENG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VRKME'
            },

        ]
    }
};

annotate service.Results with {
    SO_UNCONFIRMED_QTY
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>UNCONFIRMED_QUANTITY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_UNCONFIRMED_QTY,
                ValueListProperty: 'SO_UNCONFIRMED_QTY'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VRKME'
            }

        ]
    }
};

annotate service.Results with {
    SO_REQ_TEXT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REQ_TEXT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REQ_TEXT,
            ValueListProperty: 'SO_REQ_TEXT'
        }

        ]
    }
};

annotate service.Results with {
    SO_FAKSP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_FAKSP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_FAKSP,
            ValueListProperty: 'SO_FAKSP'
        }

        ]
    }
};

annotate service.Results with {
    SO_LGORT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>STORAGE_LOCATION}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_LGORT,
            ValueListProperty: 'SO_LGORT'
        }

        ]
    }
};

annotate service.Results with {
    SO_SUPPLY_SITUATION
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_SUPPLY_SITUATION}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_SUPPLY_SITUATION,
            ValueListProperty: 'SO_SUPPLY_SITUATION'
        }

        ]
    }
};

annotate service.Results with {
    SO_KBETR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KBETR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_KBETR,
                ValueListProperty: 'SO_KBETR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_WAERS'
            }

        ]
    }
};

annotate service.Results with {
    SO_KPEIN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KPEIN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_KPEIN,
                ValueListProperty: 'SO_KPEIN'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_KMEIN'
            }

        ]
    }
};

annotate service.Results with {
    SO_NETWR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>NET_AMOUNT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_NETWR,
                ValueListProperty: 'SO_NETWR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_WAERK'
            }

        ]
    }
};

annotate service.Results with {
    SO_HTEXT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_HTEXT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_HTEXT,
            ValueListProperty: 'SO_HTEXT'
        }

        ]
    }
};

annotate service.Results with {
    SO_PSTYV
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ITEM_CATEGORY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_PSTYV,
            ValueListProperty: 'SO_PSTYV'
        }

        ]
    }
};

annotate service.Results with {
    SO_DISPO
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>MRP_CONTROLLER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_DISPO,
            ValueListProperty: 'SO_DISPO'
        }

        ]
    }
};

annotate service.Results with {
    SO_KOSCH
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KOSCH}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_KOSCH,
            ValueListProperty: 'SO_KOSCH'
        }

        ]
    }
};

annotate service.Results with {
    SO_VKBUR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VKBUR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VKBUR,
            ValueListProperty: 'SO_VKBUR'
        }

        ]
    }
};

annotate service.Results with {
    SO_CO_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_CO_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_CO_PARTNER,
            ValueListProperty: 'SO_CO_PARTNER'
        }

        ]
    }
};

annotate service.Results with {
    SO_NY_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_NY_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_NY_PARTNER,
            ValueListProperty: 'SO_NY_PARTNER'
        }

        ]
    }
};

annotate service.Results with {
    SO_AS_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_AS_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_AS_PARTNER,
            ValueListProperty: 'SO_AS_PARTNER'
        }

        ]
    }
};

annotate service.Results with {
    SO_VE_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VE_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VE_PARTNER,
            ValueListProperty: 'SO_VE_PARTNER'
        }

        ]
    }
};

annotate service.Results with {
    SO_AM_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_AM_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_AM_PARTNER,
            ValueListProperty: 'SO_AM_PARTNER'
        }

        ]
    }
};

annotate service.Results with {
    SO_INCO1
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>inc01}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_INCO1,
            ValueListProperty: 'SO_INCO1'
        }

        ]
    }
};

annotate service.Results with {
    SO_INCO2
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>inc02}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_INCO2,
            ValueListProperty: 'SO_INCO2'
        }

        ]
    }
};

annotate service.Results with {
    SO_zterm
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_zterm}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_zterm,
            ValueListProperty: 'SO_zterm'
        }

        ]
    }
};

annotate service.Results with {
    SO_ZZ0S2REVG2
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>custPo}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ZZ0S2REVG2,
            ValueListProperty: 'SO_ZZ0S2REVG2'
        }

        ]
    }
};

annotate service.Results with {
    SO_ZZDKPPRODB
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SBU}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ZZDKPPRODB,
            ValueListProperty: 'SO_ZZDKPPRODB'
        }

        ]
    }
};

annotate service.Results with {
    SO_BSARK
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>POType}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_BSARK,
            ValueListProperty: 'SO_BSARK'
        }

        ]
    }
};


annotate service.Results with {
    DL_VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VBELN_DEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_VBELN,
            ValueListProperty: 'DL_VBELN'
        }

        ]
    }
};

annotate service.Results with {
    DL_POSNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>POSNR_DEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_POSNR,
            ValueListProperty: 'DL_POSNR'
        }

        ]
    }
};

annotate service.Results with {
    DL_CHARG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>CHARG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_CHARG,
            ValueListProperty: 'DL_CHARG'
        }

        ]
    }
};

annotate service.Results with {
    DL_LFIMG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>LFIMG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DL_LFIMG,
                ValueListProperty: 'DL_LFIMG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DL_VRKME'
            }

        ]
    }
};

annotate service.Results with {
    DL_POSAR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>POSAR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_POSAR,
            ValueListProperty: 'DL_POSAR'
        }

        ]
    }
};

annotate service.Results with {
    DL_VGBEL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VGBEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_VGBEL,
            ValueListProperty: 'DL_VGBEL'
        }

        ]
    }
};

annotate service.Results with {
    DL_VGPOS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VGPOS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_VGPOS,
            ValueListProperty: 'DL_VGPOS'
        }

        ]
    }
};

annotate service.Results with {
    DL_LFART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>LFART}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_LFART,
            ValueListProperty: 'DL_LFART'
        }

        ]
    }
};

annotate service.Results with {
    DL_TRAID
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TRAID}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_TRAID,
            ValueListProperty: 'DL_TRAID'
        }

        ]
    }
};

annotate service.Results with {
    DL_ZZ0S2BLNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ZZ0S2BLNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_ZZ0S2BLNR,
            ValueListProperty: 'DL_ZZ0S2BLNR'
        }

        ]
    }
};

annotate service.Results with {
    TM_TKNUM
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TKNUM}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_TKNUM,
            ValueListProperty: 'TM_TKNUM'
        }

        ]
    }
};

annotate service.Results with {
    TM_VSART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VSART}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_VSART,
            ValueListProperty: 'TM_VSART'
        }

        ]
    }
};

annotate service.Results with {
    TM_EXTI1
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>EXTI1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_EXTI1,
            ValueListProperty: 'TM_EXTI1'
        }

        ]
    }
};

annotate service.Results with {
    TM_TDLNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TDLNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_TDLNR,
            ValueListProperty: 'TM_TDLNR'
        }

        ]
    }
};

annotate service.Results with {
    TM_TRACKING_ID_COMP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TRACKING_ID_COMP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_TRACKING_ID_COMP,
            ValueListProperty: 'TM_TRACKING_ID_COMP'
        }

        ]
    }
};

annotate service.Results with {
    TM_TRACKING_ID_ELEM
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TRACKING_ID_ELEM}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_TRACKING_ID_ELEM,
            ValueListProperty: 'TM_TRACKING_ID_ELEM'
        }

        ]
    }
};

annotate service.Results with {
    DL_PEND_DEL_QUAN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PEND_DEL_QUAN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DL_PEND_DEL_QUAN,
                ValueListProperty: 'DL_PEND_DEL_QUAN'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DL_VRKME'
            }

        ]
    }
};


annotate service.Results with @UI.LineItem: {
    ![@UI.Criticality]: 5,
    $value            : [
        {Value: SO_VBELN},
        {Value: SO_POSNR},
        {Value: SO_ERDAT_ORDER},
        {Value: SO_ERDAT_ITEM},
        {Value: SO_AUART},
        {Value: SO_WERKS},
        {Value: SO_VTWEG},
        {Value: SO_MATNR},
        {Value: SO_MAKTX},
        {Value: SO_KDMAT},
        {Value: SO_BSTNK},
        {Value: SO_AG_PARTNER},
        {Value: SO_WE_PARTNER},
        {Value: SO_LAND1},
        {Value: SO_LANDX},
        {Value: SO_ORT01},
        {Value: SO_VKORG},
        {Value: SO_VKORG_NAME1},
        {Value: SO_KNREF_HEAD},
        {Value: SO_KNREF_ITM},
        {Value: SO_VBUND},
        {Value: SO_EDATU_REQUESTED},
        {Value: SO_KWMENG},
        {Value: SO_VRKME},
        {Value: SO_EDATU_CONFIRMED},
        {Value: SO_KBMENG},
        {Value: SO_LDDAT},
        {Value: SO_UNCONFIRMED_QTY},
        {Value: SO_REQ_TEXT},
        {Value: SO_FAKSP},
        {Value: SO_FAKSP_VTEXT},
        {Value: SO_LGORT},
        {Value: SO_SUPPLY_SITUATION},
        {Value: SO_SUPPLY_SITUATION_DESCR},
        {Value: SO_KBETR},
        {Value: SO_WAERS},
        {Value: SO_KPEIN},
        {Value: SO_KMEIN},
        {Value: SO_NETWR},
        {Value: SO_WAERK},
        {Value: SO_HTEXT},
        {Value: SO_PSTYV},
        {Value: SO_PSTYV_VTEXT},
        {Value: SO_DISPO},
        {Value: SO_KOSCH},
        {Value: SO_VKBUR},
        {Value: SO_VKBUR_BEZEI},
        {Value: SO_ABGRU},
        {Value: SO_ABSTA},
        {Value: SO_KNUMV},
        {Value: SO_SPART},
        {Value: SO_CO_PARTNER},
        {Value: SO_CO_PARTNER_NAME},
        {Value: SO_NY_PARTNER},
        {Value: SO_NY_PARTNER_NAME},
        {Value: SO_AS_PARTNER},
        {Value: SO_AS_PARTNER_NAME},
        {Value: SO_VE_PARTNER},
        {Value: SO_VE_PARTNER_NAME},
        {Value: SO_AM_PARTNER},
        {Value: SO_AM_PARTNER_NAME},
        {Value: SO_AG_PARTNER_NAME},
        {Value: SO_WE_PARTNER_NAME},

    ]
};

annotate service.Results with @(UI: {SelectionFields: [
    SO_VBELN,
    SO_POSNR,
    SO_VKORG,
    SO_MATNR,
    SO_FAKSP


],

});