using allorders.db as db_app from '../db/order-monitoring-amo-service';
using {AMOOUtilsService as AMOOUtilsService} from './external/AMOOUtilsService';

service srvOpenOrders {

  entity VBAKAuthObjectKeys      as select from db_app.VBAKAUTH;
  entity EKKOAuthObjectKeys      as select from db_app.EKKOAUTH;
  function getVBAKAuthObjKeys() returns Integer;

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
          FINAL_SO_MANDT as SO_FINAL_SO_MANDT,
          FIRST_SO_MANDT as SO_FIRST_SO_MANDT,
          PO_MANDT,
          virtual null                                as SO_MANDT_TEXT  : String(20),
          virtual null                                as DL_MANDT_TEXT  : String(20),
          virtual null                                as TM_MANDT_TEXT  : String(20),
          virtual null                                as BL_MANDT_INV_FIRST_TEXT  : String(20),
          virtual null                                as BL_MANDT_INV_LAST_TEXT  : String(20),
          virtual null                                as SO_FINAL_SO_MANDT_TEXT  : String(20),
          virtual null                                as SO_FIRST_SO_MANDT_TEXT  : String(20),
          virtual null                                as PO_MANDT_TEXT  : String(20),
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
          IFNULL(
            CO_PARTNER_ITM, CO_PARTNER_HEAD
          )                                           as SO_CO_PARTNER                   : String(10),
          IFNULL(
            (
              CO_PARTNER_NAME1_ITM || CO_PARTNER_NAME2_ITM
            ), (
              CO_PARTNER_NAME1_HEAD || CO_PARTNER_NAME2_HEAD
            )
          )                                           as SO_CO_PARTNER_NAME              : String(80),
          IFNULL(
            NY_PARTNER_ITM, NY_PARTNER_HEAD
          )                                           as SO_NY_PARTNER                   : String(10),
          IFNULL(
            (
              NY_PARTNER_NAME1_ITM || NY_PARTNER_NAME2_ITM
            ), (
              NY_PARTNER_NAME1_HEAD || NY_PARTNER_NAME2_HEAD
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
            when
              VBUND     is not null
              and VBUND <>     ''
            then
              'X'
            else
              ''
          end                                         as SO_VBUND                        : String(1),
          SO_EDATU_REQUESTED_DATE                     as SO_EDATU_REQUESTED,
          KWMENG                                      as SO_KWMENG,
          VRKME                                       as SO_VRKME,
          SO_EDATU_CONFIRMED_DATE as SO_EDATU_CONFIRMED,
          // case
          //   when
          //     SO_EDATU_CONFIRMED_DATE = '00000000'
          //   then
          //     null
          //   else
          //     SO_EDATU_CONFIRMED_DATE
          // end                                         as SO_EDATU_CONFIRMED              : Date,
          KBMENG                                      as SO_KBMENG,
          UNCONFIRMED_QTY                             as SO_UNCONFIRMED_QTY,
          REQ_TEXT                                    as SO_REQ_TEXT,
          case
            when
              FAKSP    =  ''
              or FAKSP is null
            then
              FAKSK
            else
              FAKSP
          end                                         as SO_FAKSP                        : String(2),
          case
            when
              FAKSP_VTEXT_LANG    =  ''
              or FAKSP_VTEXT_LANG is null
            then
              FAKSK_VTEXT_LANG
            else
              FAKSP_VTEXT_LANG
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
          SO_PRSDT_DATE as SO_PRSDT,
          // case
          //   when
          //     SO_PRSDT_DATE = '00000000'
          //   then
          //     null
          //   else
          //     SO_PRSDT_DATE
          // end                                         as SO_PRSDT                        : Date,
          ZZ0S2REVG2                                  as SO_ZZ0S2REVG2,
          ZZDKPPRODB                                  as SO_ZZDKPPRODB,
          BSARK                                       as SO_BSARK,
          BSARK_VTEXT_LANG                            as SO_BSARK_VTEXT,
          _BASF_LOFCR                                 as SO_BASF_LOFCR,
          GUSCON_LEVEL                                as SO_GUSCON_LEVEL,
          FIRST_SO                                    as SO_I_VBELN,
          ISCOMPLETED                                 as SO_ISCOMPLETED,
          LEVEL_TYPE                                  as SO_LEVEL_TYPE,
          NEXT_SO                                     as SO_N_VBELN,
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
          SO_F_TDDAT_DATE as SO_F_TDDAT,
          // case
          //   when
          //     SO_F_TDDAT_DATE = '00000000'
          //   then
          //     null
          //   else
          //     SO_F_TDDAT_DATE
          // end                                         as SO_F_TDDAT                      : Date,
          F_ZZ0S2MATUG                                as SO_F_ZZ0S2MATUG,
          F_VSBED                                     as SO_F_VSBED,
          F_VSBED_VTEXT_LANG                          as SO_F_VSBED_VTEXT,
          F_AUFNR                                     as SO_F_AUFNR,
          SO_F_DGLTP_DATE as SO_F_DGLTP,
          // case
          //   when
          //     SO_F_DGLTP_DATE = '00000000'
          //   then
          //     null
          //   else
          //     SO_F_DGLTP_DATE
          // end                                         as SO_F_DGLTP                      : Date,
          F_PSMNG                                     as SO_F_PSMNG,
          F_AMEIN                                     as SO_F_AMEIN,
          SO_F_LDDAT_DATE as SO_F_LDDAT,
          // case
          //   when
          //     SO_F_LDDAT_DATE = '00000000'
          //   then
          //     null
          //   else
          //     SO_F_LDDAT_DATE
          // end                                         as SO_F_LDDAT                      : Date,

          IFNULL(
            F_AS_PARTNER_ITM, F_AS_PARTNER_HEAD
          )                                           as SO_F_AS_PARTNER                 : String(8),
          IFNULL(
            F_AS_PARTNER_NAME_ITM, F_AS_PARTNER_NAME_HEAD
          )                                           as SO_F_AS_PARTNER_NAME            : String(40),
          DCP_ITEM_STATUS                    as SO_DCP_ITEM_STATUS,
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
          DL_LFDAT_DATE as DL_LFDAT,
          DL_HSDAT_DATE as DL_HSDAT,
          DL_VFDAT_DATE as DL_VFDAT,
          // case
          //   when
          //     DL_LFDAT_DATE = '00000000'
          //   then
          //     null
          //   else
          //     DL_LFDAT_DATE
          // end                                         as DL_LFDAT                        : Date,

          // case
          //   when
          //     DL_HSDAT_DATE = '00000000'
          //   then
          //     null
          //   else
          //     DL_HSDAT_DATE
          // end                                         as DL_HSDAT                        : Date,
          // case
          //   when
          //     DL_VFDAT_DATE = '00000000'
          //   then
          //     null
          //   else
          //     DL_VFDAT_DATE
          // end                                         as DL_VFDAT                        : Date,

          TRAID                                       as DL_TRAID,
          ZZ0S2BLNR                                   as DL_ZZ0S2BLNR,
          PEND_DEL_QUAN                               as DL_PEND_DEL_QUAN,
          DL_WADAT_DATE as DL_WADAT,
          DL_WADAT_IST_DATE as DL_WADAT_IST,
          // case
          //   when
          //     DL_WADAT_DATE = '00000000'
          //   then
          //     null
          //   else
          //     DL_WADAT_DATE
          // end                                         as DL_WADAT                        : Date,
          // case
          //   when
          //     DL_WADAT_IST_DATE = '00000000'
          //   then
          //     null
          //   else
          //     DL_WADAT_IST_DATE
          // end                                         as DL_WADAT_IST                    : Date,
          NOTE_TEXT                                   as LAST_NOTE,
          TKNUM                                       as TM_TKNUM,
          VSART                                       as TM_VSART,
          VSART_BEZEI_LANG                            as TM_VSART_BEZEI,
          EXTI1                                       as TM_EXTI1,
          TDLNR                                       as TM_TDLNR,
          TDLNR_NAME1                                 as TM_TDLNR_NAME1,
          @UI.Hidden: true
          case
            when
              (
                STATUS_REASON_CODE_TEXT_ELEM    is null
                or STATUS_REASON_CODE_TEXT_ELEM =  ''
              )
            then
              STATUS_CODE_TEXT_ELEM
            else
              STATUS_CODE_TEXT_ELEM || ' (' || STATUS_REASON_CODE_ELEM || ' - ' || STATUS_REASON_CODE_TEXT_ELEM || ')'
          end                                         as TM_SHIPMENT_CURRENT_STATUS_ELEM : String(250),
          @UI.Hidden: true
          case
            when
              (
                REASON_CODE_TEXT_COMP    is null
                or REASON_CODE_TEXT_COMP =  ''
              )
            then
              STATUS_CODE_TEXT_COMP
            else
              STATUS_CODE_TEXT_COMP || ' (' || REASON_CODE_COMP || ' - ' || REASON_CODE_TEXT_COMP || ')'
          end                                         as TM_SHIPMENT_CURRENT_STATUS_COMP : String(250),

          case
            when
              (
                ALERT_STATUS_REASON_CODE_TEXT_ELEM    is null
                or ALERT_STATUS_REASON_CODE_TEXT_ELEM =  ''
              )
            then
              ALERT_STATUS_CODE_TEXT_ELEM
            else
              ALERT_STATUS_CODE_TEXT_ELEM || '(' || ALERT_STATUS_REASON_CODE_ELEM || ' - ' || ALERT_STATUS_REASON_CODE_TEXT_ELEM || ')'
          end                                         as TM_SHIPMENT_ALERT               : String(250),
          TRACKING_ID_ELEM                            as TM_TRACKING_ID_ELEM,
          TRACKING_ID_COMP                            as TM_TRACKING_ID_COMP,
          TM_DPTBG_DATE as TM_DPTBG,
          TM_DATBG_DATE as TM_DATBG,
          TM_DPTEN_DATE as TM_DPTEN,
          TM_DATEN_DATE as TM_DATEN,
          TM_AR_DATE_DATE as TM_AR_DATE,
          TM_DALBG_DATE as TM_DALBG,
          // case
          //   when
          //     TM_DPTBG_DATE = '00000000'
          //   then
          //     null
          //   else
          //     TM_DPTBG_DATE
          // end                                         as TM_DPTBG                        : Date,
          // case
          //   when
          //     TM_DATBG_DATE = '00000000'
          //   then
          //     null
          //   else
          //     TM_DATBG_DATE
          // end                                         as TM_DATBG                        : Date,
          // case
          //   when
          //     TM_DPTEN_DATE = '00000000'
          //   then
          //     null
          //   else
          //     TM_DPTEN_DATE
          // end                                         as TM_DPTEN                        : Date,
          // case
          //   when
          //     TM_DATEN_DATE = '00000000'
          //   then
          //     null
          //   else
          //     TM_DATEN_DATE
          // end                                         as TM_DATEN                        : Date,
          // case
          //   when
          //     TM_AR_DATE_DATE = '00000000'
          //   then
          //     null
          //   else
          //     TM_AR_DATE_DATE
          // end                                         as TM_AR_DATE                      : Date,
          STTRG                                       as TM_STTRG,
          STTRG_DDTEXT_LANG                           as TM_STTRG_DDTEXT,
          BL_VBELN_INV_FIRST                          as BL_VBELN_INV_FIRST,
          BL_POSNR_INV_FIRST                          as BL_POSNR_INV_FIRST,
          BL_VBELN_INV_LAST                           as BL_VBELN_INV_LAST,
          BL_POSNR_INV_LAST                           as BL_POSNR_INV_LAST,
          XBLNR                                       as BL_XBLNR,
          
          ERDAT_DEL_DATE as DL_ERDAT,
          LDDAT_DEL_DATE as DL_LDDAT,
          F_MBDAT_DATE as SO_F_MBDAT,
          // case
          //   when
          //     ERDAT_DEL_DATE = '00000000'
          //   then
          //     null
          //   else
          //     ERDAT_DEL_DATE
          // end                                         as DL_ERDAT                        : Date,
          // case
          //   when
          //     LDDAT_DEL_DATE = '00000000'
          //   then
          //     null
          //   else
          //     LDDAT_DEL_DATE
          // end                                         as DL_LDDAT                        : Date,
          PERFK                                       as SO_PERFK,
          PERFK_LTEXT_LANG                            as SO_PERFK_LTEXT_LANG,
          // case
          //   when
          //     F_MBDAT_DATE = '00000000'
          //   then
          //     null
          //   else
          //     F_MBDAT_DATE
          // end                                         as SO_F_MBDAT                      : Date,
          
          
          EBELN                                       as PO_EBELN,
          EBELP                                       as PO_EBELP,
          case
            when
              AEDAT_HEAD_DATE = '00000000'
            then
              null
            else
              AEDAT_HEAD_DATE
          end                                         as PO_AEDAT_HEAD                   : Date,
          case
            when
              AEDAT_ITEM_DATE = '00000000'
            then
              null
            else
              AEDAT_ITEM_DATE
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
          // PARTNER_9A_HEAD_NAME                        as PO_PARTNER_9A_HEAD_NAME,
          PARTNER_9O_HEAD                             as PO_PARTNER_9O_HEAD,
          // PARTNER_9O_HEAD_NAME                        as PO_PARTNER_9O_HEAD_NAME,
          BSART_BATXT                                 as PO_BSART_BATXT,
          // BSTNK AS SO_BSTNK
          TRMTYP                                      as DL_TRMTYP,
          TRMTYP_MAKTX_LANG                           as DL_TRMTYP_MAKTX,
          ZZ0S2ABGH                                   as DL_ZZ0S2ABGH,
          ZZ0S2ZIEH                                   as DL_ZZ0S2ZIEH

    };

  entity Results                 as
    projection on BaseEntity {
      *,
      IFNULL(
        TM_SHIPMENT_CURRENT_STATUS_ELEM, TM_SHIPMENT_CURRENT_STATUS_COMP
      ) as TM_SHIPMENT_CURRENT_STATUS : String(250)
    };

  entity valueHelps              as
    projection on BaseEntity {
      *,
      IFNULL(
        TM_SHIPMENT_CURRENT_STATUS_ELEM, TM_SHIPMENT_CURRENT_STATUS_COMP
      ) as TM_SHIPMENT_CURRENT_STATUS : String(250)
    };


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
          LAST_NOTE_FLAG
    };

  entity PartnerSettings         as select from db_app.PARTNER_SETTINGS_DB;
  entity ShipmentMarkedDelivered as select from AMOOUtilsService.ShipmentMarkedDelivered;
  entity Variants                as projection on db_app.variants;
  entity VariantsUserSettings                as projection on db_app.variantUserSettings;
}
