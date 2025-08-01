namespace allorders.db;


entity SAPSystems {
        key mandantKey : String(3);
            mandantText: String(20);
}

entity DCPStatus{
        key DCPStatusKey: String(2);
            DCPStatusText: localized String(50);
}

@cds.persistence.exists
entity ![RESULTS] {

        MANDT                              : String(3);
        VBELN                              : String(10);
        POSNR                              : String(6);
        ERDAT_ORDER                        : String(8);
        SO_ERDAT_ORDER_DATE                : Date = ERDAT_ORDER;
        ERDAT_ITEM                         : String(8);
        SO_ERDAT_ITEM_DATE                 : Date = ERDAT_ITEM;
        AUART                              : String(4);
        WERKS                              : String(4);
        VTWEG                              : String(2);
        MATNR                              : String(18);
        MAKTX_LANG                         : String(40);
        KDMAT                              : String(35);
        AG_PARTNER                         : String(10);
        AG_PARTNER_NAME1                   : String(40);
        AG_PARTNER_NAME2                   : String(40);
        WE_PARTNER                         : String(10);
        WE_PARTNER_NAME1                   : String(40);
        WE_PARTNER_NAME2                   : String(40);
        CO_PARTNER_HEAD                    : String(10);
        CO_PARTNER_NAME1_HEAD              : String(40);
        CO_PARTNER_NAME2_HEAD              : String(40);
        CO_PARTNER_ITM                     : String(10);
        CO_PARTNER_NAME1_ITM               : String(40);
        CO_PARTNER_NAME2_ITM               : String(40);
        NY_PARTNER_HEAD                    : String(10);
        NY_PARTNER_NAME1_HEAD              : String(40);
        NY_PARTNER_NAME2_HEAD              : String(40);
        NY_PARTNER_ITM                     : String(10);
        NY_PARTNER_NAME1_ITM               : String(40);
        NY_PARTNER_NAME2_ITM               : String(40);
        AS_PARTNER_HEAD                    : String(8);
        AS_PARTNER_NAME_HEAD               : String(40);
        AS_PARTNER_ITM                     : String(8);
        AS_PARTNER_NAME_ITM                : String(40);
        VE_PARTNER_HEAD                    : String(8);
        VE_PARTNER_NAME_HEAD               : String(40);
        VE_PARTNER_ITM                     : String(8);
        VE_PARTNER_NAME_ITM                : String(40);
        AM_PARTNER_HEAD                    : String(8);
        AM_PARTNER_NAME_HEAD               : String(40);
        AM_PARTNER_ITM                     : String(8);
        AM_PARTNER_NAME_ITM                : String(40);
        LAND1                              : String(3);
        LANDX_LANG                         : String(15);
        ORT01                              : String(35);
        VKORG                              : String(4);
        VKORG_NAME1                        : String(40);
        KNREF_HEAD                         : String(30);
        KNREF_ITM                          : String(30);
        VBUND                              : String(6);
        EDATU_REQUESTED                    : String(8);
        SO_EDATU_REQUESTED_DATE            : Date = EDATU_REQUESTED;
        KWMENG                             : Decimal(15, 3);
        VRKME                              : String(3);
        EDATU_CONFIRMED                    : String(8);
        SO_EDATU_CONFIRMED_DATE            : Date = EDATU_CONFIRMED;
        KBMENG                             : Decimal(15, 3);
        UNCONFIRMED_QTY                    : Decimal(15, 3);
        REQ_TEXT                           : String(250);
        FAKSP                              : String(2);
        FAKSP_VTEXT_LANG                   : String(20);
        F_LGORT                            : String(4);
        SUPPLY_SITUATION                   : Int16;
        SUPPLY_SITUATION_DESCR             : String(60);
        KBETR                              : Decimal(11, 2);
        KBETR_ALT                          : Decimal(11, 2);
        WAERS                              : String(5);
        WAERS_ALT                          : String(5);
        KPEIN                              : Decimal(5);
        KPEIN_ALT                          : Decimal(5);
        KMEIN                              : String(3);
        KMEIN_ALT                          : String(3);
        NETWR                              : Decimal(15, 2);
        WAERK                              : String(5);
        HTEXT                              : String(4000);
        PSTYV                              : String(4);
        PSTYV_VTEXT_LANG                   : String(20);
        DISPO                              : String(3);
        KOSCH                              : String(18);
        VKBUR                              : String(4);
        VKBUR_BEZEI_LANG                   : String(20);
        ABGRU                              : String(2);
        ABSTA                              : String(1);
        KNUMV                              : String(10);
        SPART                              : String(2);
        INCO1_HEAD                         : String(3);
        INCO1_ITEM                         : String(3);
        INCO2_HEAD                         : String(28);
        INCO2_ITEM                         : String(28);
        ZTERM_HEAD                         : String(4);
        ZTERM_ITEM                         : String(4);
        PRSDT                              : String(8);
        SO_PRSDT_DATE                      : Date = PRSDT;
        ZZ0S2REVG2                         : String(10);
        ZZDKPPRODB                         : String(18);
        BSARK                              : String(4);
        BSARK_VTEXT_LANG                   : String(20);
        _BASF_LOFCR                        : String(20);
        GUSCON                             : String(15);
        GUSCON_ITM                         : String(6);
        GUSCON_LEVEL                       : String(2);
        FIRST_SO                           : String(10);
        FIRST_POSNR                        : String(6);
        ISCOMPLETED                        : String(1);
        LEVEL_TYPE                         : String(1);
        NEXT_SO                            : String(10);
        NEXT_POSNR                         : String(6);
        FINAL_SO                           : String(10);
        FINAL_POSNR                        : String(6);
        VBTYP                              : String(1);
        BSTKD                              : String(35);
        TRAGR                              : String(4);
        TRAGR_VTEXT_LANG                   : String(20);
        VKGRP                              : String(3);
        VKGRP_BEZEI_LANG                   : String(20);
        ROUTE                              : String(6);
        FAKSK                              : String(2);
        FAKSK_VTEXT_LANG                   : String(20);
        F_WERKS                            : String(4);
        F_VKORG                            : String(4);
        F_VKORG_NAME1                      : String(40);
        F_TDDAT                            : String(8);
        SO_F_TDDAT_DATE                    : Date = F_TDDAT;
        F_ZZ0S2MATUG                       : String(18);
        F_VSBED                            : String(2);
        F_VSBED_VTEXT_LANG                 : String(20);
        F_AUFNR                            : String(12);
        F_DGLTP                            : String(8);
        SO_F_DGLTP_DATE                    : Date = F_DGLTP;
        F_PSMNG                            : Decimal(13, 3);
        F_AMEIN                            : String(3);
        F_LDDAT                            : String(8);
        SO_F_LDDAT_DATE                    : Date = F_LDDAT;
        F_AS_PARTNER_HEAD                  : String(8);
        F_AS_PARTNER_NAME_HEAD             : String(40);
        F_AS_PARTNER_ITM                   : String(8);
        F_AS_PARTNER_NAME_ITM              : String(40);
        VBELN_DEL                          : String(10);
        POSNR_DEL_HEAD                     : String(6);
        LFIMG_HEAD                         : Decimal(15, 3);
        POSNR_DEL                          : String(6);
        CHARG                              : String(10);
        LFIMG                              : Decimal(13, 3);
        VRKME_1                            : String(3);
        POSAR                              : String(1);
        VGBEL                              : String(10);
        VGPOS                              : String(6);
        LFART                              : String(4);
        LFART_VTEXT_LANG                   : String(20);
        LFDAT                              : String(8);
        DL_LFDAT_DATE                      : Date = LFDAT;
        HSDAT                              : String(8);
        DL_HSDAT_DATE                      : Date = HSDAT;
        VFDAT                              : String(8);
        DL_VFDAT_DATE                      : Date = VFDAT;
        TRAID                              : String(20);
        ZZ0S2BLNR                          : String(30);
        PEND_DEL_QUAN                      : String(500);
        WADAT                              : String(8);
        DL_WADAT_DATE                      : Date = WADAT;
        WADAT_IST                          : String(8);
        DL_WADAT_IST_DATE                  : Date = WADAT_IST;
        NOTE_TEXT                          : String(1000);
        // LANGUAGE                           : String(2);
        TKNUM                              : String(10);
        VSART                              : String(2);
        VSART_BEZEI_LANG                   : String(20);
        EXTI1                              : String(35);
        TDLNR                              : String(10);
        TDLNR_NAME1                        : String(81);
        STATUS_CODE_ELEM                   : String(3);
        STATUS_REASON_CODE_ELEM            : String(3);
        STATUS_CODE_TEXT_ELEM              : String(255);
        STATUS_REASON_CODE_TEXT_ELEM       : String(255);
        TRACKING_ID_ELEM                   : String(12);
        ALERT_STATUS_CODE_ELEM             : String(3);
        ALERT_STATUS_REASON_CODE_ELEM      : String(3);
        ALERT_STATUS_CODE_TEXT_ELEM        : String(255);
        ALERT_STATUS_REASON_CODE_TEXT_ELEM : String(255);
        STATUS_CODE_COMP                   : String(3);
        REASON_CODE_COMP                   : String(17);
        STATUS_CODE_TEXT_COMP              : String(100);
        REASON_CODE_TEXT_COMP              : String(100);
        TRACKING_ID_COMP                   : String(50);
        STATUS_CODE_MANUEL                 : String(3);
        DPTBG                              : String(8);
        TM_DPTBG_DATE                      : Date = DPTBG;
        DATBG                              : String(8);
        TM_DATBG_DATE                      : Date = DATBG;
        DPTEN                              : String(8);
        TM_DPTEN_DATE                      : Date = DPTEN;
        DALBG                              : String(8);
        TM_DALBG_DATE                      : Date = DALBG;
        DATEN                              : String(8);
        TM_DATEN_DATE                      : Date = DATEN;
        AR_DATE                            : String(8);
        TM_AR_DATE_DATE                    : Date = AR_DATE;
        STTRG                              : String(2);
        STTRG_DDTEXT_LANG                  : String(60);
        BL_VBELN_INV_FIRST                 : String(10);
        BL_POSNR_INV_FIRST                 : String(6);
        BL_VBELN_INV_LAST                  : String(10);
        BL_POSNR_INV_LAST                  : String(6);
        XBLNR                              : String(16);
        MANDT_DEL                          : String(3);
        TM_MANDT                           : String(3);
        BL_MANDT_INV_FIRST                 : String(3);
        BL_MANDT_INV_LAST                  : String(3);
        ABGRU_BEZEI_LANG                   : String(40);
        DCP_ITEM_STATUS                    : String(2);
        ERDAT_DEL                          : String(8);
        ERDAT_DEL_DATE                     : Date = ERDAT_DEL;
        LDDAT_DEL                          : String(8);
        LDDAT_DEL_DATE                     : Date = LDDAT_DEL;
        PERFK                              : String(2);
        PERFK_LTEXT_LANG                   : String(50);
        F_MBDAT                            : String(8);
        F_MBDAT_DATE                       : Date = F_MBDAT;
        FINAL_SO_MANDT                     : String(3);
        FIRST_SO_MANDT                     : String(3);
        PO_MANDT                           : String(3);
        EBELN                              : String(10);
        EBELP                              : String(5);
        AEDAT_HEAD                         : String(8);
        AEDAT_HEAD_DATE                    : Date = AEDAT_HEAD;
        AEDAT_ITEM                         : String(8);
        AEDAT_ITEM_DATE                    : Date = AEDAT_ITEM;
        BSART                              : String(4);
        EKORG                              : String(4);
        EKOTX                              : String(20);
        EKGRP                              : String(3);
        EKNAM                              : String(18);
        EMATN                              : String(18);
        WERKS_PO                           : String(4);
        MENGE                              : Decimal(13, 3);
        MEINS                              : String(3);
        KUNNR                              : String(10);
        KUNNR_NAME1                        : String(35);
        KUNNR_NAME2                        : String(35);
        PARTNER_9A_HEAD                    : String(12);
        PARTNER_9A_HEAD_NAME               : String(80);
        PARTNER_9O_HEAD                    : String(12);
        PARTNER_9O_HEAD_NAME               : String(80);
        BSART_BATXT                        : String(20);
        BSTNK                              : String(20);
        TRMTYP                             : String(18);
        TRMTYP_MAKTX_LANG                  : String(40);
        ZZ0S2ABGH                          : String(10);
        ZZ0S2ZIEH                          : String(10);
        BL_ERDAT_FIRST                     : String(8);
        BL_ERDAT_FIRST_DATE                : Date = BL_ERDAT_FIRST;
        BL_ERDAT_LAST                      : String(8);
        BL_ERDAT_LAST_DATE                 : Date = BL_ERDAT_LAST;
        BL_FKIMG_LAST                      : String(8);
        BL_NETWR_LAST                      : Decimal(15, 2);
        BL_WAERK_LAST                      : String(5);
        BL_VRKME_LAST                      : String(3);
        LPRIO                              : String(2);
        VISTA_STATUS                       : String(50);
        CURRENT_ETA_VISTA                  : String(8);
        CURRENT_ETA_VISTA_DATE             : Date = CURRENT_ETA_VISTA;
        // Euan's changes
        Z5_PARTNER_ITM                     : String(8);
        Z5_PARTNER_NAME_ITM                : String(40);
        SB_PARTNER_ITM                     : String(8);
        SB_PARTNER_NAME_ITM                : String(40);
        AD_PARTNER_HEAD                    : String(8);
        AD_PARTNER_NAME_HEAD               : String(40);
        AD_PARTNER_ITM                     : String(8);
        AD_PARTNER_NAME_ITM                : String(40);
        // End of Euan's changes
        BNAME                              : String(35);
        IHREZ                              : String(35);
        AUGRU                              : String(3);
        AUGRU_BEZEI_LANG                   : String(40);
        KDGRP                              : String(2);
        KDGRP_KTEXT_LANG                   : String(20);
        WE_PARTNER_REGION                  : String(3);
        WE_PARTNER_REGION_BEZEI_LANG       : String(20);
        PRCTR                              : String(10);
        TO_PARTNER_HEAD                    : String(10);
        TO_PARTNER_ITM                     : String(10);
        TO_PARTNER_NAME1_HEAD              : String(40);
        TO_PARTNER_NAME2_HEAD              : String(40);
        TO_PARTNER_NAME1_ITM               : String(40);
        TO_PARTNER_NAME2_ITM               : String(40);
        ETA_UPDATED                        : String(3);
        FOLLOWUP_NOTES_LANG                : String(50);
        REASON_CODE_01_LANG                : String(255);
        REASON_CODE_02_LANG                : String(255);
        REASON_CODE_03_LANG                : String(255);
        REASON_CODE_04_LANG                : String(255);
        REASON_CODE_05_LANG                : String(255);
        DEV_CONF_DATE                      : String(12);
        EMAIL                              : String(241);
        EMAIL_SEND_DATE_F                  : String(8);
        EMAIL_SENT_ON                      : String(8);
        DPLBG_TM                           : String(8);
        DPLBG_TM_DATE                      : Date = DPLBG_TM;
        ERDAT_TM                           : String(8);
        ERDAT_TM_DATE                      : Date = ERDAT_TM;
        DPREG_TM                           : String(8);
        DPREG_TM_DATE                      : Date = DPREG_TM;
        WERKS_DEL                          : String(4);
        VKORG_DEL                          : String(4);
        VMSTA                              : String(2);
        ZZ0S2VGANN                         : String(35);
        ZZ0S2LOANN                         : String(35);
        PO_REQ_DEL_DATE                    : String(8);
        PO_REQ_DEL_DATE_FORMATTED          : Date = PO_REQ_DEL_DATE;
        AB_CONF_DATE                       : String(8);
        AB_CONF_DATE_FORMATTED             : Date = AB_CONF_DATE;
        LA_CONF_DATE                       : String(8);
        LA_CONF_DATE_FORMATTED             : Date = LA_CONF_DATE;
        ZD_CONF_DATE                       : String(8);
        ZD_CONF_DATE_FORMATTED             : Date = ZD_CONF_DATE;
        ZZATP_CUST                         : String(15);
        ETA_EVENT_SOURCE                   : String(30);
        CONTRACT                           : String(10);
        CONTRACT_ITEM                      : String(6);
        ZZMHDRZ                            : Decimal(4);
        ZTERM_HEAD_VTEXT_LANG              : String(30);
        ZTERM_ITEM_VTEXT_LANG              : String(30);  
        SEED_COUNT                         : Decimal(31, 14);
        SEEDS_TAGGED_GERM                  : Decimal(31, 14);
        XREF3                              : String(20);
        ABLAD                              : String(25);
        DGSTA                              : String(1);
        MVGR2                              : String(9);
        VALDT                              : String(8);
        VALDT_DATE                         : Date = VALDT;
        MVGR2_BEZEI_LANG                   : String(40);
        DGSTA_DDTEXT_LANG                  : String(60);

}

