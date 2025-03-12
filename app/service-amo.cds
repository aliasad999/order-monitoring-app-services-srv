using srvOpenOrders as service from '../srv/order-monitoring-amo-services.cds';

annotate service.Results with @Consumption.dbHints: [
    'USE_HEX_PLAN',
    'HEX_INDEX_JOIN'
];

annotate service.valueHelps with @Consumption.dbHints: [
    'USE_HEX_PLAN',
    'HEX_INDEX_JOIN'
];


annotate service.valueHelps with {
    SO_VBELN                        @title: '{i18n>SO_VBELN}'                    @sap.Label: '{i18n>SO_VBELN}';
    SO_POSNR                        @title: '{i18n>SO_POSNR}'                    @sap.Label: '{i18n>SO_POSNR}'            @Common.IsDigitSequence: true;
    SO_ERDAT_ORDER                  @title: '{i18n>SO_ERDAT_ORDER}'              @sap.Label: '{i18n>SO_ERDAT_ORDER}';
    SO_ERDAT_ITEM                   @title: '{i18n>SO_ERDAT_ITEM}'               @sap.Label: '{i18n>SO_ERDAT_ITEM}';
    SO_AUART                        @title: '{i18n>SO_AUART}'                    @sap.Label: '{i18n>SO_AUART}';
    SO_WERKS                        @title: '{i18n>SO_WERKS}'                    @sap.Label: '{i18n>SO_WERKS}';
    SO_VTWEG                        @title: '{i18n>SO_VTWEG}'                    @sap.Label: '{i18n>SO_VTWEG}';
    SO_MATNR                        @title: '{i18n>SO_MATNR}'                    @sap.Label: '{i18n>SO_MATNR}'            @Common.IsDigitSequence: true;
    SO_MAKTX                        @title: '{i18n>SO_MAKTX}'                    @sap.Label: '{i18n>SO_MAKTX}';
    SO_KDMAT                        @title: '{i18n>SO_KDMAT}'                    @sap.Label: '{i18n>SO_KDMAT}';
    SO_AG_PARTNER                   @title: '{i18n>SO_AG_PARTNER}'               @sap.Label: '{i18n>SO_AG_PARTNER}'       @Common.IsDigitSequence: true;
    SO_AG_PARTNER_NAME              @title: '{i18n>SO_AG_PARTNER_NAME}'          @sap.Label: '{i18n>SO_AG_PARTNER_NAME}';
    SO_WE_PARTNER                   @title: '{i18n>SO_WE_PARTNER}'               @sap.Label: '{i18n>SO_WE_PARTNER}'       @Common.IsDigitSequence: true;
    SO_WE_PARTNER_NAME              @title: '{i18n>SO_WE_PARTNER_NAME}'          @sap.Label: '{i18n>SO_WE_PARTNER_NAME}';
    SO_LAND1                        @title: '{i18n>SO_LAND1}'                    @sap.Label: '{i18n>SO_LAND1}';
    SO_LANDX                        @title: '{i18n>SO_LANDX}'                    @sap.Label: '{i18n>SO_LANDX}';
    SO_ORT01                        @title: '{i18n>SO_ORT01}'                    @sap.Label: '{i18n>SO_ORT01}';
    SO_VKORG                        @title: '{i18n>SO_VKORG}'                    @sap.Label: '{i18n>SO_VKORG}';
    SO_VKORG_NAME1                  @title: '{i18n>SO_VKORG_NAME1}'              @sap.Label: '{i18n>SO_VKORG_NAME1}';
    SO_KNREF_HEAD                   @title: '{i18n>SO_KNREF_HEAD}'               @sap.Label: '{i18n>SO_KNREF_HEAD}';
    SO_VBUND                        @title: '{i18n>SO_VBUND}'                    @sap.Label: '{i18n>SO_VBUND}';
    SO_EDATU_REQUESTED              @title: '{i18n>SO_EDATU_REQUESTED}'          @sap.Label: '{i18n>SO_EDATU_REQUESTED}';
    SO_KWMENG                       @title: '{i18n>SO_KWMENG}'                   @sap.Label: '{i18n>SO_KWMENG}';
    SO_VRKME                        @title: '{i18n>SO_VRKME}'                    @sap.Label: '{i18n>SO_VRKME}';
    SO_EDATU_CONFIRMED              @title: '{i18n>SO_EDATU_CONFIRMED}'          @sap.Label: '{i18n>SO_EDATU_CONFIRMED}';
    SO_KBMENG                       @title: '{i18n>SO_KBMENG}'                   @sap.Label: '{i18n>SO_KBMENG}';
    SO_UNCONFIRMED_QTY              @title: '{i18n>SO_UNCONFIRMED_QTY}'          @sap.Label: '{i18n>SO_UNCONFIRMED_QTY}';
    SO_REQ_TEXT                     @title: '{i18n>SO_REQ_TEXT}'                 @sap.Label: '{i18n>SO_REQ_TEXT}';
    SO_FAKSP                        @title: '{i18n>SO_FAKSP}'                    @sap.Label: '{i18n>SO_FAKSP}';
    SO_FAKSP_VTEXT                  @title: '{i18n>SO_FAKSP_VTEXT}'              @sap.Label: '{i18n>SO_FAKSP_VTEXT}';
    SO_F_LGORT                      @title: '{i18n>SO_LGORT}'                    @sap.Label: '{i18n>SO_LGORT}';
    SO_SUPPLY_SITUATION             @title: '{i18n>SO_SUPPLY_SITUATION}'         @sap.Label: '{i18n>SO_SUPPLY_SITUATION}';
    SO_SUPPLY_SITUATION_DESCR       @title: '{i18n>SO_SUPPLY_SITUATION_DESCR}'   @sap.Label: '{i18n>SO_SUPPLY_SITUATION_DESCR}';
    SO_KBETR                        @title: '{i18n>SO_KBETR}'                    @sap.Label: '{i18n>SO_KBETR}';
    SO_WAERS                        @title: '{i18n>SO_WAERS}'                    @sap.Label: '{i18n>SO_WAERS}';
    SO_KPEIN                        @title: '{i18n>SO_KPEIN}'                    @sap.Label: '{i18n>SO_KPEIN}';
    SO_KMEIN                        @title: '{i18n>SO_KMEIN}'                    @sap.Label: '{i18n>SO_KMEIN}';
    SO_NETWR                        @title: '{i18n>SO_NETWR}'                    @sap.Label: '{i18n>SO_NETWR}';
    SO_WAERK                        @title: '{i18n>SO_WAERK}'                    @sap.Label: '{i18n>SO_WAERK}';
    SO_HTEXT                        @title: '{i18n>SO_HTEXT}'                    @sap.Label: '{i18n>SO_HTEXT}';
    SO_PSTYV                        @title: '{i18n>SO_PSTYV}'                    @sap.Label: '{i18n>SO_PSTYV}';
    SO_PSTYV_VTEXT                  @title: '{i18n>SO_PSTYV_VTEXT}'              @sap.Label: '{i18n>SO_PSTYV_VTEXT}';
    SO_DISPO                        @title: '{i18n>SO_DISPO}'                    @sap.Label: '{i18n>SO_DISPO}';
    SO_KOSCH                        @title: '{i18n>SO_KOSCH}'                    @sap.Label: '{i18n>SO_KOSCH}';
    SO_VKBUR                        @title: '{i18n>SO_VKBUR}'                    @sap.Label: '{i18n>SO_VKBUR}';
    SO_VKBUR_BEZEI                  @title: '{i18n>SO_VKBUR_BEZEI}'              @sap.Label: '{i18n>SO_VKBUR_BEZEI}';
    SO_ABGRU                        @title: '{i18n>SO_ABGRU}'                    @sap.Label: '{i18n>SO_ABGRU}';
    SO_ABGRU_BEZEI                  @title: '{i18n>SO_ABGRU_BEZEI}'              @sap.Label: '{i18n>SO_ABGRU_BEZEI}';
    SO_ABSTA                        @title: '{i18n>SO_ABSTA}'                    @sap.Label: '{i18n>SO_ABSTA}';
    SO_KNUMV                        @title: '{i18n>SO_KNUMV}'                    @sap.Label: '{i18n>SO_KNUMV}';
    SO_SPART                        @title: '{i18n>SO_SPART}'                    @sap.Label: '{i18n>SO_SPART}';
    SO_CO_PARTNER                   @title: '{i18n>SO_CO_PARTNER}'               @sap.Label: '{i18n>SO_CO_PARTNER}'       @Common.IsDigitSequence: true;
    SO_CO_PARTNER_NAME              @title: '{i18n>SO_CO_PARTNER_NAME}'          @sap.Label: '{i18n>SO_CO_PARTNER_NAME}';
    SO_NY_PARTNER                   @title: '{i18n>SO_NY_PARTNER}'               @sap.Label: '{i18n>SO_NY_PARTNER}'       @Common.IsDigitSequence: true;
    SO_NY_PARTNER_NAME              @title: '{i18n>SO_NY_PARTNER_NAME}'          @sap.Label: '{i18n>SO_NY_PARTNER_NAME}';
    SO_AS_PARTNER                   @title: '{i18n>SO_AS_PARTNER}'               @sap.Label: '{i18n>SO_AS_PARTNER}'       @Common.IsDigitSequence: true;
    SO_AS_PARTNER_NAME              @title: '{i18n>SO_AS_PARTNER_NAME}'          @sap.Label: '{i18n>SO_AS_PARTNER_NAME}';
    SO_VE_PARTNER                   @title: '{i18n>SO_VE_PARTNER}'               @sap.Label: '{i18n>SO_VE_PARTNER}'       @Common.IsDigitSequence: true;
    SO_VE_PARTNER_NAME              @title: '{i18n>SO_VE_PARTNER_NAME}'          @sap.Label: '{i18n>SO_VE_PARTNER_NAME}';
    SO_AM_PARTNER                   @title: '{i18n>SO_AM_PARTNER}'               @sap.Label: '{i18n>SO_AM_PARTNER}';
    SO_AM_PARTNER_NAME              @title: '{i18n>SO_AM_PARTNER_NAME}'          @sap.Label: '{i18n>SO_AM_PARTNER_NAME}'  @Common.IsDigitSequence: true;
    SO_INCO1                        @title: '{i18n>SO_INCO1}'                    @sap.Label: '{i18n>SO_INCO1}';
    SO_INCO2                        @title: '{i18n>SO_INCO2}'                    @sap.Label: '{i18n>SO_INCO2}';
    SO_ZTERM                        @title: '{i18n>SO_ZTERM}'                    @sap.Label: '{i18n>SO_ZTERM}';
    SO_PRSDT                        @title: '{i18n>SO_PRSDT}'                    @sap.Label: '{i18n>SO_PRSDT}';
    SO_ZZ0S2REVG2                   @title: '{i18n>SO_ZZ0S2REVG2}'               @sap.Label: '{i18n>SO_ZZ0S2REVG2}';
    SO_ZZDKPPRODB                   @title: '{i18n>SO_ZZDKPPRODB}'               @sap.Label: '{i18n>SO_ZZDKPPRODB}';
    SO_BSARK_VTEXT                  @title: '{i18n>SO_BSARK_VTEXT}'              @sap.Label: '{i18n>SO_BSARK_VTEXT}';
    SO_BSARK                        @title: '{i18n>SO_BSARK}'                    @sap.Label: '{i18n>SO_BSARK}';
    DL_VBELN                        @title: '{i18n>DL_VBELN}'                    @sap.Label: '{i18n>DL_VBELN}';
    DL_POSNR                        @title: '{i18n>DL_POSNR}'                    @sap.Label: '{i18n>DL_POSNR}'            @Common.IsDigitSequence: true;
    DL_CHARG                        @title: '{i18n>DL_CHARG}'                    @sap.Label: '{i18n>DL_CHARG}';
    DL_LFIMG                        @title: '{i18n>DL_LFIMG}'                    @sap.Label: '{i18n>DL_LFIMG}';
    DL_VRKME                        @title: '{i18n>DL_VRKME}'                    @sap.Label: '{i18n>DL_VRKME}';
    DL_POSAR                        @title: '{i18n>DL_POSAR}'                    @sap.Label: '{i18n>DL_POSAR}';
    DL_VGBEL                        @title: '{i18n>DL_VGBEL}'                    @sap.Label: '{i18n>DL_VGBEL}';
    DL_VGPOS                        @title: '{i18n>DL_VGPOS}'                    @sap.Label: '{i18n>DL_VGPOS}'            @Common.IsDigitSequence: true;
    DL_LFART                        @title: '{i18n>DL_LFART}'                    @sap.Label: '{i18n>DL_LFART}';
    DL_LFART_VTEXT                  @title: '{i18n>DL_LFART_VTEXT}'              @sap.Label: '{i18n>DL_LFART_VTEXT}';
    DL_LFDAT                        @title: '{i18n>DL_LFDAT}'                    @sap.Label: '{i18n>DL_LFDAT}';
    DL_HSDAT                        @title: '{i18n>DL_HSDAT}'                    @sap.Label: '{i18n>DL_HSDAT}';
    DL_VFDAT                        @title: '{i18n>DL_VFDAT}'                    @sap.Label: '{i18n>DL_VFDAT}';
    DL_TRAID                        @title: '{i18n>DL_TRAID}'                    @sap.Label: '{i18n>DL_TRAID}';
    DL_ZZ0S2BLNR                    @title: '{i18n>DL_ZZ0S2BLNR}'                @sap.Label: '{i18n>DL_ZZ0S2BLNR}';
    DL_PEND_DEL_QUAN                @title: '{i18n>DL_PEND_DEL_QUAN}'            @sap.Label: '{i18n>DL_PEND_DEL_QUAN}';
    LAST_NOTE                       @title: '{i18n>LAST_NOTE}'                   @sap.Label: '{i18n>LAST_NOTE}';
    TM_TKNUM                        @title: '{i18n>TM_TKNUM}'                    @sap.Label: '{i18n>TM_TKNUM}';
    TM_VSART_BEZEI                  @title: '{i18n>TM_VSART_BEZEI}'              @sap.Label: '{i18n>TM_VSART_BEZEI}';
    TM_VSART                        @title: '{i18n>TM_VSART}'                    @sap.Label: '{i18n>TM_VSART}';
    TM_EXTI1                        @title: '{i18n>TM_EXTI1}'                    @sap.Label: '{i18n>TM_EXTI1}';
    TM_TDLNR                        @title: '{i18n>TM_TDLNR}'                    @sap.Label: '{i18n>TM_TDLNR}'            @Common.IsDigitSequence: true;
    TM_TDLNR_NAME1                  @title: '{i18n>TM_TDLNR_NAME1}'              @sap.Label: '{i18n>TM_TDLNR_NAME1}';
    TM_TRACKING_ID_COMP             @title: '{i18n>TM_TRACKING_ID_COMP}'         @sap.Label: '{i18n>TM_TRACKING_ID_COMP}';
    TM_TRACKING_ID_ELEM             @title: '{i18n>TM_TRACKING_ID_ELEM}'         @sap.Label: '{i18n>TM_TRACKING_ID_ELEM}';
    TM_DPTBG                        @title: '{i18n>TM_DPTBG}'                    @sap.Label: '{i18n>TM_DPTBG}';
    TM_DATBG                        @title: '{i18n>TM_DATBG}'                    @sap.Label: '{i18n>TM_DATBG}';
    TM_DPTEN                        @title: '{i18n>TM_DPTEN}'                    @sap.Label: '{i18n>TM_DPTEN}';
    TM_DALBG                        @title: '{i18n>TM_DALBG}'                    @sap.Label: '{i18n>TM_DALBG}';
    TM_DATEN                        @title: '{i18n>TM_DATEN}'                    @sap.Label: '{i18n>TM_DATEN}';
    TM_AR_DATE                      @title: '{i18n>TM_AR_DATE}'                  @sap.Label: '{i18n>TM_AR_DATE}';
    TM_STTRG                        @title: '{i18n>TM_STTRG}'                    @sap.Label: '{i18n>TM_STTRG}';
    TM_STTRG_DDTEXT                 @title: '{i18n>TM_STTRG_DDTEXT}'             @sap.Label: '{i18n>TM_STTRG_DDTEXT}';
    SO_BASF_LOFCR                   @title: '{i18n>SO_BASF_LOFCR}'               @sap.Label: '{i18n>SO_BASF_LOFCR}';
    SO_GUSCON_LEVEL                 @title: '{i18n>SO_GUSCON_LEVEL}'             @sap.Label: '{i18n>SO_GUSCON_LEVEL}'     @Common.IsDigitSequence: true;
    SO_I_VBELN                      @title: '{i18n>SO_I_VBELN}'                  @sap.Label: '{i18n>SO_I_VBELN}';
    SO_ISCOMPLETED                  @title: '{i18n>SO_ISCOMPLETED}'              @sap.Label: '{i18n>SO_ISCOMPLETED}';
    SO_LEVEL_TYPE                   @title: '{i18n>SO_LEVEL_TYPE}'               @sap.Label: '{i18n>SO_LEVEL_TYPE}';
    SO_N_VBELN                      @title: '{i18n>SO_N_VBELN}'                  @sap.Label: '{i18n>SO_N_VBELN}';
    SO_F_VBELN                      @title: '{i18n>SO_F_VBELN}'                  @sap.Label: '{i18n>SO_F_VBELN}';
    SO_F_POSNR                      @title: '{i18n>SO_F_POSNR}'                  @sap.Label: '{i18n>SO_F_POSNR}';
    SO_VBTYP                        @title: '{i18n>SO_VBTYP}'                    @sap.Label: '{i18n>SO_VBTYP}';
    SO_BSTKD                        @title: '{i18n>SO_BSTKD}'                    @sap.Label: '{i18n>SO_BSTKD}';
    BL_VBELN_INV_FIRST              @title: '{i18n>BL_VBELN_INV_FIRST}'          @sap.Label: '{i18n>BL_VBELN_INV_FIRST}'  @Common.IsDigitSequence: true;
    BL_POSNR_INV_FIRST              @title: '{i18n>BL_POSNR_INV_FIRST}'          @sap.Label: '{i18n>BL_POSNR_INV_FIRST}'  @Common.IsDigitSequence: true;
    BL_VBELN_INV_LAST               @title: '{i18n>BL_VBELN_INV_LAST}'           @sap.Label: '{i18n>BL_VBELN_INV_LAST}'   @Common.IsDigitSequence: true;
    BL_POSNR_INV_LAST               @title: '{i18n>BL_POSNR_INV_LAST}'           @sap.Label: '{i18n>BL_POSNR_INV_LAST}'   @Common.IsDigitSequence: true;
    BL_XBLNR                        @title: '{i18n>BL_XBLNR}'                    @sap.Label: '{i18n>BL_XBLNR}';
    BL_NETWR_LAST                   @title: '{i18n>BL_NETWR_LAST}'               @sap.Label: '{i18n>BL_NETWR_LAST}';
    BL_FKIMG_LAST                   @title: '{i18n>BL_FKIMG_LAST}'               @sap.Label: '{i18n>BL_FKIMG_LAST}';
    BL_ERDAT_FIRST                  @title: '{i18n>BL_ERDAT_FIRST}'              @sap.Label: '{i18n>BL_ERDAT_FIRST}';
    BL_ERDAT_LAST                   @title: '{i18n>BL_ERDAT_LAST}'               @sap.Label: '{i18n>BL_ERDAT_LAST}';
    BL_WAERK_LAST                   @title: '{i18n>BL_WAERK_LAST}'               @sap.Label: '{i18n>BL_WAERK_LAST}';
    BL_VRKME_LAST                   @title: '{i18n>BL_VRKME_LAST}'               @sap.Label: '{i18n>BL_VRKME_LAST}';
    SO_TRAGR                        @title: '{i18n>SO_TRAGR}'                    @sap.Label: '{i18n>SO_TRAGR}'            @Common.IsDigitSequence: true;
    SO_TRAGR_VTEXT                  @title: '{i18n>SO_TRAGR_VTEXT}'              @sap.Label: '{i18n>SO_TRAGR_VTEXT}';
    SO_VKGRP                        @title: '{i18n>SO_VKGRP}'                    @sap.Label: '{i18n>SO_VKGRP}';
    SO_VKGRP_BEZEI                  @title: '{i18n>SO_VKGRP_BEZEI}'              @sap.Label: '{i18n>SO_VKGRP_BEZEI}';
    SO_ROUTE                        @title: '{i18n>SO_ROUTE}'                    @sap.Label: '{i18n>SO_ROUTE}';
    DL_WADAT                        @title: '{i18n>DL_WADAT}'                    @sap.Label: '{i18n>DL_WADAT}';
    DL_WADAT_IST                    @title: '{i18n>DL_WADAT_IST}'                @sap.Label: '{i18n>DL_WADAT_IST}';
    TM_SHIPMENT_ALERT               @title: '{i18n>TM_SHIPMENT_ALERT}'           @sap.Label: '{i18n>TM_SHIPMENT_ALERT}';
    TM_SHIPMENT_CURRENT_STATUS      @title: '{i18n>TM_SHIPMENT_CURRENT_STATUS}'  @sap.Label: '{i18n>TM_SHIPMENT_CURRENT_STATUS}';
    SO_F_WERKS                      @title: '{i18n>SO_F_WERKS}'                  @sap.Label: '{i18n>SO_F_WERKS}';
    SO_F_VKORG                      @title: '{i18n>SO_F_VKORG}'                  @sap.Label: '{i18n>SO_F_VKORG}';
    SO_F_VKORG_VTEXT                @title: '{i18n>SO_F_VKORG_VTEXT}'            @sap.Label: '{i18n>SO_F_VKORG_VTEXT}';
    SO_F_TDDAT                      @title: '{i18n>SO_F_TDDAT}'                  @sap.Label: '{i18n>SO_F_TDDAT}';
    SO_F_ZZ0S2MATUG                 @title: '{i18n>SO_F_ZZ0S2MATUG}'             @sap.Label: '{i18n>SO_F_ZZ0S2MATUG}';
    SO_F_VSBED                      @title: '{i18n>SO_F_VSBED}'                  @sap.Label: '{i18n>SO_F_VSBED}';
    SO_F_VSBED_VTEXT                @title: '{i18n>SO_F_VSBED_VTEXT}'            @sap.Label: '{i18n>SO_F_VSBED_VTEXT}';
    SO_F_LDDAT                      @title: '{i18n>SO_F_LDDAT}'                  @sap.Label: '{i18n>SO_F_LDDAT}';
    SO_F_AUFNR                      @title: '{i18n>SO_F_AUFNR}'                  @sap.Label: '{i18n>SO_F_AUFNR}';
    SO_F_DGLTP                      @title: '{i18n>SO_F_DGLTP}'                  @sap.Label: '{i18n>SO_F_DGLTP}';
    SO_F_PSMNG                      @title: '{i18n>SO_F_PSMNG}'                  @sap.Label: '{i18n>SO_F_PSMNG}';
    SO_F_AMEIN                      @title: '{i18n>SO_F_AMEIN}'                  @sap.Label: '{i18n>SO_F_AMEIN}';
    SO_F_AS_PARTNER                 @title: '{i18n>SO_F_AS_PARTNER}'             @sap.Label: '{i18n>SO_F_AS_PARTNER}'     @Common.IsDigitSequence: true;
    SO_F_AS_PARTNER_NAME            @title: '{i18n>SO_F_AS_PARTNER_NAME}'        @sap.Label: '{i18n>SO_F_AS_PARTNER_NAME}';
    SO_DCP_ITEM_STATUS              @title: '{i18n>SO_DCP_ITEM_STATUS}'          @sap.Label: '{i18n>SO_DCP_ITEM_STATUS}';
    SO_DCP_ITEM_STATUS_DESCRIPTION  @title: '{i18n>SO_DCP_ITEM_STATUS}'          @sap.Label: '{i18n>SO_DCP_ITEM_STATUS}';
    DL_ERDAT                        @title: '{i18n>DL_ERDAT}'                    @sap.Label: '{i18n>DL_ERDAT}';
    DL_LDDAT                        @title: '{i18n>DL_LDDAT}'                    @sap.Label: '{i18n>DL_LDDAT}';
    SO_PERFK                        @title: '{i18n>SO_PERFK}'                    @sap.Label: '{i18n>SO_PERFK}';
    SO_PERFK_LTEXT_LANG             @title: '{i18n>SO_PERFK}'                    @sap.Label: '{i18n>SO_PERFK}';
    SO_F_MBDAT                      @title: '{i18n>SO_F_MBDAT}'                  @sap.Label: '{i18n>SO_F_MBDAT}';
    DL_POSNR_BATCH                  @title: '{i18n>DL_POSNR_BATCH}'              @sap.Label: '{i18n>DL_POSNR_BATCH}';
    DL_LFIMG_BATCH                  @title: '{i18n>DL_LFIMG_BATCH}'              @sap.Label: '{i18n>DL_LFIMG_BATCH}';
    PO_EBELN                        @title: '{i18n>PO_EBELN}'                    @sap.Label: '{i18n>PO_EBELN}'            @Common.IsDigitSequence: true;
    PO_EBELP                        @title: '{i18n>PO_EBELP}'                    @sap.Label: '{i18n>PO_EBELP}'            @Common.IsDigitSequence: true;
    PO_AEDAT_HEAD                   @title: '{i18n>PO_AEDAT_HEAD}'               @sap.Label: '{i18n>PO_AEDAT_HEAD}';
    PO_AEDAT_ITEM                   @title: '{i18n>PO_AEDAT_ITEM}'               @sap.Label: '{i18n>PO_AEDAT_ITEM}';
    PO_BSART                        @title: '{i18n>PO_BSART}'                    @sap.Label: '{i18n>PO_BSART}';
    PO_BSART_BATXT                  @title: '{i18n>PO_BSART_BATXT}'              @sap.Label: '{i18n>PO_BSART_BATXT}';
    PO_EKORG                        @title: '{i18n>PO_EKORG}'                    @sap.Label: '{i18n>PO_EKORG}';
    PO_EKOTX                        @title: '{i18n>PO_EKOTX}'                    @sap.Label: '{i18n>PO_EKOTX}';
    PO_EKGRP                        @title: '{i18n>PO_EKGRP}'                    @sap.Label: '{i18n>PO_EKGRP}';
    PO_EKNAM                        @title: '{i18n>PO_EKNAM}'                    @sap.Label: '{i18n>PO_EKNAM}';
    PO_EMATN                        @title: '{i18n>PO_EMATN}'                    @sap.Label: '{i18n>PO_EMATN}';
    PO_WERKS_PO                     @title: '{i18n>PO_WERKS_PO}'                 @sap.Label: '{i18n>PO_WERKS_PO}';
    PO_MENGE                        @title: '{i18n>PO_MENGE}'                    @sap.Label: '{i18n>PO_MENGE}';
    PO_MEINS                        @title: '{i18n>PO_MEINS}'                    @sap.Label: '{i18n>PO_MEINS}';
    PO_KUNNR                        @title: '{i18n>PO_KUNNR}'                    @sap.Label: '{i18n>PO_KUNNR}';
    PO_KUNNR_NAME                   @title: '{i18n>PO_KUNNR_NAME}'               @sap.Label: '{i18n>PO_KUNNR_NAME}';
    PO_PARTNER_9A_HEAD              @title: '{i18n>PO_PARTNER_9A_HEAD}'          @sap.Label: '{i18n>PO_PARTNER_9A_HEAD}';
    PO_PARTNER_9A_HEAD_NAME         @title: '{i18n>PO_PARTNER_9A_HEAD_NAME}'     @sap.Label: '{i18n>PO_PARTNER_9A_HEAD_NAME}';
    PO_PARTNER_9O_HEAD              @title: '{i18n>PO_PARTNER_9O_HEAD}'          @sap.Label: '{i18n>PO_PARTNER_9O_HEAD}';
    PO_PARTNER_9O_HEAD_NAME         @title: '{i18n>PO_PARTNER_9O_HEAD_NAME}'     @sap.Label: '{i18n>PO_PARTNER_9O_HEAD_NAME}';
    // SO_BSTNK         @title: '{i18n>SO_BSTNK}'     @sap.Label: '{i18n>SO_BSTNK}';
    /* EUAN CHANGES
    SO_Z5_PARTNER                   @title: '{i18n>SO_Z5_PARTNER}'               @sap.Label: '{i18n>SO_Z5_PARTNER}';
    SO_Z5_PARTNER_NAME              @title: '{i18n>SO_Z5_PARTNER_NAME}'          @sap.Label: '{i18n>SO_Z5_PARTNER_NAME}'  @Common.IsDigitSequence: true;
    SO_SB_PARTNER                   @title: '{i18n>SO_SB_PARTNER}'               @sap.Label: '{i18n>SO_SB_PARTNER}';
    SO_SB_PARTNER_NAME              @title: '{i18n>SO_SB_PARTNER_NAME}'          @sap.Label: '{i18n>SO_SB_PARTNER_NAME}'  @Common.IsDigitSequence: true;
    SO_AD_PARTNER                   @title: '{i18n>SO_AD_PARTNER}'               @sap.Label: '{i18n>SO_AD_PARTNER}';
    SO_AD_PARTNER_NAME              @title: '{i18n>SO_AD_PARTNER_NAME}'          @sap.Label: '{i18n>SO_AD_PARTNER_NAME}'  @Common.IsDigitSequence: true;
    */
    ///// Mandants
    SO_MANDT                        @title: '{i18n>SO_MANDT}'                    @sap.Label: '{i18n>SO_MANDT}';
    DL_MANDT                        @title: '{i18n>DL_MANDT}'                    @sap.Label: '{i18n>DL_MANDT}';
    TM_MANDT                        @title: '{i18n>TM_MANDT}'                    @sap.Label: '{i18n>TM_MANDT}';
    BL_MANDT_INV_FIRST              @title: '{i18n>BL_MANDT_INV_FIRST}'          @sap.Label: '{i18n>BL_MANDT_INV_FIRST}';
    BL_MANDT_INV_LAST               @title: '{i18n>BL_MANDT_INV_LAST}'           @sap.Label: '{i18n>BL_MANDT_INV_LAST}';
    SO_FIRST_SO_MANDT               @title: '{i18n>SO_FIRST_SO_MANDT}'           @sap.Label: '{i18n>SO_FIRST_SO_MANDT}';
    SO_FINAL_SO_MANDT               @title: '{i18n>SO_FINAL_SO_MANDT}'           @sap.Label: '{i18n>SO_FINAL_SO_MANDT}';
    PO_MANDT                        @title: '{i18n>PO_MANDT}'                    @sap.Label: '{i18n>PO_MANDT}';
    SO_MANDT_TEXT                   @title: '{i18n>SO_MANDT}'                    @sap.Label: '{i18n>SO_MANDT}';
    DL_MANDT_TEXT                   @title: '{i18n>DL_MANDT}'                    @sap.Label: '{i18n>DL_MANDT}';
    TM_MANDT_TEXT                   @title: '{i18n>TM_MANDT}'                    @sap.Label: '{i18n>TM_MANDT}';
    BL_MANDT_INV_FIRST_TEXT         @title: '{i18n>BL_MANDT_INV_FIRST}'          @sap.Label: '{i18n>BL_MANDT_INV_FIRST}';
    BL_MANDT_INV_LAST_TEXT          @title: '{i18n>BL_MANDT_INV_LAST}'           @sap.Label: '{i18n>BL_MANDT_INV_LAST}';
    SO_FIRST_SO_MANDT_TEXT          @title: '{i18n>SO_FIRST_SO_MANDT}'           @sap.Label: '{i18n>SO_FIRST_SO_MANDT}';
    SO_FINAL_SO_MANDT_TEXT          @title: '{i18n>SO_FINAL_SO_MANDT}'           @sap.Label: '{i18n>SO_FINAL_SO_MANDT}';
    PO_MANDT_TEXT                   @title: '{i18n>PO_MANDT}'                    @sap.Label: '{i18n>PO_MANDT}';  
    DL_TRMTYP                       @title: '{i18n>DL_TRMTYP}'                   @sap.Label: '{i18n>DL_TRMTYP}'  @Common.IsDigitSequence: true;
    DL_TRMTYP_MAKTX                 @title: '{i18n>DL_TRMTYP_MAKTX_LANG}'        @sap.Label: '{i18n>DL_TRMTYP_MAKTX_LANG}';
    DL_ZZ0S2ABGH                    @title: '{i18n>DL_ZZ0S2ABGH}'                @sap.Label: '{i18n>DL_ZZ0S2ABGH}';
    DL_ZZ0S2ZIEH                    @title: '{i18n>DL_ZZ0S2ZIEH}'                @sap.Label: '{i18n>DL_ZZ0S2ZIEH}';
    TM_VISTA_STATUS                 @title: '{i18n>TM_VISTA_STATUS}'             @sap.Label: '{i18n>TM_VISTA_STATUS}';
};

