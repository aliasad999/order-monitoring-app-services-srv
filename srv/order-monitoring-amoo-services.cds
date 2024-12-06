using openorders.db as db_app from '../db/order-monitoring-amoo-service';
using {OrderChangeService as orderChange} from './external/OrderChangeService';
using {ContactsService as orderContacts} from './external/ContactsService';
// using { CreditManagerService as creditManagerService } from './external/CreditManagerService';
using {DSLServicesService as DSLServicesService} from './external/DSLServicesService';
using {AMOOUtilsService as AMOOUtilsService} from './external/AMOOUtilsService';
using {LORDOdataOrderService as LORDOdataOrderService} from './external/LORDOdataOrderService';
// using { YRDSDV1Foe1Service as YRDSDV1Foe1Service } from './external/YRDSDV1Foe1Service';
// using { ATPService as ATPService } from './external/ATPService';
using {CSEUCockpitService as CSEUCockpitService} from './external/CSEUCockpitService';


service openOrdersSrv {
    entity currencies as projection on db_app.currency;
    entity rootEntity               as
        select from db_app.OPENORDERSLIST {
            key null                                        as id                              : UUID,
                // MANDT                                       as SO_MANDT,
                // FINAL_SO_MANDT as SO_FINAL_SO_MANDT,
                // FIRST_SO_MANDT as SO_FIRST_SO_MANDT,
                // PO_MANDT as PO_MANDT,
                // MANDT_DEL                                   as DL_MANDT,
                // MANDT_TM as TM_MANDT,
                // BL_MANDT_INV_FIRST,
                // BL_MANDT_INV_LAST,
                case BL_MANDT_INV_FIRST
                    when '100' then 'Cobalt'
                    when '200' then 'Star'
                    when '300' then 'AP'
                    else 'No system defined'
                end                                         as BL_MANDT_INV_FIRST                 : String(20),
                case BL_MANDT_INV_LAST
                    when '100' then 'Cobalt'
                    when '200' then 'Star'
                    when '300' then 'AP'
                    else 'No system defined'
                end                                         as BL_MANDT_INV_LAST                 : String(20),
                case MANDT_TM
                    when '100' then 'Cobalt'
                    when '200' then 'Star'
                    when '300' then 'AP'
                    else 'No system defined'
                end                                         as TM_MANDT                 : String(20),
                case MANDT
                    when '100' then 'Cobalt'
                    when '200' then 'Star'
                    when '300' then 'AP'
                    else 'No system defined'
                end                                         as SO_MANDT                 : String(20),
                case MANDT_DEL
                    when '100' then 'Cobalt'
                    when '200' then 'Star'
                    when '300' then 'AP'
                    else 'No system defined'
                end                                         as DL_MANDT                 : String(20),
                case FINAL_SO_MANDT
                    when '100' then 'Cobalt'
                    when '200' then 'Star'
                    when '300' then 'AP'
                    else 'No system defined'
                end                                         as SO_FINAL_SO_MANDT                  : String(20),
                case FIRST_SO_MANDT
                    when '100' then 'Cobalt'
                    when '200' then 'Star'
                    when '300' then 'AP'
                    else 'No system defined'
                end                                         as SO_FIRST_SO_MANDT               : String(20),
                case PO_MANDT
                    when '100' then 'Cobalt'
                    when '200' then 'Star'
                    when '300' then 'AP'
                    else 'No system defined'
                end                                         as PO_MANDT                 : String(20),
                VBELN                                       as SO_VBELN,
                POSNR                                       as SO_POSNR,
                ERDAT_ORDER_DATE                            as SO_ERDAT_ORDER,
                ERDAT_ITEM_DATE                             as SO_ERDAT_ITEM,
                AUART                                       as SO_AUART,
                WERKS                                       as SO_WERKS,
                VTWEG                                       as SO_VTWEG,
                MATNR                                       as SO_MATNR,
                MAKTX_LANG                                  as SO_MAKTX,
                KDMAT                                       as SO_KDMAT,
                AG_PARTNER                                  as SO_AG_PARTNER,
                AG_PARTNER_NAME1 || ' ' || AG_PARTNER_NAME2 as SO_AG_PARTNER_NAME              : String(70),
                WE_PARTNER                                  as SO_WE_PARTNER,
                WE_PARTNER_NAME1 || ' ' || WE_PARTNER_NAME2 as SO_WE_PARTNER_NAME              : String(70),
                LAND1                                       as SO_LAND1,
                LANDX_LANG                                  as SO_LANDX,
                ORT01                                       as SO_ORT01,
                VKORG                                       as SO_VKORG,
                VKORG_NAME1                                 as SO_VKORG_NAME1,
                IFNULL(
                    CO_PARTNER_ITM, CO_PARTNER_HEAD
                )                                           as SO_CO_PARTNER                   : String(10),
                IFNULL(
                    (
                        CO_PARTNER_NAME1_HEAD || CO_PARTNER_NAME2_HEAD
                    ), (
                        CO_PARTNER_NAME1_ITM || CO_PARTNER_NAME2_ITM
                    )
                )                                           as SO_CO_PARTNER_NAME              : String(70),
                IFNULL(
                    NY_PARTNER_ITM, NY_PARTNER_HEAD
                )                                           as SO_NY_PARTNER                   : String(10),
                IFNULL(
                    (
                        NY_PARTNER_NAME1_HEAD || NY_PARTNER_NAME2_HEAD
                    ), (
                        NY_PARTNER_NAME1_ITM || NY_PARTNER_NAME2_ITM
                    )
                )                                           as SO_NY_PARTNER_NAME              : String(70),
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
                KNREF_HEAD                                  as SO_KNREF_HEAD,
                KNREF_ITM                                   as SO_KNREF_ITM,
                case
                    when VBUND is not null and VBUND <> '' 
                    then 'X'
                    else ''
                end                                                      as SO_VBUND                    : String(1),
                EDATU_REQUESTED_DATE                                     as SO_EDATU_REQUESTED,
                KWMENG                                                   as SO_KWMENG,
                VRKME                                                    as SO_VRKME,
                case
                    when EDATU_CONFIRMED_DATE = '00000000' 
                    then null
                    else EDATU_CONFIRMED_DATE end                              as SO_EDATU_CONFIRMED : Date,
                KBMENG                                                   as SO_KBMENG,
                UNCONFIRMED_QTY                                          as SO_UNCONFIRMED_QTY,
                REQ_TEXT                                                 as SO_REQ_TEXT,
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
                    when FAKSP_VTEXT_LANG =  '' or FAKSP_VTEXT_LANG is null 
                    then FAKSK_VTEXT_LANG
                    else FAKSP_VTEXT_LANG
                end                                                      as SO_FAKSP_VTEXT              : String(20),
                SUPPLY_SITUATION                                         as SO_SUPPLY_SITUATION,
                SUPPLY_SITUATION_DESCR                                   as SO_SUPPLY_SITUATION_DESCR,
                IFNULL(KBETR, KBETR_ALT)                                 as SO_KBETR                    : Decimal(11, 2),
                IFNULL(WAERS, WAERS_ALT)                                 as SO_WAERS                    : String(5),
                IFNULL(KPEIN, KPEIN_ALT)                                 as SO_KPEIN                    : Decimal(5),
                IFNULL(KMEIN, KMEIN_ALT)                                 as SO_KMEIN                    : String(3),
                NETWR                                                    as SO_NETWR,
                WAERK                                                    as SO_WAERK,
                HTEXT                                                    as SO_HTEXT,
                PSTYV                                                    as SO_PSTYV,
                PSTYV_VTEXT_LANG                                         as SO_PSTYV_VTEXT,
                DISPO                                                    as SO_DISPO,
                KOSCH                                                    as SO_KOSCH,
                VKBUR                                                    as SO_VKBUR,
                VKBUR_BEZEI_LANG                                         as SO_VKBUR_BEZEI,
                ABGRU                                                    as SO_ABGRU,
                ABGRU_BEZEI_LANG                                         as SO_ABGRU_BEZEI,
                ABSTA                                                    as SO_ABSTA,
                KNUMV                                                    as SO_KNUMV,
                SPART                                                    as SO_SPART,
                IFNULL(INCO1_ITEM, INCO1_HEAD)                           as SO_INCO1                    : String(3),
                IFNULL(INCO2_ITEM, INCO2_HEAD)                           as SO_INCO2                    : String(28),
                IFNULL(ZTERM_ITEM, ZTERM_HEAD)                           as SO_ZTERM                    : String(4),
                case
                    when PRSDT_DATE = '00000000' 
                    then null
                    else PRSDT_DATE end                                  as SO_PRSDT : Date,
                ZZ0S2REVG2                                               as SO_ZZ0S2REVG2,
                ZZDKPPRODB                                               as SO_ZZDKPPRODB,
                BSARK                                                    as SO_BSARK,
                BSARK_VTEXT_LANG                                         as SO_BSARK_VTEXT,
                _BASF_LOFCR                                              as SO_BASF_LOFCR,
                GUSCON_LEVEL                                             as SO_GUSCON_LEVEL,
                FIRST_SO                                                 as SO_I_VBELN,
                FIRST_POSNR                                              as SO_I_POSNR,
                LEVEL_TYPE                                               as SO_LEVEL_TYPE,
                NEXT_SO                                                  as SO_N_VBELN,
                FINAL_SO                                                 as SO_F_VBELN,
                FINAL_POSNR                                              as SO_F_POSNR,
                VBTYP                                                    as SO_VBTYP,
                BSTKD                                                    as SO_BSTKD,
                TRAGR                                                    as SO_TRAGR,
                TRAGR_VTEXT_LANG                                         as SO_TRAGR_VTEXT,
                VKGRP                                                    as SO_VKGRP,
                VKGRP_BEZEI_LANG                                         as SO_VKGRP_BEZEI,
                ROUTE                                                    as SO_ROUTE,
                F_WERKS                                                  as SO_F_WERKS,
                F_VKORG                                                  as SO_F_VKORG,
                F_VKORG_NAME1                                            as SO_F_VKORG_VTEXT,
                IFNULL(F_AS_PARTNER_ITM, F_AS_PARTNER_HEAD)              as SO_F_AS_PARTNER            : String(8),
                IFNULL(F_AS_PARTNER_NAME_ITM, F_AS_PARTNER_NAME_HEAD)    as SO_F_AS_PARTNER_NAME       : String(40),
                F_LDDAT_DATE                                             as SO_F_LDDAT,
                F_LGORT                                                  as SO_F_LGORT,
                case
                    when F_TDDAT_DATE = '00000000' 
                    then null
                    else F_TDDAT_DATE end                                as SO_F_TDDAT : Date,
                F_ZZ0S2MATUG                                             as SO_F_ZZ0S2MATUG,
                F_AUFNR                                                  as SO_F_AUFNR,
                
                case
                    when F_DGLTP_DATE = '00000000' 
                    then null
                    else F_DGLTP_DATE end                                as SO_F_DGLTP : Date,
                
                F_AMEIN                                                  as SO_F_AMEIN,
                F_PSMNG                                                  as SO_F_PSMNG,
                F_VSBED                                                  as SO_F_VSBED,
                F_VSBED_VTEXT_LANG                                       as SO_F_VSBED_VTEXT,
                NOTE_TEXT                                                as LAST_NOTE,
                VBELN_DEL                                                as DL_VBELN,
                POSNR_DEL                                                as DL_POSNR_BATCH,
                POSNR_DEL_HEAD                                           as DL_POSNR,
                CHARG                                                    as DL_CHARG,
                case
                    when HSDAT_DATE = '00000000' 
                    then null
                    else HSDAT_DATE end                                  as DL_HSDAT : Date,
                case
                    when VFDAT_DATE = '00000000' 
                    then null
                    else VFDAT_DATE end                                  as DL_VFDAT : Date,
                LFIMG                                                    as DL_LFIMG_BATCH,
                LFIMG_HEAD                                               as DL_LFIMG,
                VRKME_1                                                  as DL_VRKME,         
                POSAR                                                    as DL_POSAR,              
                VGBEL                                                    as DL_VGBEL,               
                VGPOS                                                    as DL_VGPOS,               
                LFART                                                    as DL_LFART,
                LFART_VTEXT_LANG                                         as DL_LFART_VTEXT,
                case
                    when LFDAT_DATE = '00000000' 
                    then null
                    else LFDAT_DATE end                                  as DL_LFDAT : Date,
                TRAID                                                    as DL_TRAID,
                ZZ0S2BLNR                                                as DL_ZZ0S2BLNR,
                PEND_DEL_QUAN                                            as DL_PEND_DEL_QUAN,
                case
                    when WADAT_DATE = '00000000' 
                    then null
                    else WADAT_DATE end                                  as DL_WADAT : Date,
                case
                    when WADAT_IST_DATE = '00000000' 
                    then null
                    else WADAT_IST_DATE end                              as DL_WADAT_IST : Date,               
                TKNUM                                                    as TM_TKNUM,
                VSART                                                    as TM_VSART,
                VSART_BEZEI_LANG                                         as TM_VSART_BEZEI,
                EXTI1                                                    as TM_EXTI1,
                case
                    when DPTBG_DATE = '00000000' 
                    then null
                    else DPTBG_DATE end                              as TM_DPTBG : Date,
                case
                    when DATBG_DATE = '00000000' 
                    then null
                    else DATBG_DATE end                              as TM_DATBG : Date,
                case
                    when DPTEN_DATE = '00000000' 
                    then null
                    else DPTEN_DATE end                              as TM_DPTEN : Date,
                case
                    when DATEN_DATE = '00000000' 
                    then null
                    else DATEN_DATE end                              as TM_DATEN : Date,
                case
                    when AR_DATE_DATE = '00000000' 
                    then null
                    else AR_DATE_DATE end                              as TM_AR_DATE : Date,
                TDLNR                                                    as TM_TDLNR,
                TDLNR_NAME1                                              as TM_TDLNR_NAME1,
                @UI.Hidden: true
                case
                    when
                        STATUS_REASON_CODE_TEXT_ELEM    =  ''
                        or STATUS_REASON_CODE_TEXT_ELEM is null
                    then
                        STATUS_CODE_TEXT_ELEM
                    else
                        STATUS_CODE_TEXT_ELEM || ' (' || STATUS_REASON_CODE_ELEM || ' - ' || STATUS_REASON_CODE_TEXT_ELEM || ')'
                end                                         as TM_SHIPMENT_CURRENT_STATUS_ELEM : String(250),
                @UI.Hidden: true
                case
                    when
                        REASON_CODE_TEXT_COMP    =  ''
                        or REASON_CODE_TEXT_COMP is null
                    then
                        STATUS_CODE_TEXT_COMP
                    else
                        STATUS_CODE_TEXT_COMP || ' (' || REASON_CODE_COMP || ' - ' || REASON_CODE_TEXT_COMP || ')'
                end                                         as TM_SHIPMENT_CURRENT_STATUS_COMP : String(250),
                case
                    when ALERT_STATUS_REASON_CODE_TEXT_ELEM = '' or ALERT_STATUS_REASON_CODE_TEXT_ELEM is null
                    then ALERT_STATUS_CODE_TEXT_ELEM
                    else ALERT_STATUS_CODE_TEXT_ELEM || '(' || ALERT_STATUS_REASON_CODE_ELEM || ' - ' || ALERT_STATUS_REASON_CODE_TEXT_ELEM || ')'
                end                                                      as TM_SHIPMENT_ALERT               : String(250),
                TRACKING_ID_ELEM                                         as TM_TRACKING_ID_ELEM,
                TRACKING_ID_COMP                                         as TM_TRACKING_ID_COMP,
                STTRG                                                    as TM_STTRG,
                STTRG_DDTEXT_LANG                                        as TM_STTRG_DDTEXT,
                NPS                                                      as SO_NPS,
                virtual null                                             as SO_NPS_DESCRIPTION : String(100),
                ISSUE                                                    as SO_ISSUE,
                virtual null                                             as SO_ISSUE_DESCRIPTION : String(100),
                case
                    when DUE_DATE_FORMATTED = '00000000' 
                    then null
                    else DUE_DATE_FORMATTED end                              as SO_DUE_DATE : Date,
                ISSUE_LOCATION                                           as SO_ISSUE_LOCATION,
                ISSUE_LOCATION_ITEM                                      as SO_ISSUE_LOCATION_ITEM,
                // DCP_ITEM_STATUS                                          as SO_DCP_ITEM_STATUS,     
                // virtual null                                             as SO_DCP_ITEM_STATUS_DESCRIPTION : String(50),
                virtual 0                                   as criticalityDueDate              : Integer,
                IGNORED                                     as SO_IGNORED,
                ETA_UPDATED                                 as TM_SHIPMENT_ETA_UPDATED,
                BL_VBELN_INV_FIRST                          as BL_VBELN_INV_FIRST,
                BL_VBELN_INV_LAST                           as BL_VBELN_INV_LAST,
                case
                    when
                        BL_FKART_LAST = 'Z6OR'
                    then
                        XBLNR
                    else
                        null
                end                                         as BL_XBLNR                        : String(250),

                BL_POSNR_INV_LAST                           as BL_POSNR_INV_LAST,
                BL_POSNR_INV_FIRST                          as BL_POSNR_INV_FIRST,
                BL_FKIMG_FIRST                                           as BL_FKIMG_FIRST,
                BL_FKIMG_LAST                                            as BL_FKIMG_LAST,
                BL_VRKME_FIRST                                           as BL_VRKME_FIRST,
                BL_VRKME_LAST                                            as BL_VRKME_LAST,                     
                BL_FKART_FIRST                                           as BL_FKART_FIRST,
                BL_FKART_LAST                                            as BL_FKART_LAST,
                DOCUMENT_TYPE                                            as SO_DOC_TYP,
                FOLLOWUP_NOTES_LANG                                      as SO_FOLLOWUP_NOTES_LANG,
                REASON_CODE_01_LANG                                      as SO_REASON_CODE_01_LANG,
                REASON_CODE_02_LANG                                      as SO_REASON_CODE_02_LANG,
                REASON_CODE_03_LANG                                      as SO_REASON_CODE_03_LANG,
                REASON_CODE_04_LANG                                      as SO_REASON_CODE_04_LANG,
                REASON_CODE_05_LANG                                      as SO_REASON_CODE_05_LANG,
                DEV_CONF_DATE                                            as SO_DEV_CONF_DATE,
                EMAIL                                                    as SO_EMAIL,
                EMAIL_SEND_DATE_F                                        as SO_EMAIL_SEND_DATE_F,
                EMAIL_SENT_ON                                            as SO_EMAIL_SENT_ON,
                MDB                                                      as SO_MDB,
                MDB_TEXT                                                 as SO_MDB_TEXT,
                case
                    when ERDAT_DEL_DATE = '00000000' 
                    then null
                    else ERDAT_DEL_DATE end                              as DL_ERDAT : Date,
                case
                    when LDDAT_DEL_DATE = '00000000' 
                    then null
                    else LDDAT_DEL_DATE end                              as DL_LDDAT : Date,
                case 
                    when F_MBDAT_DATE = '00000000'
                    then null 
                    else  F_MBDAT_DATE end                               as SO_F_MBDAT : Date,
                PERFK                                       as SO_PERFK,
                PERFK_LTEXT_LANG                            as SO_PERFK_LTEXT_LANG,
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
                PARTNER_9A_HEAD_NAME                        as PO_PARTNER_9A_HEAD_NAME,
                PARTNER_9O_HEAD                             as PO_PARTNER_9O_HEAD,
                PARTNER_9O_HEAD_NAME                        as PO_PARTNER_9O_HEAD_NAME,
                BSART_BATXT                                 as PO_BSART_BATXT
                // BSTNK AS SO_BSTNK
        }

    entity baseEntity               as
        projection on rootEntity {
            *,
            IFNULL(
                TM_SHIPMENT_CURRENT_STATUS_ELEM, TM_SHIPMENT_CURRENT_STATUS_COMP
            ) as TM_SHIPMENT_CURRENT_STATUS : String(250)
        }


    @readonly
    entity allIssues                as projection on baseEntity;

    entity allIssuesDetails         as projection on allIssues;
    entity valueHelps               as projection on baseEntity;
    // entity unrestrictedUser  as projection on db_app.UNRESTRICTED_USER;
    entity orderChangeUsers         as projection on db_app.orderChangeUsers;
    entity ContactSet               as select * from orderContacts.ContactSet;
    entity ContactsOptions          as select * from db_app.ContactsOptions;
    entity ServicesSet              as select * from DSLServicesService.ServicesSet;

    entity FinalOrderLineSet        as
        select from orderChange.FinalOrderLineSet {
            *,
            ''    as BizagiCaseStatus     : String(100),
            ''    as BizagiCaseID         : String(10),
            ''    as BizagiCase           : String(16),
            false as BizagiCaseInProgress : Boolean
        };

    entity ScheduleLineRequestedSet as select * from orderChange.ScheduleLineRequestedSet;
    entity ScheduleLineConfirmedSet as select * from orderChange.ScheduleLineConfirmedSet;
    entity WorkflowPartnerSet       as select * from orderChange.WorkflowPartnerSet;
    entity DeliverySet              as select * from orderChange.DeliverySet;
    entity ShipmentSet              as select * from orderChange.ShipmentSet;
    entity BizagiCaseStatus         as projection on AMOOUtilsService.BizagiCaseStatus;
    entity RejCodesSet              as projection on CSEUCockpitService.RejCodesSet;
    entity LORDHeaderSet            as projection on LORDOdataOrderService.HeaderSet;
    entity LORDItemSet              as projection on LORDOdataOrderService.ItemSet;
    action   submitOrderChange(payload : String)                                                                                                                                                                                                                                                                                             returns String;
    action   submitOrderChangeWF(payload : String)                                                                                                                                                                                                                                                                                           returns String;
    action   cancelOrder(payload : String)                                                                                                                                                                                                                                                                                                   returns String;
    action   RemoveDeliveryBlock(SalesOrderID : String(10), ItemID : String(6))                                                                                                                                                                                                                                                              returns String;
    action   callChatbotService() returns String;

    entity PredefReasonBuckets      as
        select from AMOOUtilsService.PredefinedReasonBuckets {
            key BUCKET      as BucketKey,
            key LANGUAGE    as Language,
                BUCKET_TEXT as BucketText
        };

    entity PredefReasonComments     as
        select from AMOOUtilsService.PredefinedReasonComments {
            key BUCKET      as BucketKey,
            key REASON_CODE as ReasonCodeKey,
            key LANGUAGE    as Language,
                REASON_TEXT as ReasonComment
        };

    entity ReasonComments           as
        select from AMOOUtilsService.APACDelayReasons {
            key ORDER_NUMBER as SalesOrder,
            key ITEM_NUMBER  as OrderItem,
            key BUCKET       as BucketKey,
            key LANGUAGE     as Language,
                REASON_CODE  as ReasonCodeKey
        };

    entity PredefFollowupNotes      as
        select from AMOOUtilsService.PredefinedFollowupNotes {
            PREDEFINED_ID      as FollowUpNoteId,
            PREDEFINED_CONTENT as FollowUpNoteContent,
            LANGUAGE           as Language
        };

    entity FollowupNotes            as
        select from AMOOUtilsService.FollowupNotes {
            ORDER_NUMBER  as SalesOrder,
            ORDER_ITEM    as OrderItem,
            PREDEFINED_ID as FollowupNote,
            CREATED_AT    as CreatedAt
        };

    entity dueDateLimit             as projection on db_app.DUE_DATE_LIMIT;
    entity ChangeDocSet             as projection on CSEUCockpitService.ChangeDocSet
    entity ShipmentUpdates          as projection on AMOOUtilsService.ShipmentUpdates;

    // Sales order details from generic service
    entity salesOrderDetails        as
        select * from db_app.SALESORDER_DETAILS (
            IP_LANG:LEFT(
                UPPER(
                    $user.locale
                ),
            )
        );

    entity ignoreSalesOrder         as projection on db_app.IGNORED_SO;
    function getIssueReason(salesOrder : String(10), salesOrderItem : String(6), detailsSalesOrder : String(10), DetailsSalesOrderItem : String(6), issue : String(2), nps : String(3), issue_location : String(12), material : String(18), plant : String(4), quantity : Decimal(13, 3), uom : String(3), dueDate : Date, firstDate : Date) returns array of db_app.issue_reason;
    action   createDeliveryforAllItem(salesOrder : String(10))  returns Boolean;
    action   createDeliveryforItem(salesOrder : String(10), salesOrderItem : String(6)) returns Boolean;
    @readonly
    entity orderCreation as projection on db_app.ORDER_CREATION{
        key case MANDT
            when '100' then 'Cobalt'
            when '200' then 'Star'
            when '300' then 'AP'
            else 'No system defined'
        end                                         as PO_MANDT                 : String(20),
        key EBELN AS PO_EBELN,
        key EBELP AS PO_EBELP,
        case
            when AEDAT_HEAD_DATE = '00000000' then null
            else AEDAT_HEAD_DATE
        end                                         as PO_AEDAT_HEAD                   : Date,
        case
            when AEDAT_ITEM_DATE = '00000000' then null
            else AEDAT_ITEM_DATE
        end                                         as PO_AEDAT_ITEM                   : Date,
        BSART AS PO_BSART,
        EKORG AS PO_EKORG,
        EKOTX AS PO_EKOTX,
        EKGRP AS PO_EKGRP,
        EKNAM AS PO_EKNAM,
        EMATN AS PO_EMATN,
        WERKS AS PO_WERKS,
        MENGE AS PO_MENGE,
        MEINS AS PO_MEINS,
        KUNNR AS PO_KUNNR,
        KUNNR_NAME1 || ' ' || KUNNR_NAME2           as PO_KUNNR_NAME                   : String(80),
        PARTNER_9A_HEAD AS PO_PARTNER_9A_HEAD,
        PARTNER_9A_HEAD_NAME AS PO_PARTNER_9A_HEAD_NAME,
        PARTNER_9O_HEAD AS PO_PARTNER_9O_HEAD,
        PARTNER_9O_HEAD_NAME AS PO_PARTNER_9O_HEAD_NAME,
        BSART_BATXT AS PO_BSART_BATXT,
        NPS AS PO_NPS,
        case NPS
            when '01' then 'Order Creation'
            else ''
        end as PO_NPS_TEXT : String(30),
        ISSUE AS PO_ISSUE,
        case ISSUE
            when '40' then 'Sales Order Creation Outstanding'
            when '41' then 'Error During Sales Order Creation'
            else ''
        end as PO_ISSUE_TEXT : String(60),
        DUE_DATE_FORMATTED AS PO_DUE_DATE,
        ERROR_TEXT AS PO_ERROR_TEXT,
        BIM_ERROR_ID AS PO_BIM_ERROR_ID
    } ;
};