entity PARTNER_SETTINGS {
        CLIENT         : String(3);
        BASF_USER      : String(12);
        PARTNER_ROLE   : String(2);
        PARTNER_NUMBER : String(8);
        ACTIVE         : String(1);
        COMMT          : String(50);
}

// type VBAKAuthObjectKeys {
//         VKORG: String(4)  ;
//         VTWEG: String(2)  ;
//         SPART: String(2)  ;
//         UserId: String;
// }
@cds.persistence.exists
entity VBAKAUTH {
        key VKORG       : String(4);
        key VTWEG       : String(2);
        key SPART       : String(2);
        key USERID      : String;
            LAST_UPDATE : Timestamp;
}

@cds.persistence.exists
entity EKKOAUTH {
        key EKORG       : String(4);
        key USERID      : String;
            LAST_UPDATE : Timestamp;
}

@cds.persistence.exists
entity ![ST_NOTES] {
        CLIENT         : String(3);
        UTCTIME        : Decimal(15) not null;
        VBELN          : String(10);
        POSNR          : String(6);
        LANGUAGE       : String(2);
        NOTE_TITLE     : String(60);
        NOTE_TEXT      : String(1000);
        USERNAME       : String(12);
        LAST_NOTE_FLAG : String(1);
}

@cds.persistence.exists
entity PARTNER_SETTINGS_DB {
        key CLIENT         : String(3);
        key BASF_USER      : String(12);
        key PARTNER_ROLE   : String(2);
        key PARTNER_NUMBER : String(8);
            ACTIVE         : String(1);
            COMMT          : String(50);
}

entity variants {
            // key id                 : UUID;
        key fileName           : String(255);
            fileType           : String(10);
            changeType         : String(40);
            reference          : String(100);
            packageName        : String(100);
            content            : LargeString;
            namespace          : String(100);
            creation           : DateTime default current_timestamp;
            originalLanguage   : String(2);
            conditions         : String(254);
            contexts           : String(254);
            supportGenerator   : String(100);
            supportService     : String(30);
            supportUser        : String(100);
            layer              : String(20);
            selector           : String(255);
            texts              : LargeString;
            variantName        : String(255);
            variantId          : String(100);
            projectId          : String(100);
            standardVariant    : Boolean;
            favorite           : Boolean;
            executeOnSelection : Boolean;
};

entity variantMigration {
        key userId               : String;
            AMOvariantsMigrated  : Boolean;
            AMOOvariantsMigrated : Boolean;
}

entity variantUserSettings {
        key fileName           : String(255);
        key userId             : String;
            favorite           : Boolean;
            standardVariant    : Boolean;
            executeOnSelection : Boolean;
}