annotate service.Results with {
    @Common.Text           : SO_LANDX
    @Common.TextArrangement: #TextLast
    SO_LAND1;
    @Common.TextFor
    SO_LANDX;
    SO_VBELN                    @title: '{i18n>SO_VBELN}'                    @sap.Label: '{i18n>SO_VBELN}';
    SO_POSNR                    @title: '{i18n>SO_POSNR}'                    @sap.Label: '{i18n>SO_POSNR}';
    SO_ERDAT_ORDER              @title: '{i18n>SO_ERDAT_ORDER}'              @sap.Label: '{i18n>SO_ERDAT_ORDER}';
    SO_ERDAT_ITEM               @title: '{i18n>SO_ERDAT_ITEM}'               @sap.Label: '{i18n>SO_ERDAT_ITEM}';
    SO_AUART                    @title: '{i18n>SO_AUART}'                    @sap.Label: '{i18n>SO_AUART}';
    SO_WERKS                    @title: '{i18n>SO_WERKS}'                    @sap.Label: '{i18n>SO_WERKS}';
    SO_VTWEG                    @title: '{i18n>SO_VTWEG}'                    @sap.Label: '{i18n>SO_VTWEG}';
    @Common.Text           : SO_MAKTX
    @Common.TextArrangement: #TextLast
    SO_MATNR                    @title: '{i18n>SO_MAKTX}'                    @sap.Label: '{i18n>SO_MATNR}';
    @Common.TextFor
    SO_MAKTX;
    SO_KDMAT                    @title: '{i18n>SO_KDMAT}'                    @sap.Label: '{i18n>SO_KDMAT}';
    @Common.Text           : SO_AG_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_AG_PARTNER               @title: '{i18n>SO_AG_PARTNER_NAME}'          @sap.Label: '{i18n>SO_AG_PARTNER}';
    @Common.TextFor
    SO_AG_PARTNER_NAME;
    @Common.Text           : SO_WE_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_WE_PARTNER               @title: '{i18n>SO_WE_PARTNER_NAME}'          @sap.Label: '{i18n>SO_WE_PARTNER}';
    @Common.TextFor
    SO_WE_PARTNER_NAME;
    SO_LAND1                    @title: '{i18n>SO_LAND1}'                    @sap.Label: '{i18n>SO_LAND1}';
    SO_LANDX                    @title: '{i18n>SO_LANDX}'                    @sap.Label: '{i18n>SO_LANDX}';
    SO_ORT01                    @title: '{i18n>SO_ORT01}'                    @sap.Label: '{i18n>SO_ORT01}';
    @Common.Text           : SO_VKORG_NAME1
    @Common.TextArrangement: #TextLast
    SO_VKORG                    @title: '{i18n>SO_VKORG_NAME1}'              @sap.Label: '{i18n>SO_VKORG}';
    @Common.TextFor
    SO_VKORG_NAME1;
    SO_KNREF_HEAD               @title: '{i18n>SO_KNREF_HEAD}'               @sap.Label: '{i18n>SO_KNREF_HEAD}';
    SO_VBUND                    @title: '{i18n>SO_VBUND}'                    @sap.Label: '{i18n>SO_VBUND}';
    SO_EDATU_REQUESTED          @title: '{i18n>SO_EDATU_REQUESTED}'          @sap.Label: '{i18n>SO_EDATU_REQUESTED}';
    SO_KWMENG                   @title: '{i18n>SO_KWMENG}'                   @sap.Label: '{i18n>SO_KWMENG}';
    SO_VRKME                    @title: '{i18n>SO_VRKME}'                    @sap.Label: '{i18n>SO_VRKME}';
    SO_EDATU_CONFIRMED          @title: '{i18n>SO_EDATU_CONFIRMED}'          @sap.Label: '{i18n>SO_EDATU_CONFIRMED}';
    SO_KBMENG                   @title: '{i18n>SO_KBMENG}'                   @sap.Label: '{i18n>SO_KBMENG}';
    SO_F_LDDAT                  @title: '{i18n>SO_F_LDDAT}'                  @sap.Label: '{i18n>SO_F_LDDAT}';
    SO_UNCONFIRMED_QTY          @title: '{i18n>SO_UNCONFIRMED_QTY}'          @sap.Label: '{i18n>SO_UNCONFIRMED_QTY}';
    SO_REQ_TEXT                 @title: '{i18n>SO_REQ_TEXT}'                 @sap.Label: '{i18n>SO_REQ_TEXT}';
    @Common.Text           : SO_FAKSP_VTEXT
    @Common.TextArrangement: #TextLast
    SO_FAKSP                    @title: '{i18n>SO_FAKSP}'                    @sap.Label: '{i18n>SO_FAKSP}';
    @Common.TextFor
    SO_FAKSP_VTEXT              @title: '{i18n>SO_FAKSP_VTEXT}'              @sap.Label: '{i18n>SO_FAKSP_VTEXT}';
    SO_F_LGORT                  @title: '{i18n>SO_LGORT}'                    @sap.Label: '{i18n>SO_LGORT}';
    @Common.Text           : SO_SUPPLY_SITUATION_DESCR
    @Common.TextArrangement: #TextLast
    SO_SUPPLY_SITUATION         @title: '{i18n>SO_SUPPLY_SITUATION}'         @sap.Label: '{i18n>SO_SUPPLY_SITUATION}';
    @Common.TextFor
    SO_SUPPLY_SITUATION_DESCR   @title: '{i18n>SO_SUPPLY_SITUATION_DESCR}'   @sap.Label: '{i18n>SO_SUPPLY_SITUATION_DESCR}';
    SO_KBETR                    @title: '{i18n>SO_KBETR}'                    @sap.Label: '{i18n>SO_KBETR}';
    SO_WAERS                    @title: '{i18n>SO_WAERS}'                    @sap.Label: '{i18n>SO_WAERS}';
    SO_KPEIN                    @title: '{i18n>SO_KPEIN}'                    @sap.Label: '{i18n>SO_KPEIN}';
    SO_KMEIN                    @title: '{i18n>SO_KMEIN}'                    @sap.Label: '{i18n>SO_KMEIN}';
    SO_NETWR                    @title: '{i18n>SO_NETWR}'                    @sap.Label: '{i18n>SO_NETWR}';
    SO_WAERK                    @title: '{i18n>SO_WAERK}'                    @sap.Label: '{i18n>SO_WAERK}';
    SO_HTEXT                    @title: '{i18n>SO_HTEXT}'                    @sap.Label: '{i18n>SO_HTEXT}';
    @Common.Text           : SO_PSTYV_VTEXT
    @Common.TextArrangement: #TextLast
    SO_PSTYV                    @title: '{i18n>SO_PSTYV}'                    @sap.Label: '{i18n>SO_PSTYV}';
    @Common.TextFor
    SO_PSTYV_VTEXT              @title: '{i18n>SO_PSTYV_VTEXT}'              @sap.Label: '{i18n>SO_PSTYV_VTEXT}';
    SO_DISPO                    @title: '{i18n>SO_DISPO}'                    @sap.Label: '{i18n>SO_DISPO}';
    SO_KOSCH                    @title: '{i18n>SO_KOSCH}'                    @sap.Label: '{i18n>SO_KOSCH}';
    @Common.Text           : SO_VKBUR_BEZEI
    @Common.TextArrangement: #TextLast
    SO_VKBUR                    @title: '{i18n>SO_VKBUR}'                    @sap.Label: '{i18n>SO_VKBUR}';
    @Common.TextFor
    SO_VKBUR_BEZEI              @title: '{i18n>SO_VKBUR_BEZEI}'              @sap.Label: '{i18n>SO_VKBUR_BEZEI}';
    SO_ABGRU                    @title: '{i18n>SO_ABGRU}'                    @sap.Label: '{i18n>SO_ABGRU}';
    SO_ABSTA                    @title: '{i18n>SO_ABSTA}'                    @sap.Label: '{i18n>SO_ABSTA}';
    SO_KNUMV                    @title: '{i18n>SO_KNUMV}'                    @sap.Label: '{i18n>SO_KNUMV}';
    SO_SPART                    @title: '{i18n>SO_SPART}'                    @sap.Label: '{i18n>SO_SPART}';
    @Common.Text           : SO_CO_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_CO_PARTNER               @title: '{i18n>SO_CO_PARTNER}'               @sap.Label: '{i18n>SO_CO_PARTNER}';
    @Common.TextFor
    SO_CO_PARTNER_NAME          @title: '{i18n>SO_CO_PARTNER_NAME}'          @sap.Label: '{i18n>SO_CO_PARTNER_NAME}';
    @Common.Text           : SO_NY_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_NY_PARTNER               @title: '{i18n>SO_NY_PARTNER}'               @sap.Label: '{i18n>SO_NY_PARTNER}';
    @Common.TextFor
    SO_NY_PARTNER_NAME          @title: '{i18n>SO_NY_PARTNER_NAME}'          @sap.Label: '{i18n>SO_NY_PARTNER_NAME}';
    @Common.Text           : SO_AS_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_AS_PARTNER               @title: '{i18n>SO_AS_PARTNER}'               @sap.Label: '{i18n>SO_AS_PARTNER}';
    @Common.TextFor
    SO_AS_PARTNER_NAME          @title: '{i18n>SO_AS_PARTNER_NAME}'          @sap.Label: '{i18n>SO_AS_PARTNER_NAME}';
    @Common.Text           : SO_VE_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_VE_PARTNER               @title: '{i18n>SO_VE_PARTNER}'               @sap.Label: '{i18n>SO_VE_PARTNER}';
    @Common.TextFor
    SO_VE_PARTNER_NAME          @title: '{i18n>SO_VE_PARTNER_NAME}'          @sap.Label: '{i18n>SO_VE_PARTNER_NAME}';
    @Common.Text           : SO_AM_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_AM_PARTNER               @title: '{i18n>SO_AM_PARTNER}'               @sap.Label: '{i18n>SO_AM_PARTNER}';
    @Common.TextFor
    SO_AM_PARTNER_NAME          @title: '{i18n>SO_AM_PARTNER_NAME}'          @sap.Label: '{i18n>SO_AM_PARTNER_NAME}';
    SO_INCO1                    @title: '{i18n>SO_INCO1}'                    @sap.Label: '{i18n>SO_INCO1}';
    SO_INCO2                    @title: '{i18n>SO_INCO2}'                    @sap.Label: '{i18n>SO_INCO2}';
    SO_ZTERM                    @title: '{i18n>SO_ZTERM}'                    @sap.Label: '{i18n>SO_ZTERM}';
    SO_PRSDT                    @title: '{i18n>SO_PRSDT}'                    @sap.Label: '{i18n>SO_PRSDT}';
    SO_ZZ0S2REVG2               @title: '{i18n>SO_ZZ0S2REVG2}'               @sap.Label: '{i18n>SO_ZZ0S2REVG2}';
    SO_ZZDKPPRODB               @title: '{i18n>SO_ZZDKPPRODB}'               @sap.Label: '{i18n>SO_ZZDKPPRODB}';
    @Common.TextFor
    SO_BSARK_VTEXT;
    @Common.Text           : SO_BSARK_VTEXT
    @Common.TextArrangement: #TextLast
    SO_BSARK                    @title: '{i18n>SO_BSARK}'                    @sap.Label: '{i18n>SO_BSARK}';
    DL_VBELN                    @title: '{i18n>DL_VBELN}'                    @sap.Label: '{i18n>DL_VBELN}';
    DL_POSNR                    @title: '{i18n>DL_POSNR}'                    @sap.Label: '{i18n>DL_POSNR}';
    DL_CHARG                    @title: '{i18n>DL_CHARG}'                    @sap.Label: '{i18n>DL_CHARG}';
    DL_LFIMG                    @title: '{i18n>DL_LFIMG}'                    @sap.Label: '{i18n>DL_LFIMG}';
    DL_VRKME                    @title: '{i18n>DL_VRKME}'                    @sap.Label: '{i18n>DL_VRKME}';
    DL_POSAR                    @title: '{i18n>DL_POSAR}'                    @sap.Label: '{i18n>DL_POSAR}';
    DL_VGBEL                    @title: '{i18n>DL_VGBEL}'                    @sap.Label: '{i18n>DL_VGBEL}';
    DL_VGPOS                    @title: '{i18n>DL_VGPOS}'                    @sap.Label: '{i18n>DL_VGPOS}';
    @Common.Text           : DL_LFART_VTEXT
    @Common.TextArrangement: #TextLast
    DL_LFART                    @title: '{i18n>DL_LFART}'                    @sap.Label: '{i18n>DL_LFART}';
    @Common.TextFor
    DL_LFART_VTEXT              @title: '{i18n>DL_LFART_VTEXT}'              @sap.Label: '{i18n>DL_LFART_VTEXT}';
    DL_LFDAT                    @title: '{i18n>DL_LFDAT}'                    @sap.Label: '{i18n>DL_LFDAT}';
    DL_HSDAT                    @title: '{i18n>DL_HSDAT}'                    @sap.Label: '{i18n>DL_HSDAT}';
    DL_VFDAT                    @title: '{i18n>DL_VFDAT}'                    @sap.Label: '{i18n>DL_VFDAT}';
    DL_TRAID                    @title: '{i18n>DL_TRAID}'                    @sap.Label: '{i18n>DL_TRAID}';
    DL_ZZ0S2BLNR                @title: '{i18n>DL_ZZ0S2BLNR}'                @sap.Label: '{i18n>DL_ZZ0S2BLNR}';
    DL_PEND_DEL_QUAN            @title: '{i18n>DL_PEND_DEL_QUAN}'            @sap.Label: '{i18n>DL_PEND_DEL_QUAN}';
    LAST_NOTE                   @title: '{i18n>LAST_NOTE}'                   @sap.Label: '{i18n>LAST_NOTE}';
    USERNAME                    @title: '{i18n>USERNAME}'                    @sap.Label: '{i18n>USERNAME}';
    TM_TKNUM                    @title: '{i18n>TM_TKNUM}'                    @sap.Label: '{i18n>TM_TKNUM}';
    @Common.TextFor
    TM_VSART_BEZEI;
    @Common.Text           : TM_VSART_BEZEI
    @Common.TextArrangement: #TextLast
    TM_VSART                    @title: '{i18n>TM_VSART}'                    @sap.Label: '{i18n>TM_VSART}';
    TM_EXTI1                    @title: '{i18n>TM_EXTI1}'                    @sap.Label: '{i18n>TM_EXTI1}';
    @Common.Text           : TM_TDLNR_NAME1
    @Common.TextArrangement: #TextLast
    TM_TDLNR                    @title: '{i18n>TM_TDLNR}'                    @sap.Label: '{i18n>TM_TDLNR}';
    @Common.TextFor
    TM_TDLNR_NAME1;
    TM_TRACKING_ID_COMP         @title: '{i18n>TM_TRACKING_ID_COMP}'         @sap.Label: '{i18n>TM_TRACKING_ID_COMP}';
    TM_TRACKING_ID_ELEM         @title: '{i18n>TM_TRACKING_ID_ELEM}'         @sap.Label: '{i18n>TM_TRACKING_ID_ELEM}';
    TM_DPTBG                    @title: '{i18n>TM_DPTBG}'                    @sap.Label: '{i18n>TM_DPTBG}';
    TM_DATBG                    @title: '{i18n>TM_DATBG}'                    @sap.Label: '{i18n>TM_DATBG}';
    TM_DPTEN                    @title: '{i18n>TM_DPTEN}'                    @sap.Label: '{i18n>TM_DPTEN}';
    TM_DALBG                    @title: '{i18n>TM_DALBG}'                    @sap.Label: '{i18n>TM_DALBG}';
    TM_DATEN                    @title: '{i18n>TM_DATEN}'                    @sap.Label: '{i18n>TM_DATEN}';
    TM_AR_DATE                  @title: '{i18n>TM_AR_DATE}'                  @sap.Label: '{i18n>TM_AR_DATE}';
    @Common.Text           : TM_STTRG_DDTEXT
    @Common.TextArrangement: #TextLast
    TM_STTRG                    @title: '{i18n>TM_STTRG}'                    @sap.Label: '{i18n>TM_STTRG}';
    @Common.TextFor
    TM_STTRG_DDTEXT;
    SO_BASF_LOFCR               @title: '{i18n>SO_BASF_LOFCR}'               @sap.Label: '{i18n>SO_BASF_LOFCR}';
    SO_GUSCON_LEVEL             @title: '{i18n>SO_GUSCON_LEVEL}'             @sap.Label: '{i18n>SO_GUSCON_LEVEL}';
    SO_I_VBELN                  @title: '{i18n>SO_I_VBELN}'                  @sap.Label: '{i18n>SO_I_VBELN}';
    SO_ISCOMPLETED              @title: '{i18n>SO_ISCOMPLETED}'              @sap.Label: '{i18n>SO_ISCOMPLETED}';
    SO_LEVEL_TYPE               @title: '{i18n>SO_LEVEL_TYPE}'               @sap.Label: '{i18n>SO_LEVEL_TYPE}';
    SO_N_VBELN                  @title: '{i18n>SO_N_VBELN}'                  @sap.Label: '{i18n>SO_N_VBELN}';
    SO_F_VBELN                  @title: '{i18n>SO_F_VBELN}'                  @sap.Label: '{i18n>SO_F_VBELN}';
    SO_F_POSNR                  @title: '{i18n>SO_F_POSNR}'                  @sap.Label: '{i18n>SO_F_POSNR}';
    SO_VBTYP                    @title: '{i18n>SO_VBTYP}'                    @sap.Label: '{i18n>SO_VBTYP}';
    SO_BSTKD                    @title: '{i18n>SO_BSTKD}'                    @sap.Label: '{i18n>SO_BSTKD}';
    BL_VBELN_INV_FIRST          @title: '{i18n>BL_VBELN_INV_FIRST}'          @sap.Label: '{i18n>BL_VBELN_INV_FIRST}';
    BL_POSNR_INV_FIRST          @title: '{i18n>BL_POSNR_INV_FIRST}'          @sap.Label: '{i18n>BL_POSNR_INV_FIRST}';
    BL_VBELN_INV_LAST           @title: '{i18n>BL_VBELN_INV_LAST}'           @sap.Label: '{i18n>BL_VBELN_INV_LAST}';
    BL_POSNR_INV_LAST           @title: '{i18n>BL_POSNR_INV_LAST}'           @sap.Label: '{i18n>BL_POSNR_INV_LAST}';
    BL_NETWR_LAST               @title: '{i18n>BL_NETWR_LAST}'               @sap.Label: '{i18n>BL_NETWR_LAST}';
    BL_FKIMG_LAST               @title: '{i18n>BL_FKIMG_LAST}'               @sap.Label: '{i18n>BL_FKIMG_LAST}';
    BL_ERDAT_FIRST              @title: '{i18n>BL_ERDAT_FIRST}'              @sap.Label: '{i18n>BL_ERDAT_FIRST}';
    BL_ERDAT_LAST               @title: '{i18n>BL_ERDAT_LAST}'               @sap.Label: '{i18n>BL_ERDAT_LAST}';
    BL_VRKME_LAST               @title: '{i18n>BL_VRKME_LAST}'               @sap.Label: '{i18n>BL_VRKME_LAST}';
    BL_WAERK_LAST               @title: '{i18n>BL_WAERK_LAST}'               @sap.Label: '{i18n>BL_WAERK_LAST}';

    BL_XBLNR                    @title: '{i18n>BL_XBLNR}'                    @sap.Label: '{i18n>BL_XBLNR}';
    @Common.Text           : SO_TRAGR_VTEXT
    @Common.TextArrangement: #TextLast
    SO_TRAGR                    @title: '{i18n>SO_TRAGR}'                    @sap.Label: '{i18n>SO_TRAGR}';
    @Common.TextFor
    SO_TRAGR_VTEXT;
    @Common.Text           : SO_VKGRP_BEZEI
    @Common.TextArrangement: #TextLast
    SO_VKGRP                    @title: '{i18n>SO_VKGRP}'                    @sap.Label: '{i18n>SO_VKGRP}';
    @Common.TextFor
    SO_VKGRP_BEZEI;
    SO_ROUTE                    @title: '{i18n>SO_ROUTE}'                    @sap.Label: '{i18n>SO_ROUTE}';
    SO_F_TDDAT                  @title: '{i18n>SO_F_TDDAT}'                  @sap.Label: '{i18n>SO_F_TDDAT}';
    SO_F_ZZ0S2MATUG             @title: '{i18n>SO_F_ZZ0S2MATUG}'             @sap.Label: '{i18n>SO_F_ZZ0S2MATUG}';
    @Common.Text           : SO_F_VSBED_VTEXT
    @Common.TextArrangement: #TextLast
    SO_F_VSBED                  @title: '{i18n>SO_F_VSBED}'                  @sap.Label: '{i18n>SO_TRAGR}';
    @Common.TextFor
    SO_F_VSBED_VTEXT;
    DL_WADAT                    @title: '{i18n>DL_WADAT}'                    @sap.Label: '{i18n>DL_WADAT}';
    DL_WADAT_IST                @title: '{i18n>DL_WADAT_IST}'                @sap.Label: '{i18n>DL_WADAT_IST}';
    TM_SHIPMENT_ALERT           @title: '{i18n>TM_SHIPMENT_ALERT}'           @sap.Label: '{i18n>TM_SHIPMENT_ALERT}';
    TM_SHIPMENT_CURRENT_STATUS  @title: '{i18n>TM_SHIPMENT_CURRENT_STATUS}'  @sap.Label: '{i18n>TM_SHIPMENT_CURRENT_STATUS}';
    SO_F_WERKS                  @title: '{i18n>SO_F_WERKS}'                  @sap.Label: '{i18n>SO_F_WERKS}';
    @Common.Text           : SO_F_VKORG_VTEXT
    @Common.TextArrangement: #TextLast
    SO_F_VKORG                  @title: '{i18n>SO_F_VKORG}'                  @sap.Label: '{i18n>SO_F_VKORG}';
    @Common.TextFor
    SO_F_VKORG_VTEXT;
    SO_F_AUFNR                  @title: '{i18n>SO_F_AUFNR}'                  @sap.Label: '{i18n>SO_F_AUFNR}';
    SO_F_DGLTP                  @title: '{i18n>SO_F_DGLTP}'                  @sap.Label: '{i18n>SO_F_DGLTP}';
    SO_F_PSMNG                  @title: '{i18n>SO_F_PSMNG}'                  @sap.Label: '{i18n>SO_F_PSMNG}';
    SO_F_AMEIN                  @title: '{i18n>SO_F_AMEIN}'                  @sap.Label: '{i18n>SO_F_AMEIN}';
    @Common.Text           : SO_F_AS_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_F_AS_PARTNER             @title: '{i18n>SO_F_AS_PARTNER}'             @sap.Label: '{i18n>SO_F_AS_PARTNER}';
    @Common.TextFor
    SO_F_AS_PARTNER_NAME        @title: '{i18n>SO_F_AS_PARTNER_NAME}'        @sap.Label: '{i18n>SO_F_AS_PARTNER_NAME}';
    @Common.Text           : SO_ABGRU_BEZEI
    @Common.TextArrangement: #TextLast
    SO_ABGRU;
    @Common.TextFor
    SO_ABGRU_BEZEI;
    @Common.Text           : SO_DCP_ITEM_STATUS_DESCRIPTION
    @Common.TextArrangement: #TextLast
    SO_DCP_ITEM_STATUS          @title: '{i18n>SO_DCP_ITEM_STATUS}'          @sap.Label: '{i18n>SO_DCP_ITEM_STATUS}';
    @Common.TextFor
    SO_DCP_ITEM_STATUS_DESCRIPTION;
    DL_ERDAT                    @title: '{i18n>DL_ERDAT}'                    @sap.Label: '{i18n>DL_ERDAT}';
    DL_LDDAT                    @title: '{i18n>DL_LDDAT}'                    @sap.Label: '{i18n>DL_LDDAT}';
    SO_F_MBDAT                  @title: '{i18n>SO_F_MBDAT}'                  @sap.Label: '{i18n>SO_F_MBDAT}';

    @Common.Text           : SO_PERFK_LTEXT_LANG
    @Common.TextArrangement: #TextLast
    SO_PERFK                    @title: '{i18n>SO_PERFK}'                    @sap.Label: '{i18n>SO_PERFK}';
    @Common.TextFor
    SO_PERFK_LTEXT_LANG;
    DL_POSNR_BATCH              @title: '{i18n>DL_POSNR_BATCH}'              @sap.Label: '{i18n>DL_POSNR_BATCH}';
    DL_LFIMG_BATCH              @title: '{i18n>DL_LFIMG_BATCH}'              @sap.Label: '{i18n>DL_LFIMG_BATCH}';
    PO_EBELN                    @title: '{i18n>PO_EBELN}'                    @sap.Label: '{i18n>PO_EBELN}';
    PO_EBELP                    @title: '{i18n>PO_EBELP}'                    @sap.Label: '{i18n>PO_EBELP}';
    PO_AEDAT_HEAD               @title: '{i18n>PO_AEDAT_HEAD}'               @sap.Label: '{i18n>PO_AEDAT_HEAD}';
    PO_AEDAT_ITEM               @title: '{i18n>PO_AEDAT_ITEM}'               @sap.Label: '{i18n>PO_AEDAT_ITEM}';
    @Common.Text           : PO_EKOTX
    @Common.TextArrangement: #TextLast
    PO_EKORG                    @title: '{i18n>PO_EKORG}'                    @sap.Label: '{i18n>PO_EKORG}';
    @Common.TextFor
    PO_EKOTX;
    @Common.Text           : PO_EKNAM
    @Common.TextArrangement: #TextLast
    PO_EKGRP                    @title: '{i18n>PO_EKGRP}'                    @sap.Label: '{i18n>PO_EKGRP}';
    @Common.TextFor
    PO_EKNAM;
    PO_EMATN                    @title: '{i18n>PO_EMATN}'                    @sap.Label: '{i18n>PO_EMATN}';
    PO_WERKS_PO                 @title: '{i18n>PO_WERKS_PO}'                 @sap.Label: '{i18n>PO_WERKS_PO}';
    PO_MENGE                    @title: '{i18n>PO_MENGE}'                    @sap.Label: '{i18n>PO_MENGE}';
    PO_MEINS                    @title: '{i18n>PO_MEINS}'                    @sap.Label: '{i18n>PO_MEINS}';
    @Common.Text           : PO_KUNNR_NAME
    @Common.TextArrangement: #TextLast
    PO_KUNNR                    @title: '{i18n>PO_KUNNR}'                    @sap.Label: '{i18n>PO_KUNNR}';
    @Common.TextFor
    PO_KUNNR_NAME;
    @Common.Text           : PO_PARTNER_9A_HEAD_NAME
    @Common.TextArrangement: #TextLast
    PO_PARTNER_9A_HEAD          @title: '{i18n>PO_PARTNER_9A_HEAD}'          @sap.Label: '{i18n>PO_PARTNER_9A_HEAD}';
    @Common.TextFor
    PO_PARTNER_9A_HEAD_NAME;
    @Common.Text           : PO_PARTNER_9O_HEAD_NAME
    @Common.TextArrangement: #TextLast
    PO_PARTNER_9O_HEAD          @title: '{i18n>PO_PARTNER_9O_HEAD}'          @sap.Label: '{i18n>PO_PARTNER_9O_HEAD}';
    @Common.TextFor
    PO_PARTNER_9O_HEAD_NAME;
    @Common.Text           : PO_BSART_BATXT
    @Common.TextArrangement: #TextLast
    PO_BSART                    @title: '{i18n>PO_BSART}'                    @sap.Label: '{i18n>PO_BSART}';
    @Common.TextFor
    PO_BSART_BATXT;
    // SO_BSTNK         @title: '{i18n>SO_BSTNK}'     @sap.Label: '{i18n>SO_BSTNK}';
    /* Euans changes
    @Common.Text           : SO_Z5_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_Z5_PARTNER               @title: '{i18n>SO_Z5_PARTNER}'               @sap.Label: '{i18n>SO_Z5_PARTNER}';
    @Common.TextFor
    SO_Z5_PARTNER_NAME          @title: '{i18n>SO_Z5_PARTNER_NAME}'          @sap.Label: '{i18n>SO_Z5_PARTNER_NAME}';

    @Common.Text           : SO_SB_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_SB_PARTNER               @title: '{i18n>SO_SB_PARTNER}'               @sap.Label: '{i18n>SO_SB_PARTNER}';
    @Common.TextFor
    SO_SB_PARTNER_NAME          @title: '{i18n>SO_SB_PARTNER_NAME}'          @sap.Label: '{i18n>SO_SB_PARTNER_NAME}';

    @Common.Text           : SO_AD_PARTNER_NAME
    @Common.TextArrangement: #TextLast
    SO_AD_PARTNER               @title: '{i18n>SO_AD_PARTNER}'               @sap.Label: '{i18n>SO_AD_PARTNER}';
    @Common.TextFor
    SO_AD_PARTNER_NAME          @title: '{i18n>SO_AD_PARTNER_NAME}'          @sap.Label: '{i18n>SO_AD_PARTNER_NAME}';

    */

    ///// Mandants
    @Common.Text           : SO_MANDT_TEXT
    @Common.TextArrangement: #TextLast
    SO_MANDT                    @title: '{i18n>SO_MANDT}'                    @sap.Label: '{i18n>SO_MANDT}';
    @Common.TextFor
    SO_MANDT_TEXT;

    @Common.Text           : DL_MANDT_TEXT
    @Common.TextArrangement: #TextLast
    DL_MANDT                    @title: '{i18n>DL_MANDT}'                    @sap.Label: '{i18n>DL_MANDT}';
    @Common.TextFor
    DL_MANDT_TEXT;

    @Common.Text           : TM_MANDT_TEXT
    @Common.TextArrangement: #TextLast
    TM_MANDT                    @title: '{i18n>TM_MANDT}'                    @sap.Label: '{i18n>TM_MANDT}';
    @Common.TextFor
    TM_MANDT_TEXT;

    @Common.Text           : BL_MANDT_INV_FIRST_TEXT
    @Common.TextArrangement: #TextLast
    BL_MANDT_INV_FIRST          @title: '{i18n>BL_MANDT_INV_FIRST}'          @sap.Label: '{i18n>BL_MANDT_INV_FIRST}';
    @Common.TextFor
    BL_MANDT_INV_FIRST_TEXT;

    @Common.Text           : BL_MANDT_INV_LAST_TEXT
    @Common.TextArrangement: #TextLast
    BL_MANDT_INV_LAST           @title: '{i18n>BL_MANDT_INV_LAST}'           @sap.Label: '{i18n>BL_MANDT_INV_LAST}';
    @Common.TextFor
    BL_MANDT_INV_LAST_TEXT;

    @Common.Text           : SO_FIRST_SO_MANDT_TEXT
    @Common.TextArrangement: #TextLast
    SO_FIRST_SO_MANDT           @title: '{i18n>SO_FIRST_SO_MANDT}'           @sap.Label: '{i18n>SO_FIRST_SO_MANDT}';
    @Common.TextFor
    SO_FIRST_SO_MANDT_TEXT;

    @Common.Text           : SO_FINAL_SO_MANDT_TEXT
    @Common.TextArrangement: #TextLast
    SO_FINAL_SO_MANDT           @title: '{i18n>SO_FINAL_SO_MANDT}'           @sap.Label: '{i18n>SO_FINAL_SO_MANDT}';
    @Common.TextFor
    SO_FINAL_SO_MANDT_TEXT;

    @Common.Text           : PO_MANDT_TEXT
    @Common.TextArrangement: #TextLast
    PO_MANDT                    @title: '{i18n>PO_MANDT}'                    @sap.Label: '{i18n>PO_MANDT}';
    @Common.TextFor
    PO_MANDT_TEXT;

    @Common.Text           : DL_TRMTYP_MAKTX
    @Common.TextArrangement: #TextFirst
    DL_TRMTYP            @title: '{i18n>DL_TRMTYP_MAKTX_LANG}'        @sap.Label: '{i18n>DL_TRMTYP}';
    @Common.TextFor
    DL_TRMTYP_MAKTX;
    DL_ZZ0S2ABGH                @title: '{i18n>DL_ZZ0S2ABGH}'              @sap.Label: '{i18n>DL_ZZ0S2ABGH}'       ;
    DL_ZZ0S2ZIEH                @title: '{i18n>DL_ZZ0S2ZIEH}'              @sap.Label: '{i18n>DL_ZZ0S2ZIEH}'       ;
    TM_VISTA_STATUS             @title: '{i18n>TM_VISTA_STATUS}'         @sap.Label: '{i18n>TM_VISTA_STATUS}';
}

