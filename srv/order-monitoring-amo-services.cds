using allorders.db as db_app from '../db/order-monitoring-amo-service';
using {AMOOUtilsService as AMOOUtilsService} from './external/AMOOUtilsService';
using {CSEUCockpitService as CSEUCockpitService} from './external/CSEUCockpitService';

service srvOpenOrders {

  @readonly
  entity SAPSystems              as projection on db_app.SAPSystems;
  @readonly
  entity PredefReasonBuckets as projection on db_app.PreDefReasonBucket;
  @readonly
  entity PredefReasonComments as projection on db_app.PreDefReasonComments;
  @readonly
  entity PredefReasonComments01 as projection on db_app.PreDefReasonComments where BucketKey = '01';
  @readonly
  entity PredefReasonComments02 as projection on db_app.PreDefReasonComments where BucketKey = '02';
  @readonly
  entity PredefReasonComments03 as projection on db_app.PreDefReasonComments where BucketKey = '03';
  @readonly
  entity PredefReasonComments04 as projection on db_app.PreDefReasonComments where BucketKey = '04';
  @readonly
  entity PredefReasonComments05 as projection on db_app.PreDefReasonComments where BucketKey = '05';
  @readonly
  entity DCPStatus               as projection on db_app.DCPStatus;
   @readonly
  entity PredefFollowupNotes      as
      select from db_app.PredefFollowupNotes {
          defId      as FollowUpNoteId,
          defContent as FollowUpNoteContent
        };

  entity VBAKAuthObjectKeys      as select from db_app.VBAKAUTH;
  entity EKKOAuthObjectKeys      as select from db_app.EKKOAUTH;
  function getVBAKAuthObjKeys(forceRefresh : Boolean)    returns String;

  @readonly
  @cds.redirection.target: true
  entity HOMRemarks              as
    select from db_app.RESULTS {
      key VBELN as SO_VBELN,
      key POSNR as SO_POSNR,
          HTEXT as HTEXT,
          VKORG as VKORG,
          VTWEG as VTWEG,
          SPART as SPART,

    };

  @readonly
  @cds.redirection.target: true
  entity BaseEntity              as
    select from db_app.RESULTS {
      key null                                        as id                              : UUID,
          MANDT                                       as SO_MANDT,
          MANDT_DEL                                   as DL_MANDT,
          TM_MANDT,
          BL_MANDT_INV_FIRST,
          BL_MANDT_INV_LAST,
          FINAL_SO_MANDT                              as SO_FINAL_SO_MANDT,
          FIRST_SO_MANDT                              as SO_FIRST_SO_MANDT,
          PO_MANDT,
          NEXT_SO_MANDT                               as SO_NEXT_SO_MANDT,
          virtual null                                as SO_MANDT_TEXT                  : String(20),
          virtual null                                as DL_MANDT_TEXT                  : String(20),
          virtual null                                as TM_MANDT_TEXT                  : String(20),
          virtual null                                as BL_MANDT_INV_FIRST_TEXT        : String(20),
          virtual null                                as BL_MANDT_INV_LAST_TEXT         : String(20),
          virtual null                                as SO_FINAL_SO_MANDT_TEXT         : String(20),
          virtual null                                as SO_FIRST_SO_MANDT_TEXT         : String(20),
          virtual null                                as PO_MANDT_TEXT                  : String(20),
          virtual null                                as SO_NEXT_SO_MANDT_TEXT          : String(20),
          VBELN                                       as SO_VBELN,
          POSNR                                       as SO_POSNR,
          SO_ERDAT_ORDER_DATE                         as SO_ERDAT_ORDER,
          SO_ERDAT_ITEM_DATE                          as SO_ERDAT_ITEM,
          AUART                                       as SO_AUART,
          WERKS                                       as SO_WERKS,
          VTWEG                                       as SO_VTWEG,
          MATNR                                       as SO_MATNR,
          MAKTX_LANG                                  as SO_MAKTX,
          KDMAT                                       as SO_KDMAT,
          AG_PARTNER                                  as SO_AG_PARTNER,
          AG_PARTNER_NAME1 || ' ' || AG_PARTNER_NAME2 as SO_AG_PARTNER_NAME              : String(80),
          WE_PARTNER                                  as SO_WE_PARTNER,
          WE_PARTNER_NAME1 || ' ' || WE_PARTNER_NAME2 as SO_WE_PARTNER_NAME              : String(80),
          @UI.Hidden: true
          AG_PARTNER_NAME1                            as SO_AG_PARTNER_NAME1, // to enable default search, parts of calculated fields are required to be added too to service
          @UI.Hidden: true
          AG_PARTNER_NAME2                            as SO_AG_PARTNER_NAME2,
          @UI.Hidden: true
          WE_PARTNER_NAME1                            as SO_WE_PARTNER_NAME1,
          @UI.Hidden: true
          WE_PARTNER_NAME2                            as SO_WE_PARTNER_NAME2,
          IFNULL(
            CO_PARTNER_ITM, CO_PARTNER_HEAD
          )                                           as SO_CO_PARTNER                   : String(10),
          IFNULL(
            NULLIF(
              TRIM(COALESCE(
                CO_PARTNER_NAME1_ITM, ''
              ) || ' ' || COALESCE(
                CO_PARTNER_NAME2_ITM, ''
              )), ''
            ), NULLIF(
              TRIM(COALESCE(
                CO_PARTNER_NAME1_HEAD, ''
              ) || ' ' || COALESCE(
                CO_PARTNER_NAME2_HEAD, ''
              )), ''
            )
          )                                           as SO_CO_PARTNER_NAME              : String(80),
          IFNULL(
            NY_PARTNER_ITM, NY_PARTNER_HEAD
          )                                           as SO_NY_PARTNER                   : String(10),
          IFNULL(
            NULLIF(
              TRIM(COALESCE(
                NY_PARTNER_NAME1_ITM, ''
              ) || ' ' || COALESCE(
                NY_PARTNER_NAME2_ITM, ''
              )), ''
            ), NULLIF(
              TRIM(COALESCE(
                NY_PARTNER_NAME1_HEAD, ''
              ) || ' ' || COALESCE(
                NY_PARTNER_NAME2_HEAD, ''
              )), ''
            )
          )                                           as SO_NY_PARTNER_NAME              : String(80),
          IFNULL(
            AS_PARTNER_ITM, AS_PARTNER_HEAD
          )                                           as SO_AS_PARTNER                   : String(8),
          IFNULL(
            AS_PARTNER_NAME_ITM, AS_PARTNER_NAME_HEAD
          )                                           as SO_AS_PARTNER_NAME              : String(40),
          IFNULL(
            VE_PARTNER_ITM, VE_PARTNER_HEAD
          )                                           as SO_VE_PARTNER                   : String(8),
          IFNULL(
            VE_PARTNER_NAME_ITM, VE_PARTNER_NAME_HEAD
          )                                           as SO_VE_PARTNER_NAME              : String(40),
          IFNULL(
            AM_PARTNER_ITM, AM_PARTNER_HEAD
          )                                           as SO_AM_PARTNER                   : String(8),
          IFNULL(
            AM_PARTNER_NAME_ITM, AM_PARTNER_NAME_HEAD
          )                                           as SO_AM_PARTNER_NAME              : String(40),
          LAND1                                       as SO_LAND1,
          LANDX_LANG                                  as SO_LANDX,
          ORT01                                       as SO_ORT01,
          VKORG                                       as SO_VKORG,
          VKORG_NAME1                                 as SO_VKORG_NAME1,
          KNREF_HEAD                                  as SO_KNREF_HEAD,
          KNREF_ITM                                   as SO_KNREF_ITM,
          case
            when VBUND is not null
                 and VBUND <> ''
                 then 'X'
            else ''
          end                                         as SO_VBUND                        : String(1),
          SO_EDATU_REQUESTED_DATE                     as SO_EDATU_REQUESTED,
          KWMENG                                      as SO_KWMENG,
          VRKME                                       as SO_VRKME,
          SO_EDATU_CONFIRMED_DATE                     as SO_EDATU_CONFIRMED,
          KBMENG                                      as SO_KBMENG,
          UNCONFIRMED_QTY                             as SO_UNCONFIRMED_QTY,
          REQ_TEXT                                    as SO_REQ_TEXT,
          case
            when FAKSP = ''
                 or FAKSP is null
                 then FAKSK
            else FAKSP
          end                                         as SO_FAKSP                        : String(2),
          case
            when FAKSP_VTEXT_LANG = ''
                 or FAKSP_VTEXT_LANG is null
                 then FAKSK_VTEXT_LANG
            else FAKSP_VTEXT_LANG
          end                                         as SO_FAKSP_VTEXT                  : String(20),
          F_LGORT                                     as SO_F_LGORT,
          SUPPLY_SITUATION                            as SO_SUPPLY_SITUATION,
          SUPPLY_SITUATION_DESCR                      as SO_SUPPLY_SITUATION_DESCR,
          IFNULL(
            KBETR, KBETR_ALT
          )                                           as SO_KBETR                        : Decimal(11, 2),
          IFNULL(
            WAERS, WAERS_ALT
          )                                           as SO_WAERS                        : String(5),
          IFNULL(
            KPEIN, KPEIN_ALT
          )                                           as SO_KPEIN                        : Decimal(5),
          IFNULL(
            KMEIN, KMEIN_ALT
          )                                           as SO_KMEIN                        : String(3),
          NETWR                                       as SO_NETWR,
          WAERK                                       as SO_WAERK,
          HTEXT                                       as SO_HTEXT,
          PSTYV                                       as SO_PSTYV,
          PSTYV_VTEXT_LANG                            as SO_PSTYV_VTEXT,
          DISPO                                       as SO_DISPO,
          KOSCH                                       as SO_KOSCH,
          VKBUR                                       as SO_VKBUR,
          VKBUR_BEZEI_LANG                            as SO_VKBUR_BEZEI,
          ABGRU                                       as SO_ABGRU,
          ABGRU_BEZEI_LANG                            as SO_ABGRU_BEZEI,
          ABSTA                                       as SO_ABSTA,
          KNUMV                                       as SO_KNUMV,
          SPART                                       as SO_SPART,
          IFNULL(
            INCO1_ITEM, INCO1_HEAD
          )                                           as SO_INCO1                        : String(3),
          IFNULL(
            INCO2_ITEM, INCO2_HEAD
          )                                           as SO_INCO2                        : String(28),
          IFNULL(
            ZTERM_ITEM, ZTERM_HEAD
          )                                           as SO_ZTERM                        : String(4),
          SO_PRSDT_DATE                               as SO_PRSDT,
          ZZ0S2REVG2                                  as SO_ZZ0S2REVG2,
          ZZDKPPRODB                                  as SO_ZZDKPPRODB,
          BSARK                                       as SO_BSARK,
          BSARK_VTEXT_LANG                            as SO_BSARK_VTEXT,
          _BASF_LOFCR                                 as SO_BASF_LOFCR,
          GUSCON_LEVEL                                as SO_GUSCON_LEVEL,
          FIRST_SO                                    as SO_I_VBELN,
          FIRST_POSNR                                 as SO_I_POSNR,
          ISCOMPLETED                                 as SO_ISCOMPLETED,
          LEVEL_TYPE                                  as SO_LEVEL_TYPE,
          NEXT_SO                                     as SO_N_VBELN,
          NEXT_POSNR                                  as SO_N_POSNR,
          FINAL_SO                                    as SO_F_VBELN,
          FINAL_POSNR                                 as SO_F_POSNR,
          VBTYP                                       as SO_VBTYP,
          BSTKD                                       as SO_BSTKD,
          TRAGR                                       as SO_TRAGR,
          TRAGR_VTEXT_LANG                            as SO_TRAGR_VTEXT,
          VKGRP                                       as SO_VKGRP,
          VKGRP_BEZEI_LANG                            as SO_VKGRP_BEZEI,
          ROUTE                                       as SO_ROUTE,
          F_WERKS                                     as SO_F_WERKS,
          F_VKORG                                     as SO_F_VKORG,
          F_VKORG_NAME1                               as SO_F_VKORG_VTEXT,
          SO_F_TDDAT_DATE                             as SO_F_TDDAT,
          F_ZZ0S2MATUG                                as SO_F_ZZ0S2MATUG,
          F_VSBED                                     as SO_F_VSBED,
          F_VSBED_VTEXT_LANG                          as SO_F_VSBED_VTEXT,
          F_AUFNR                                     as SO_F_AUFNR,
          SO_F_DGLTP_DATE                             as SO_F_DGLTP,
          F_PSMNG                                     as SO_F_PSMNG,
          F_AMEIN                                     as SO_F_AMEIN,
          SO_F_LDDAT_DATE                             as SO_F_LDDAT,
          IFNULL(
            F_AS_PARTNER_ITM, F_AS_PARTNER_HEAD
          )                                           as SO_F_AS_PARTNER                 : String(8),
          IFNULL(
            F_AS_PARTNER_NAME_ITM, F_AS_PARTNER_NAME_HEAD
          )                                           as SO_F_AS_PARTNER_NAME            : String(40),
          DCP_ITEM_STATUS                             as SO_DCP_ITEM_STATUS,
          virtual null                                as SO_DCP_ITEM_STATUS_DESCRIPTION  : String(50),
          VBELN_DEL                                   as DL_VBELN,
          POSNR_DEL                                   as DL_POSNR_BATCH,
          POSNR_DEL_HEAD                              as DL_POSNR,
          CHARG                                       as DL_CHARG,
          LFIMG                                       as DL_LFIMG_BATCH,
          LFIMG_HEAD                                  as DL_LFIMG,
          VRKME                                       as DL_VRKME,
          POSAR                                       as DL_POSAR,
          VGBEL                                       as DL_VGBEL,
          VGPOS                                       as DL_VGPOS,
          LFART                                       as DL_LFART,
          LFART_VTEXT_LANG                            as DL_LFART_VTEXT,
          DL_LFDAT_DATE                               as DL_LFDAT,
          DL_HSDAT_DATE                               as DL_HSDAT,
          DL_VFDAT_DATE                               as DL_VFDAT,
          TRAID                                       as DL_TRAID,
          ZZ0S2BLNR                                   as DL_ZZ0S2BLNR,
          PEND_DEL_QUAN                               as DL_PEND_DEL_QUAN,
          DL_WADAT_DATE                               as DL_WADAT,
          DL_WADAT_IST_DATE                           as DL_WADAT_IST,
          NOTE_TEXT                                   as LAST_NOTE,
          NOTE_TEXT_FROMORDERCHAIN                    as LAST_NOTE_FROMORDERCHAIN,
          TKNUM                                       as TM_TKNUM,
          VSART                                       as TM_VSART,
          VSART_BEZEI_LANG                            as TM_VSART_BEZEI,
          EXTI1                                       as TM_EXTI1,
          TDLNR                                       as TM_TDLNR,
          TDLNR_NAME1                                 as TM_TDLNR_NAME1,
          TM_DPTBG_DATE                               as TM_DPTBG,
          TM_AR_DATE_DATE                             as TM_AR_DATE,
          TM_DALBG_DATE                               as TM_DALBG,
          STTRG                                       as TM_STTRG,
          STTRG_DDTEXT_LANG                           as TM_STTRG_DDTEXT,
          BL_VBELN_INV_FIRST                          as BL_VBELN_INV_FIRST,
          BL_POSNR_INV_FIRST                          as BL_POSNR_INV_FIRST,
          BL_VBELN_INV_LAST                           as BL_VBELN_INV_LAST,
          BL_POSNR_INV_LAST                           as BL_POSNR_INV_LAST,
          XBLNR                                       as BL_XBLNR,
          BL_ERDAT_FIRST_DATE                         as BL_ERDAT_FIRST,
          BL_ERDAT_LAST_DATE                          as BL_ERDAT_LAST,
          BL_FKIMG_LAST                               as BL_FKIMG_LAST,
          BL_NETWR_LAST                               as BL_NETWR_LAST,
          BL_WAERK_LAST                               as BL_WAERK_LAST,
          BL_VRKME_LAST                               as BL_VRKME_LAST,
          ERDAT_DEL_DATE                              as DL_ERDAT,
          LDDAT_DEL_DATE                              as DL_LDDAT,
          F_MBDAT_DATE                                as SO_F_MBDAT,
          PERFK || ' ' ||     PERFK_LTEXT_LANG        as SO_PERFK : String(52),
          PERFK_LTEXT_LANG                            as SO_PERFK_LTEXT_LANG,
          SO_FKDAT_DATE                               as SO_FKDAT,
          EBELN                                       as PO_EBELN,
          EBELP                                       as PO_EBELP,
          case
            when AEDAT_HEAD_DATE = '00000000'
                 then null
            else AEDAT_HEAD_DATE
          end                                         as PO_AEDAT_HEAD                   : Date,
          case
            when AEDAT_ITEM_DATE = '00000000'
                 then null
            else AEDAT_ITEM_DATE
          end                                         as PO_AEDAT_ITEM                   : Date,
          BSART                                       as PO_BSART,
          EKORG                                       as PO_EKORG,
          EKOTX                                       as PO_EKOTX,
          EKGRP                                       as PO_EKGRP,
          EKNAM                                       as PO_EKNAM,
          EMATN                                       as PO_EMATN,
          WERKS_PO                                    as PO_WERKS_PO,
          MENGE                                       as PO_MENGE,
          MEINS                                       as PO_MEINS,
          KUNNR                                       as PO_KUNNR,
          KUNNR_NAME1 || ' ' || KUNNR_NAME2           as PO_KUNNR_NAME                   : String(80),
          PARTNER_9A_HEAD                             as PO_PARTNER_9A_HEAD,
          PARTNER_9O_HEAD                             as PO_PARTNER_9O_HEAD,
          BSART_BATXT                                 as PO_BSART_BATXT,
          TRMTYP                                      as DL_TRMTYP,
          TRMTYP_MAKTX_LANG                           as DL_TRMTYP_MAKTX,
          ZZ0S2ABGH                                   as DL_ZZ0S2ABGH,
          ZZ0S2ZIEH                                   as DL_ZZ0S2ZIEH,
          LPRIO                                       as SO_LPRIO,
          VISTA_STATUS                                as TM_VISTA_STATUS,
          case when ( CURRENT_ETA_VISTA is null or CURRENT_ETA_VISTA = '' or CURRENT_ETA_VISTA = '00000000') then DPTEN else CURRENT_ETA_VISTA end as TM_DPTEN : Date, // ETA
          // case when ( ATA_VISTA is null or ATA_VISTA = '' or ATA_VISTA = '00000000') then DATEN else ATA_VISTA end as TM_DATEN : Date, /// ATA
          TM_DATEN_DATE  as TM_DATEN, /// ATA - TEMPORARY FROM SAP UNTIL VISTA TOPIC QUESTIONS ARE ANSWERED
          case when ( ATD_VISTA is null or ATD_VISTA = '' or ATD_VISTA = '00000000') then DATBG else ATD_VISTA end as TM_DATBG : Date, /// ATD
          // TM_DATEN_DATE                               as TM_DATEN, /// SAP ATA
          // TM_DATBG_DATE                               as TM_DATBG, /// SAP ATD
          Z5_PARTNER_ITM                              as SO_Z5_PARTNER,
          Z5_PARTNER_NAME_ITM                         as SO_Z5_PARTNER_NAME,
          SB_PARTNER_ITM                              as SO_SB_PARTNER,
          SB_PARTNER_NAME_ITM                         as SO_SB_PARTNER_NAME,
          IFNULL(
            AD_PARTNER_ITM, AD_PARTNER_HEAD
          )                                           as SO_AD_PARTNER                   : String(8),
          IFNULL(
            AD_PARTNER_NAME_ITM, AD_PARTNER_NAME_HEAD
          )                                           as SO_AD_PARTNER_NAME              : String(40),
          BNAME                                       as SO_BNAME,
          IHREZ                                       as SO_IHREZ,
          AUGRU                                       as SO_AUGRU,
          AUGRU_BEZEI_LANG                            as SO_AUGRU_BEZEI_LANG,
          KDGRP                                       as SO_KDGRP,
          KDGRP_KTEXT_LANG                            as SO_KDGRP_KTEXT_LANG,
          WE_PARTNER_REGION                           as SO_WE_PARTNER_REGION,
          WE_PARTNER_REGION_BEZEI_LANG                as SO_WE_PARTNER_REGION_BEZEI_LANG,
          PRCTR                                       as SO_PRCTR,

          IFNULL(
            TO_PARTNER_ITM, TO_PARTNER_HEAD
          )                                           as SO_TO_PARTNER                   : String(10),

          IFNULL(
            NULLIF(
              TRIM(COALESCE(
                TO_PARTNER_NAME1_ITM, ''
              ) || ' ' || COALESCE(
                TO_PARTNER_NAME2_ITM, ''
              )), ''
            ), NULLIF(
              TRIM(COALESCE(
                TO_PARTNER_NAME1_HEAD, ''
              ) || ' ' || COALESCE(
                TO_PARTNER_NAME2_HEAD, ''
              )), ''
            )
          )                                           as SO_TO_PARTNER_NAME              : String(80),

          @UI.Hidden: true
          TO_PARTNER_NAME1_HEAD                       as SO_TO_PARTNER_NAME1_HEAD,

          @UI.Hidden: true
          TO_PARTNER_NAME2_HEAD                       as SO_TO_PARTNER_NAME2_HEAD,

          @UI.Hidden: true
          TO_PARTNER_NAME1_ITM                        as SO_TO_PARTNER_NAME1_ITM,

          @UI.Hidden: true
          TO_PARTNER_NAME2_ITM                        as SO_TO_PARTNER_NAME2_ITM,
          
          FOLLOWUP_NOTES_LANG                         as SO_FOLLOWUP_NOTES_LANG,
          REASON_CODE_01_LANG                         as SO_REASON_CODE_01_LANG,
          REASON_CODE_02_LANG                         as SO_REASON_CODE_02_LANG,
          REASON_CODE_03_LANG                         as SO_REASON_CODE_03_LANG,
          REASON_CODE_04_LANG                         as SO_REASON_CODE_04_LANG,
          REASON_CODE_05_LANG                         as SO_REASON_CODE_05_LANG,
          DEV_CONF_DATE                               as SO_DEV_CONF_DATE,
          EMAIL                                       as SO_EMAIL,
          EMAIL_SEND_DATE_F_DATE                      as SO_EMAIL_SEND_DATE_F,
          EMAIL_SENT_ON_DATE                          as SO_EMAIL_SENT_ON,
          DPLBG_TM_DATE                               as TM_DPLBG_DATE,
          ERDAT_TM_DATE                               as TM_ERDAT_DATE,
          DPREG_TM_DATE                               as TM_DPREG_DATE,
          WERKS_DEL                                   as DL_WERKS_DEL,
          VKORG_DEL                                   as DL_VKORG_DEL,
          VMSTA                                       as SO_VMSTA,
          ZZ0S2VGANN                                  as SO_ZZ0S2VGANN,
          ZZ0S2LOANN                                  as SO_ZZ0S2LOANN,
          PO_REQ_DEL_DATE_FORMATTED                   as PO_REQ_DEL_DATE,
          AB_CONF_DATE_FORMATTED                      as PO_AB_CONF_DATE,
          LA_CONF_DATE_FORMATTED                      as PO_LA_CONF_DATE,
          ZD_CONF_DATE_FORMATTED                      as PO_ZD_CONF_DATE,
          ZZATP_CUST                                  as SO_ZZATP_CUST,
          ETA_EVENT_SOURCE                            as TM_ETA_EVENT_SOURCE,
          CONTRACT                                    as SO_CONTRACT,
          CONTRACT_ITEM                               as SO_CONTRACT_ITEM,
          ZZMHDRZ                                     as SO_ZZMHDRZ,
          IFNULL(
            ZTERM_ITEM_VTEXT_LANG, ZTERM_HEAD_VTEXT_LANG
          )                                           as SO_ZTERM_VTEXT_LANG             : String(30),

          SEED_COUNT                                  as DL_SEED_COUNT,
          SEEDS_TAGGED_GERM                           as DL_SEEDS_TAGGED_GERM,
          XREF3                                       as BL_XREF3,
          ABLAD                                       as SO_ABLAD,
          DGSTA                                       as SO_DGSTA,
          MVGR2                                       as SO_MVGR2,
          VALDT_DATE                                  as SO_VALDT,
          MVGR2_BEZEI_LANG                            as SO_MVGR2_BEZEI_LANG,
          DGSTA_DDTEXT_LANG                           as SO_DGSTA_DDTEXT_LANG,
          MFRGR                                       as SO_MFRGR,
          MFRGR_BEZEI_LANG                            as SO_MFRGR_BEZEI_LANG,
          TNDR_TRKID                                  as TM_TNDR_TRKID,
          YRDSDV1_IMPORT_CARGO_NO                     as SO_YRDSDV1_IMPORT_CARGO_NO,
          @UI.HiddenFilter
          ETA_UPDATED_VISTA                           as TM_ETA_UPDATED_VISTA,
          OLD_ETA_VISTA_DATE                          as TM_OLD_ETA_VISTA_DATE,
          ABRDT_DATE                                  as SO_ABRDT,
          MTVFP                                       as SO_MTVFP,
          BIZAGI_STATUS                               as SO_BIZAGI_STATUS,
          TS_PARTNER                                  as TM_TS_PARTNER,
          TS_PARTNER_NAME1                            as TM_TS_PARTNER_NAME1,
          KVGR5                                       as SO_KVGR5,
          STCEG                                       as BL_STCEG,
          IFNULL(
            OM_PARTNER_ITM, OM_PARTNER_HEAD
          )                                           as SO_OM_PARTNER                   : String(8),
          IFNULL(
            OM_PARTNER_NAME_ITM, OM_PARTNER_NAME_HEAD
          )                                           as SO_OM_PARTNER_NAME              : String(80),
          IFNULL(
              AH_PARTNER_ITM, AH_PARTNER_HEAD
          )                                           as SO_AH_PARTNER                   : String(8),
          IFNULL(
              AH_PARTNER_NAME_ITM, AH_PARTNER_NAME_HEAD
          )                                           as SO_AH_PARTNER_NAME             : String(80),
          LABST                                       as SO_LABST,
          KVGR5_LANG                                  as SO_KVGR5_TEXT,
          ZMENG                                       as SO_ZMENG, // Target Quantity
          ZIEME                                       as SO_ZIEME, // Target Quantity Unit
          RG_PARTNER                                  as SO_RG_PARTNER,
          COALESCE(RG_PARTNER_NAME1, '') || ' ' || COALESCE(RG_PARTNER_NAME2, '') as SO_RG_PARTNER_NAME : String(80),
          RE_PARTNER                                  as SO_RE_PARTNER,
          COALESCE(RE_PARTNER_NAME1, '') || ' ' || COALESCE(RE_PARTNER_NAME2, '') as SO_RE_PARTNER_NAME : String(80),
          AG_PARTNER_LAND1                            as SO_AG_PARTNER_LAND1,
          AG_PARTNER_LAND1_LANG                       as SO_AG_PARTNER_LAND1_LANG,
          ERNAM                                       as SO_ERNAM,
          GOODS_ISSUE_SLIP_NUMBER                     as DL_GOODS_ISSUE_SLIP_NUMBER,
          ITEM_GROSS_WEIGHT                           as DL_ITEM_GROSS_WEIGHT,
          ITEM_WEIGHT_UNIT                            as DL_ITEM_WEIGHT_UNIT,
          _BASF_YRDSDV1_IMPORT_VALID_TO               as SO_BASF_YRDSDV1_IMPORT_VALID_TO,
          VSTEL                                       as SO_VSTEL      ,
          TM_VBTYP                                    as TM_VBTYP                                         

    };

  entity Results as projection on BaseEntity;
  entity valueHelps as projection on BaseEntity;


  entity notes                   as
    select from db_app.ST_NOTES {
      key UTCTIME,
      key CLIENT,
      key VBELN,
      key POSNR,
          LANGUAGE,
          NOTE_TITLE,
          NOTE_TEXT,
          USERNAME,
          LAST_NOTE_FLAG,
          CLIENT_CHAIN,
          VBELN_CHAIN,
          POSNR_CHAIN
    };

  entity PartnerSettings         as select from db_app.PARTNER_SETTINGS_DB;
  entity ShipmentMarkedDelivered as select from AMOOUtilsService.ShipmentMarkedDelivered;
  entity Variants                as projection on db_app.variants;
  entity VariantsUserSettings    as projection on db_app.variantUserSettings;
  entity variantErrors as projection on db_app.variantErrors;
  entity ChangeDocSet            as projection on CSEUCockpitService.ChangeDocSet;
  entity RegionSettings          as select from db_app.REGION_SETTINGS;
  function getUserRegionAssigned() returns RegionSettings;

  @readonly
  entity AvailableRegions        as projection on db_app.AvailableRegions;

   entity OMDocFlow               as
   select from db_app.ST_OM_DOC_FLOW{
        key SEQUENCE                   : Int16,
        key FIRST_DOCUMENT_MANDT       : String(3) ,
        key FIRST_DOCUMENT             : String(10),
        key FIRST_DOCUMENT_ITEM        : String(6) ,
        key FIRST_DOCUMENT_CATEGORY    : String(1) ,
        key PRECEDING_PO_MANDT         : String(3),
        key PRECEDING_PO               : String(10),
        key PRECEDING_PO_ITEM          : String(5),
        SUBSEQUENT_SO_MANDT            : String(3),
        SUBSEQUENT_SO                  : String(10),
        SUBSEQUENT_SO_ITEM             : String(6),
        FIRST_SO_MANDT                 : String(3),
        FIRST_SO                       : String(10),
        FIRST_SO_ITEM                  : String(6),
        LAST_SO_MANDT                  : String(3),
        LAST_SO                        : String(10),
        LAST_SO_ITEM                   : String(6)
  };
  function getOMDocFlowNodes(salesOrder : String(10), salesOrderItem: String(6), salesOrderSystem: String(3)) returns db_app.OMDocFlowProcessFlow;

  entity VistaShipmentUpdates    as projection on db_app.ST_VISTA_SHIPMENT_ETA_UPDATED ;
}