annotate service.Results with {

    SO_KWMENG                      @Measures.Unit          : SO_VRKME;
    SO_VRKME                       @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_KBMENG                      @Measures.Unit          : SO_VRKME;
    SO_UNCONFIRMED_QTY             @Measures.Unit          : SO_VRKME;
    SO_KBETR                       @Measures.ISOCurrency   : SO_WAERS;
    SO_WAERS                       @Semantics.currencyCode;
    SO_KPEIN                       @Measures.Unit          : SO_KMEIN;
    SO_KMEIN                       @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_NETWR                       @Measures.ISOCurrency   : SO_WAERK;
    SO_WAERK                       @Semantics.currencyCode;
    SO_F_PSMNG                     @Measures.Unit          : SO_F_AMEIN;
    SO_F_AMEIN                     @Semantics.unitOfMeasure: 'unit-of-measure';
    DL_LFIMG                       @Measures.Unit          : DL_VRKME;
    DL_VRKME                       @Semantics.unitOfMeasure: 'unit-of-measure';
    DL_PEND_DEL_QUAN               @Measures.Unit          : DL_VRKME;
    PO_MENGE                       @Measures.Unit          : PO_MEINS;
    PO_MEINS                       @Semantics.unitOfMeasure: 'unit-of-measure';
    BL_FKIMG_LAST                  @Measures.Unit          : BL_VRKME_LAST;
    BL_VRKME_LAST                  @Semantics.unitOfMeasure: 'unit-of-measure';  
    BL_NETWR_LAST                  @Measures.ISOCurrency   : BL_WAERK_LAST;
    BL_WAERK_LAST                  @Semantics.currencyCode;       
    SO_CO_PARTNER_NAME             @UI                     : {Hidden: true};
    SO_NY_PARTNER_NAME             @UI                     : {Hidden: true};
    SO_AS_PARTNER_NAME             @UI                     : {Hidden: true};
    SO_VE_PARTNER_NAME             @UI                     : {Hidden: true};
    SO_AM_PARTNER_NAME             @UI                     : {Hidden: true};
    SO_AG_PARTNER_NAME             @UI                     : {Hidden: true};
    SO_WE_PARTNER_NAME             @UI                     : {Hidden: true};
    // SO_AG_PARTNER_NAME1             @UI                     : {Hidden: true};
    // SO_AG_PARTNER_NAME2             @UI                     : {Hidden: true};
    // SO_WE_PARTNER_NAME1             @UI                     : {Hidden: true};
    // SO_WE_PARTNER_NAME2             @UI                     : {Hidden: true};    
    SO_MAKTX                       @UI                     : {Hidden: true};
    SO_LANDX                       @UI                     : {Hidden: true};
    SO_VKORG_NAME1                 @UI                     : {Hidden: true};
    SO_FAKSP_VTEXT                 @UI                     : {Hidden: true};
    SO_SUPPLY_SITUATION_DESCR      @UI                     : {Hidden: true};
    SO_PSTYV_VTEXT                 @UI                     : {Hidden: true};
    SO_BSARK_VTEXT                 @UI                     : {Hidden: true};
    SO_VKBUR_BEZEI                 @UI                     : {Hidden: true};
    DL_LFART_VTEXT                 @UI                     : {Hidden: true};
    id                             @UI                     : {Hidden: true};
    // SO_MANDT                       @UI                     : {Hidden: true};
    // DL_MANDT                       @UI                     : {Hidden: true};
    // TM_MANDT                       @UI                     : {Hidden: true};
    // BL_MANDT_INV_FIRST             @UI                     : {Hidden: true};
    // BL_MANDT_INV_LAST              @UI                     : {Hidden: true};
    SO_SPART                       @UI                     : {Hidden: true};
    SO_ABGRU_BEZEI                 @UI                     : {Hidden: true};
    SO_ABSTA                       @UI                     : {Hidden: true};
    SO_KNUMV                       @UI                     : {Hidden: true};
    DL_HSDAT                       @UI                     : {Hidden: true};
    // DL_VFDAT                       @UI                     : {Hidden: true};
    // Shipment Details Texts
    TM_VSART_BEZEI                 @UI                     : {Hidden: true};
    TM_TDLNR_NAME1                 @UI                     : {Hidden: true};
    TM_STTRG_DDTEXT                @UI                     : {Hidden: true};
    SO_F_POSNR                     @UI                     : {Hidden: true};
    SO_VBTYP                       @UI                     : {Hidden: true};
    SO_TRAGR_VTEXT                 @UI                     : {Hidden: true};
    SO_VKGRP_BEZEI                 @UI                     : {Hidden: true};
    SO_F_VSBED_VTEXT               @UI                     : {Hidden: true};
    SO_KNREF_ITM                   @UI                     : {Hidden: true};
    SO_VRKME                       @UI                     : {Hidden: true};
    BL_VRKME_LAST                  @UI                     : {Hidden: true};
    BL_WAERK_LAST                  @UI                     : {Hidden: true};
    SO_WAERS                       @UI                     : {Hidden: true};    
    SO_KMEIN                       @UI                     : {Hidden: true};
    SO_WAERK                       @UI                     : {Hidden: true};
    TM_TRACKING_ID_COMP            @UI                     : {Hidden: true};
    DL_VGBEL                       @UI                     : {Hidden: true};
    TM_TRACKING_ID_ELEM            @UI                     : {Hidden: true};
    DL_TRMTYP_MAKTX           @UI                     : {Hidden: true};
    DL_VGPOS                       @UI                     : {Hidden: true};
    DL_POSAR                       @UI                     : {Hidden: true};
    DL_VRKME                       @UI                     : {Hidden: true};
    SO_F_VKORG_VTEXT               @UI                     : {Hidden: true};
    SO_F_AMEIN                     @UI                     : {Hidden: true};
    SO_F_AS_PARTNER_NAME           @UI                     : {Hidden: true};
    SO_DCP_ITEM_STATUS_DESCRIPTION @UI                     : {Hidden: true};
    SO_PERFK_LTEXT_LANG            @UI                     : {Hidden: true};
    PO_KUNNR_NAME                  @UI                     : {Hidden: true};
    PO_PARTNER_9A_HEAD_NAME        @UI                     : {Hidden: true};
    PO_PARTNER_9O_HEAD_NAME        @UI                     : {Hidden: true};
    PO_BSART_BATXT                 @UI                     : {Hidden: true};
    SO_MANDT_TEXT                  @UI                     : {Hidden: true};
    DL_MANDT_TEXT                  @UI                     : {Hidden: true};
    TM_MANDT_TEXT                  @UI                     : {Hidden: true};
    BL_MANDT_INV_FIRST_TEXT        @UI                     : {Hidden: true};
    BL_MANDT_INV_LAST_TEXT         @UI                     : {Hidden: true};
    SO_FINAL_SO_MANDT_TEXT         @UI                     : {Hidden: true};
    SO_FIRST_SO_MANDT_TEXT         @UI                     : {Hidden: true};
    PO_MANDT_TEXT                  @UI                     : {Hidden: true};
    PO_EKNAM                       @UI                     : {Hidden: true};
    PO_EKOTX                       @UI                     : {Hidden: true};
    PO_EBELN                       @UI                     : {Hidden: true};
    /* EUANS CHANGES
    SO_Z5_PARTNER_NAME             @UI                     : {Hidden: true};
    SO_SB_PARTNER_NAME             @UI                     : {Hidden: true};
    SO_AD_PARTNER_NAME             @UI                     : {Hidden: true};
    */
}

annotate service.valueHelps with {
    SO_KWMENG          @Measures.Unit          : SO_VRKME;
    SO_VRKME           @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_KBMENG          @Measures.Unit          : SO_VRKME;
    SO_UNCONFIRMED_QTY @Measures.Unit          : SO_VRKME;
    SO_KBETR           @Measures.ISOCurrency   : SO_WAERS;
    SO_WAERS           @Semantics.currencyCode;
    SO_KPEIN           @Measures.Unit          : SO_KMEIN;
    SO_KMEIN           @Semantics.unitOfMeasure: 'unit-of-measure';
    SO_NETWR           @Measures.ISOCurrency   : SO_WAERK;
    SO_WAERK           @Semantics.currencyCode;
    SO_F_PSMNG         @Measures.Unit          : SO_F_AMEIN;
    SO_F_AMEIN         @Semantics.unitOfMeasure: 'unit-of-measure';
    DL_LFIMG           @Measures.Unit          : DL_VRKME;
    DL_LFIMG_BATCH     @Measures.Unit          : DL_VRKME;
    DL_VRKME           @Semantics.unitOfMeasure: 'unit-of-measure';
    DL_PEND_DEL_QUAN   @Measures.Unit          : DL_VRKME;
    PO_MENGE           @Measures.Unit          : PO_MEINS;
    PO_MEINS           @Semantics.unitOfMeasure: 'unit-of-measure';
    BL_FKIMG_LAST      @Measures.Unit          : BL_VRKME_LAST;
    BL_VRKME_LAST      @Semantics.unitOfMeasure: 'unit-of-measure';
    BL_NETWR_LAST      @Measures.ISOCurrency   : BL_WAERK_LAST;
    BL_WAERK_LAST      @Semantics.currencyCode;
    id                 @UI                     : {Hidden: true};
    PO_EBELN           @UI                     : {Hidden: true};
// SO_MANDT           @UI                     : {Hidden: true};
// DL_MANDT           @UI                     : {Hidden: true};
// TM_MANDT           @UI                     : {Hidden: true};
// BL_MANDT_INV_FIRST @UI                     : {Hidden: true};
// BL_MANDT_INV_LAST  @UI                     : {Hidden: true};

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
        Label                  : '{@i18n>DL_VRKME}',
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
        Label                  : '{@i18n>SO_VBELN}',
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
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_POSNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_POSNR,
            ValueListProperty: 'SO_POSNR'
        }]
    }
    @Common.IsDigitSequence: true
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
            LocalDataProperty: SO_WERKS,
            ValueListProperty: 'SO_WERKS'
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
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_MAKTX}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_MATNR,
                ValueListProperty: 'SO_MATNR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_MAKTX'
            }

        ]
    }
    @Common.IsDigitSequence: true
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
    SO_AG_PARTNER
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_AG_PARTNER_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_AG_PARTNER,
                ValueListProperty: 'SO_AG_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_AG_PARTNER_NAME'
            }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.Results with {
    SO_WE_PARTNER
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_WE_PARTNER_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_WE_PARTNER,
                ValueListProperty: 'SO_WE_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_WE_PARTNER_NAME'
            }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.Results with {
    SO_LAND1
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_LAND1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_LAND1,
                ValueListProperty: 'SO_LAND1'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_LANDX'
            }

        ]
    }
};

annotate service.Results with {
    SO_ORT01
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ORT01}',
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
        Label                  : '{@i18n>SO_VKORG_NAME1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_VKORG,
                ValueListProperty: 'SO_VKORG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VKORG_NAME1'
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
        Label                  : '{@i18n>SO_KBMENG}',
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
        Label                  : '{@i18n>SO_UNCONFIRMED_QTY}',
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
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_FAKSP,
                ValueListProperty: 'SO_FAKSP'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_FAKSP_VTEXT'
            }

        ]
    }
};

annotate service.Results with {
    SO_F_LGORT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_LGORT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_LGORT,
            ValueListProperty: 'SO_F_LGORT'
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
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_SUPPLY_SITUATION,
                ValueListProperty: 'SO_SUPPLY_SITUATION'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_SUPPLY_SITUATION_DESCR'
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
        Label                  : '{@i18n>SO_NETWR}',
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
        Label                  : '{@i18n>SO_PSTYV}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_PSTYV,
                ValueListProperty: 'SO_PSTYV'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_PSTYV_VTEXT'
            }

        ]
    }
};

annotate service.Results with {
    SO_DISPO
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_DISPO}',
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
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_VKBUR,
                ValueListProperty: 'SO_VKBUR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VKBUR_BEZEI'
            }

        ]
    }
};

annotate service.Results with {
    SO_CO_PARTNER
    @Common.IsDigitSequence: true
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_CO_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_CO_PARTNER,
                ValueListProperty: 'SO_CO_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_CO_PARTNER_NAME'
            }

        ]
    }
};

annotate service.Results with {
    SO_NY_PARTNER
    @Common.IsDigitSequence: true
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_NY_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_NY_PARTNER,
                ValueListProperty: 'SO_NY_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_NY_PARTNER_NAME'
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
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_AS_PARTNER,
                ValueListProperty: 'SO_AS_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_AS_PARTNER_NAME'
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
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_VE_PARTNER,
                ValueListProperty: 'SO_VE_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VE_PARTNER_NAME'
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
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_AM_PARTNER,
                ValueListProperty: 'SO_AM_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_AM_PARTNER_NAME'
            }

        ]
    }
};

annotate service.Results with {
    SO_INCO1
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_INCO1}',
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
        Label                  : '{@i18n>SO_INCO2}',
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
    SO_ZTERM
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ZTERM}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ZTERM,
            ValueListProperty: 'SO_ZTERM'
        }

        ]
    }
};

annotate service.Results with {
    SO_ZZ0S2REVG2
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ZZ0S2REVG2}',
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

// annotate service.Results with {
//     SO_BSTNK
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>SO_BSTNK}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: SO_BSTNK,
//             ValueListProperty: 'SO_BSTNK'
//         }

//         ]
//     }
// };

annotate service.Results with {
    SO_ZZDKPPRODB
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ZZDKPPRODB}',
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
        Label                  : '{@i18n>SO_BSARK}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_BSARK,
                ValueListProperty: 'SO_BSARK'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_BSARK_VTEXT'
            }

        ]
    }
};


annotate service.Results with {
    DL_VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_VBELN}',
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
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_POSNR}',
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
    @Common.IsDigitSequence: true
};

annotate service.Results with {
    DL_CHARG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_CHARG}',
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
        Label                  : '{@i18n>DL_LFIMG}',
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
        Label                  : '{@i18n>DL_POSAR}',
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
        Label                  : '{@i18n>DL_VGBEL}',
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

// annotate service.Results with {
//     DL_VGPOS
//     @Common.ValueList: {
//         $Type                  : 'Common.ValueListType',
//         Label                  : '{@i18n>DL_VGPOS}',
//         CollectionPath         : 'valueHelps',
//         DistinctValuesSupported: true,
//         SearchSupported        : true,
//         Parameters             : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             LocalDataProperty: DL_VGPOS,
//             ValueListProperty: 'DL_VGPOS'
//         }

//         ]
//     }
//     @Common.IsDigitSequence: true
// };

annotate service.Results with {
    DL_LFART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_LFART}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DL_LFART,
                ValueListProperty: 'DL_LFART'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DL_LFART_VTEXT'
            }

        ]
    }
};

annotate service.Results with {
    DL_TRAID
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_TRAID}',
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
        Label                  : '{@i18n>DL_ZZ0S2BLNR}',
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
        Label                  : '{@i18n>TM_TKNUM}',
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
        Label                  : '{@i18n>TM_VSART}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: TM_VSART,
                ValueListProperty: 'TM_VSART'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'TM_VSART_BEZEI'
            }

        ]
    }
};

annotate service.Results with {
    TM_EXTI1
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_EXTI1}',
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
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_TDLNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: TM_TDLNR,
                ValueListProperty: 'TM_TDLNR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'TM_TDLNR_NAME1'
            }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.Results with {
    TM_TRACKING_ID_COMP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_TRACKING_ID_COMP}',
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
        Label                  : '{@i18n>TM_TRACKING_ID_ELEM}',
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
        Label                  : '{@i18n>DL_PEND_DEL_QUAN}',
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

annotate service.Results with {
    SO_BASF_LOFCR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_BASF_LOFCR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_BASF_LOFCR,
            ValueListProperty: 'SO_BASF_LOFCR'
        }

        ]
    }

};

annotate service.Results with {
    SO_GUSCON_LEVEL
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_GUSCON_LEVEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_GUSCON_LEVEL,
            ValueListProperty: 'SO_GUSCON_LEVEL'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.Results with {
    SO_I_VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_I_VBELN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_I_VBELN,
            ValueListProperty: 'SO_I_VBELN'
        }

        ]
    }
};

annotate service.Results with {
    SO_ISCOMPLETED
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ISCOMPLETED}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ISCOMPLETED,
            ValueListProperty: 'SO_ISCOMPLETED'
        }

        ]
    }
};

annotate service.Results with {
    SO_LEVEL_TYPE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_LEVEL_TYPE}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_LEVEL_TYPE,
            ValueListProperty: 'SO_LEVEL_TYPE'
        }

        ]
    }
};

annotate service.Results with {
    SO_N_VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_N_VBELN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_N_VBELN,
            ValueListProperty: 'SO_N_VBELN'
        }

        ]
    }
};

annotate service.Results with {
    SO_F_VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_VBELN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_VBELN,
            ValueListProperty: 'SO_F_VBELN'
        }

        ]
    }
};

annotate service.Results with {
    SO_F_POSNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_POSNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_POSNR,
            ValueListProperty: 'SO_F_POSNR'
        }

        ]
    }
};

annotate service.Results with {
    SO_VBTYP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VBTYP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VBTYP,
            ValueListProperty: 'SO_VBTYP'
        }

        ]
    }
};

annotate service.Results with {
    SO_BSTKD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_BSTKD}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_BSTKD,
            ValueListProperty: 'SO_BSTKD'
        }

        ]
    }
};

annotate service.Results with {
    BL_VBELN_INV_FIRST
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_VBELN_INV_FIRST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_VBELN_INV_FIRST,
            ValueListProperty: 'BL_VBELN_INV_FIRST'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.Results with {
    BL_POSNR_INV_FIRST
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_POSNR_INV_FIRST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_POSNR_INV_FIRST,
            ValueListProperty: 'BL_POSNR_INV_FIRST'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.Results with {
    BL_VBELN_INV_LAST
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_VBELN_INV_LAST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_VBELN_INV_LAST,
            ValueListProperty: 'BL_VBELN_INV_LAST'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.Results with {
    BL_POSNR_INV_LAST
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_POSNR_INV_LAST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_POSNR_INV_LAST,
            ValueListProperty: 'BL_POSNR_INV_LAST'
        }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.Results with {
    BL_XBLNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_XBLNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_XBLNR,
            ValueListProperty: 'BL_XBLNR'
        }

        ]
    }
// @Common.IsDigitSequence: true
};

annotate service.Results with {
    SO_TRAGR
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_TRAGR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_TRAGR,
                ValueListProperty: 'SO_TRAGR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_TRAGR_VTEXT'
            }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.Results with {
    SO_VKGRP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VKGRP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_VKGRP,
                ValueListProperty: 'SO_VKGRP'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_VKGRP_BEZEI'
            }

        ]
    }
};

annotate service.Results with {
    SO_ROUTE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ROUTE}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ROUTE,
            ValueListProperty: 'SO_ROUTE'
        }

        ]
    }
};

annotate service.Results with {
    SO_F_ZZ0S2MATUG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_ZZ0S2MATUG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_ZZ0S2MATUG,
            ValueListProperty: 'SO_F_ZZ0S2MATUG'
        }

        ]
    }
};

annotate service.Results with {
    SO_F_VSBED
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_VSBED}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_F_VSBED,
                ValueListProperty: 'SO_F_VSBED'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_F_VSBED_VTEXT'
            }

        ]
    }
};

annotate service.Results with {
    TM_SHIPMENT_CURRENT_STATUS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_SHIPMENT_CURRENT_STATUS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_SHIPMENT_CURRENT_STATUS,
            ValueListProperty: 'TM_SHIPMENT_CURRENT_STATUS'
        }

        ]
    }
};

annotate service.Results with {
    TM_SHIPMENT_ALERT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_SHIPMENT_ALERT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_SHIPMENT_ALERT,
            ValueListProperty: 'TM_SHIPMENT_ALERT'
        }

        ]
    }
};

annotate service.Results with {
    SO_F_VKORG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_VKORG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_F_VKORG,
                ValueListProperty: 'SO_F_VKORG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_F_VKORG_VTEXT'
            }

        ]
    }
};

annotate service.Results with {
    SO_F_WERKS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_WERKS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_WERKS,
            ValueListProperty: 'SO_F_WERKS'
        }

        ]
    }
};

annotate service.Results with {
    SO_F_AUFNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_AUFNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_AUFNR,
            ValueListProperty: 'SO_F_AUFNR'
        }

        ]
    }
};

annotate service.Results with {
    SO_F_AMEIN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_AMEIN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_F_AMEIN,
            ValueListProperty: 'SO_F_AMEIN'
        }]
    }
}


annotate service.Results with {
    SO_F_PSMNG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_PSMNG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_F_PSMNG,
                ValueListProperty: 'SO_F_PSMNG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_F_AMEIN'
            }

        ]
    }
};


annotate service.Results with {
    SO_F_AS_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_F_AS_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_F_AS_PARTNER,
                ValueListProperty: 'SO_F_AS_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_F_AS_PARTNER_NAME'
            }

        ]
    }
};

annotate service.Results with {
    TM_STTRG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_STTRG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: TM_STTRG,
                ValueListProperty: 'TM_STTRG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'TM_STTRG_DDTEXT'
            }

        ]
    }
};

annotate service.Results with {
    SO_KNREF_HEAD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KNREF_HEAD}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_KNREF_HEAD,
            ValueListProperty: 'SO_KNREF_HEAD'
        }

        ]
    }
};

annotate service.Results with {
    SO_ABGRU
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ABGRU_BEZEI}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_ABGRU,
                ValueListProperty: 'SO_ABGRU'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_ABGRU_BEZEI'
            }

        ]
    }
};

annotate service.Results with {
    SO_DCP_ITEM_STATUS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_DCP_ITEM_STATUS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_DCP_ITEM_STATUS,
                ValueListProperty: 'SO_DCP_ITEM_STATUS'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_DCP_ITEM_STATUS_DESCRIPTION'
            }

        ]
    }
};

annotate service.Results with {
    SO_PERFK
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_PERFK}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_PERFK,
                ValueListProperty: 'SO_PERFK'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_PERFK_LTEXT_LANG'
            }

        ]
    }
};

annotate service.Results with {
    DL_POSNR_BATCH
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_POSNR_BATCH}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_POSNR_BATCH,
            ValueListProperty: 'DL_POSNR_BATCH'
        }

        ]
    }
};

annotate service.Results with {
    DL_LFIMG_BATCH
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_LFIMG_BATCH}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DL_LFIMG_BATCH,
                ValueListProperty: 'DL_LFIMG_BATCH'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DL_VRKME'
            }
        ]
    }
};

annotate service.Results with {
    SO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_MANDT,
                ValueListProperty: 'SO_MANDT'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_MANDT_TEXT'
            }
        ]
    }
}

annotate service.Results with {
    DL_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DL_MANDT,
                ValueListProperty: 'DL_MANDT'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DL_MANDT_TEXT'
            }
        ]
    }
}

annotate service.Results with {
    TM_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: TM_MANDT,
                ValueListProperty: 'TM_MANDT'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'TM_MANDT_TEXT'
            }
        ]
    }
}

annotate service.Results with {
    BL_MANDT_INV_FIRST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_MANDT_INV_FIRST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: BL_MANDT_INV_FIRST,
                ValueListProperty: 'BL_MANDT_INV_FIRST'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'BL_MANDT_INV_FIRST_TEXT'
            }
        ]
    }
}

annotate service.Results with {
    BL_MANDT_INV_LAST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_MANDT_INV_LAST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: BL_MANDT_INV_LAST,
                ValueListProperty: 'BL_MANDT_INV_LAST'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'BL_MANDT_INV_LAST_TEXT'
            }
        ]
    }
}

annotate service.Results with {
    SO_FIRST_SO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_FIRST_SO_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_FIRST_SO_MANDT,
                ValueListProperty: 'SO_FIRST_SO_MANDT'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_FIRST_SO_MANDT_TEXT'
            }
        ]
    }
}

annotate service.Results with {
    SO_FINAL_SO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_FINAL_SO_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_FINAL_SO_MANDT,
                ValueListProperty: 'SO_FINAL_SO_MANDT'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_FINAL_SO_MANDT_TEXT'
            }
        ]
    }
}

annotate service.Results with {
    PO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_MANDT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_MANDT,
                ValueListProperty: 'PO_MANDT'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'PO_MANDT_TEXT'
            }
        ]
    }
}

annotate service.Results with {
    PO_EBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EBELN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EBELN,
            ValueListProperty: 'PO_EBELN'
        }]
    }
}

annotate service.Results with {
    PO_EBELP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EBELP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EBELP,
            ValueListProperty: 'PO_EBELP'
        }]
    }
}

annotate service.Results with {
    PO_BSART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_BSART_BATXT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_BSART,
                ValueListProperty: 'PO_BSART'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'PO_BSART_BATXT'
            }

        ]
    }
};

annotate service.Results with {
    PO_EKORG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EKORG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_EKORG,
                ValueListProperty: 'PO_EKORG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'PO_EKOTX'
            }
        ]
    }
}

annotate service.Results with {
    PO_EKGRP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EKGRP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_EKGRP,
                ValueListProperty: 'PO_EKGRP'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'PO_EKNAM'
            }
        ]
    }
}

annotate service.Results with {
    PO_EMATN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EMATN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EMATN,
            ValueListProperty: 'PO_EMATN'
        }]
    }
}

annotate service.Results with {
    PO_WERKS_PO
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_WERKS_PO}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_WERKS_PO,
            ValueListProperty: 'PO_WERKS_PO'
        }]
    }
}

annotate service.Results with {
    PO_KUNNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_KUNNR_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_KUNNR,
                ValueListProperty: 'PO_KUNNR'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'PO_KUNNR_NAME'
            }

        ]
    }
};

annotate service.Results with {
    PO_PARTNER_9A_HEAD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_PARTNER_9A_HEAD_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
             {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_PARTNER_9A_HEAD,
                ValueListProperty: 'PO_PARTNER_9A_HEAD'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'PO_PARTNER_9A_HEAD_NAME'
            }

        ]
    }
};

annotate service.Results with {
    PO_PARTNER_9O_HEAD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_PARTNER_9O_HEAD_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_PARTNER_9O_HEAD,
                ValueListProperty: 'PO_PARTNER_9O_HEAD'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'PO_PARTNER_9O_HEAD_NAME'
            }

        ]
    }
};

annotate service.Results with {
    DL_TRMTYP
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_TRMTYP_MAKTX_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DL_TRMTYP,
                ValueListProperty: 'DL_TRMTYP'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DL_TRMTYP_MAKTX'
            }

        ]
    }
    @Common.IsDigitSequence: true
};

annotate service.Results with {
    DL_ZZ0S2ABGH
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_ZZ0S2ABGH}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_ZZ0S2ABGH,
            ValueListProperty: 'DL_ZZ0S2ABGH'
        }

        ]
    }
};

annotate service.Results with {
    DL_ZZ0S2ZIEH
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_ZZ0S2ZIEH}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_ZZ0S2ZIEH,
            ValueListProperty: 'DL_ZZ0S2ZIEH'
        }

        ]
    }
};

annotate service.Results with {
    BL_WAERK_LAST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL__WAERK_LAST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_WAERK_LAST,
            ValueListProperty: 'BL_WAERK_LAST'
        }]
    }
}

annotate service.Results with {
    BL_NETWR_LAST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_NETWR_LAST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: BL_NETWR_LAST,
                ValueListProperty: 'BL_NETWR_LAST'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'BL_WAERK_LAST'
            }

        ]
    }
};


annotate service.Results with {
    BL_VRKME_LAST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_VRKME_LAST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BL_VRKME_LAST,
            ValueListProperty: 'BL_VRKME_LAST'
        }]
    }
};
annotate service.Results with {
    BL_FKIMG_LAST  
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_FKIMG_LAST  }',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: BL_FKIMG_LAST,
                ValueListProperty: 'BL_FKIMG_LAST'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'BL_VRKME_LAST'
            }

        ]
    }
};

annotate service.Results with {
    TM_VISTA_STATUS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_VISTA_STATUS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: TM_VISTA_STATUS,
                ValueListProperty: 'TM_VISTA_STATUS'
            }

        ]
    }
};

/*   euan's changes
annotate service.Results with {
    SO_Z5_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_Z5_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_Z5_PARTNER,
                ValueListProperty: 'SO_Z5_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_Z5_PARTNER_NAME'
            }

        ]
    }
};

annotate service.Results with {
    SO_SB_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_SB_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_SB_PARTNER,
                ValueListProperty: 'SO_SB_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_SB_PARTNER_NAME'
            }

        ]
    }
};

annotate service.Results with {
    SO_AD_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_AD_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_AD_PARTNER,
                ValueListProperty: 'SO_AD_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_AD_PARTNER_NAME'
            }

        ]
    }
}; */

annotate service.Results with @UI.LineItem: {
    ![@UI.Criticality]: 5,
    $value            : [
        {Value: SO_VBELN},
        {Value: SO_POSNR},
        {Value: SO_AUART},
        {Value: SO_ERDAT_ORDER},
        {Value: SO_ERDAT_ITEM},
        {Value: SO_WERKS},
        {Value: SO_VTWEG},
        {Value: SO_MATNR},
        {Value: SO_MAKTX},
        {Value: SO_KDMAT},
        // {Value: SO_BSTNK},
        {Value: SO_AG_PARTNER},
        {Value: SO_WE_PARTNER},
        {Value: SO_LAND1},
        {Value: SO_LANDX},
        {Value: SO_ORT01},
        {Value: SO_VKORG},
        {Value: SO_VKORG_NAME1},
        {Value: SO_KNREF_HEAD},
        // {Value: SO_KNREF_ITM},
        {Value: SO_VBUND},
        {Value: SO_EDATU_REQUESTED},
        {Value: SO_KWMENG},
        {Value: SO_VRKME},
        {Value: SO_EDATU_CONFIRMED},
        {Value: SO_KBMENG},
        {Value: SO_F_LDDAT},
        {Value: SO_UNCONFIRMED_QTY},
        {Value: SO_REQ_TEXT},
        {Value: SO_FAKSP},
        {Value: SO_FAKSP_VTEXT},
        {Value: SO_F_LGORT},
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
        /* Euans chnages
        {Value: SO_Z5_PARTNER},
        {Value: SO_Z5_PARTNER_NAME},
        {Value: SO_SB_PARTNER},
        {Value: SO_SB_PARTNER_NAME},
      
        {Value: SO_AD_PARTNER},
        {Value: SO_AD_PARTNER_NAME}
          */

    ]
};

annotate service.Results with @(UI: {SelectionFields: [
    SO_VBELN,
    SO_VKORG,
    SO_VTWEG,
    SO_AG_PARTNER,
    SO_WE_PARTNER


],

});
