namespace openorders.db;

using {User} from '@sap/cds/common';

@cds.persistence.exists
entity ![OPENORDERSLIST] {
        MANDT                              : String(3);
        VBELN                              : String(10);
        POSNR                              : String(6);
        ERDAT_ORDER                        : String(8);
        ERDAT_ORDER_DATE                   : Date = ERDAT_ORDER;
        ERDAT_ITEM                         : String(8);
        ERDAT_ITEM_DATE                    : Date = ERDAT_ORDER;
        AUART                              : String(4);
        WERKS                              : String(4);
        VTWEG                              : String(2);
        MATNR                              : String(18);
        KDMAT                              : String(35);
        BSTNK                              : String(20);
        AG_PARTNER                         : String(10);
        AG_PARTNER_NAME1                   : String(35);
        AG_PARTNER_NAME2                   : String(35);
        WE_PARTNER                         : String(10);
        WE_PARTNER_NAME1                   : String(35);
        WE_PARTNER_NAME2                   : String(35);
        LAND1                              : String(3);
        ORT01                              : String(35);
        VKORG                              : String(4);
        VKORG_NAME1                        : String(40);
        CO_PARTNER_HEAD                    : String(10);
        CO_PARTNER_NAME1_HEAD              : String(35);
        CO_PARTNER_NAME2_HEAD              : String(35);
        CO_PARTNER_ITM                     : String(10);
        CO_PARTNER_NAME1_ITM               : String(35);
        CO_PARTNER_NAME2_ITM               : String(35);
        NY_PARTNER_HEAD                    : String(10);
        NY_PARTNER_NAME1_HEAD              : String(35);
        NY_PARTNER_NAME2_HEAD              : String(35);
        NY_PARTNER_ITM                     : String(10);
        NY_PARTNER_NAME1_ITM               : String(35);
        NY_PARTNER_NAME2_ITM               : String(35);
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
        KNREF_HEAD                         : String(30);
        KNREF_ITM                          : String(30);
        VBUND                              : String(6);
        EDATU_REQUESTED                    : String(8);
        EDATU_REQUESTED_DATE               : Date = EDATU_REQUESTED;
        KWMENG                             : Decimal(15);
        VRKME                              : String(3);
        EDATU_CONFIRMED                    : String(8);
        EDATU_CONFIRMED_DATE               : Date = EDATU_CONFIRMED;
        KBMENG                             : Decimal(15);
        UNCONFIRMED_QTY                    : Decimal(15);
        REQ_TEXT                           : String(250);
        FAKSP                              : String(2);
        SUPPLY_SITUATION                   : Int16;
        SUPPLY_SITUATION_DESCR             : String(60);
        KBETR                              : Decimal(11);
        WAERS                              : String(5);
        KPEIN                              : Decimal(5);
        KMEIN                              : String(3);
        KBETR_ALT                          : Decimal(11);
        WAERS_ALT                          : String(5);
        KPEIN_ALT                          : Decimal(5);
        KMEIN_ALT                          : String(3);
        NETWR                              : Decimal(15);
        WAERK                              : String(5);
        HTEXT                              : String(4000);
        PSTYV                              : String(4);
        DISPO                              : String(3);
        KOSCH                              : String(18);
        VKBUR                              : String(4);
        ABGRU                              : String(2);
        ABSTA                              : String(1);
        KNUMV                              : String(10);
        SPART                              : String(2);
        INCO1_ITEM                         : String(3);
        INCO2_ITEM                         : String(28);
        ZTERM_ITEM                         : String(4);
        INCO1_HEAD                         : String(3);
        INCO2_HEAD                         : String(28);
        ZTERM_HEAD                         : String(4);
        PRSDT                              : String(8);
        PRSDT_DATE                         : Date = PRSDT;
        ZZ0S2REVG2                         : String(10);
        ZZDKPPRODB                         : String(18);
        BSARK                              : String(4);
        _BASF_LOFCR                        : String(20);
        GUSCON_LEVEL                       : String(2);
        FIRST_SO                           : String(10);
        FIRST_POSNR                        : String(6);
        LEVEL_TYPE                         : String(7);
        NEXT_SO                            : String(10);
        NEXT_POSNR                         : String(6);
        FINAL_SO                           : String(10);
        FINAL_POSNR                        : String(6);
        VBTYP                              : String(1);
        BSTKD                              : String(35);
        TRAGR                              : String(4);
        VKGRP                              : String(3);
        ROUTE                              : String(6);
        FAKSK                              : String(2);
        MAKTX_LANG                         : String(40);
        LANDX_LANG                         : String(15);
        FAKSP_VTEXT_LANG                   : String(20);
        PSTYV_VTEXT_LANG                   : String(20);
        VKBUR_BEZEI_LANG                   : String(20);
        BSARK_VTEXT_LANG                   : String(20);
        TRAGR_VTEXT_LANG                   : String(20);
        VKGRP_BEZEI_LANG                   : String(20);
        FAKSK_VTEXT_LANG                   : String(20);
        ABGRU_BEZEI_LANG                   : String(20);
        F_WERKS                            : String(4);
        F_VKORG                            : String(4);
        F_VKORG_NAME1                      : String(40);
        F_AS_PARTNER_HEAD                  : String(8);
        F_AS_PARTNER_NAME_HEAD             : String(40);
        F_AS_PARTNER_ITM                   : String(8);
        F_AS_PARTNER_NAME_ITM              : String(40);
        F_LDDAT                            : String(8);
        F_LDDAT_DATE                       : Date = F_LDDAT;
        F_LGORT                            : String(4);
        F_TDDAT                            : String(8);
        F_TDDAT_DATE                       : Date = F_TDDAT;
        F_ZZ0S2MATUG                       : String(18);
        F_AUFNR                            : String(12);
        F_DGLTP                            : String(8);
        F_DGLTP_DATE                       : Date = F_DGLTP;
        F_AMEIN                            : String(3);
        F_PSMNG                            : Decimal(13);
        F_VSBED                            : String(2);
        F_VSBED_VTEXT_LANG                 : String(20);
        F_MANDT                            : String(3);
        F_VBELN                            : String(10);
        F_POSNR                            : String(6);
        MANDT_DEL                          : String(3);
        VBELN_DEL                          : String(10);
        POSNR_DEL                          : String(6);
        CHARG                              : String(10);
        HSDAT                              : String(8);
        HSDAT_DATE                         : Date = HSDAT;
        VFDAT                              : String(8);
        VFDAT_DATE                         : Date = VFDAT;
        LFIMG                              : Decimal(13);
        VRKME_1                            : String(3);
        POSAR                              : String(1);
        VGBEL                              : String(10);
        VGPOS                              : String(6);
        LFART                              : String(4);
        LFART_VTEXT_LANG                   : String(20);
        LFDAT                              : String(8);
        LFDAT_DATE                         : Date = LFDAT;
        TRAID                              : String(20);
        ZZ0S2BLNR                          : String(30);
        PEND_DEL_QUAN                      : String(500);
        WADAT                              : String(8);
        WADAT_DATE                         : Date = WADAT;
        WADAT_IST                          : String(8);
        WADAT_IST_DATE                     : Date = WADAT_IST;
        MANDT_TM                           : String(3);
        TKNUM                              : String(10);
        VSART                              : String(2);
        EXTI1                              : String(20);
        DPTBG                              : String(8);
        DPTBG_DATE                         : Date = DPTBG;
        DATBG                              : String(8);
        DATBG_DATE                         : Date = DATBG;
        DPTEN                              : String(8);
        DPTEN_DATE                         : Date = DPTEN;
        DATEN                              : String(8);
        DATEN_DATE                         : Date = DATEN;
        AR_DATE                            : String(8);
        AR_DATE_DATE                       : Date = AR_DATE;
        TDLNR                              : String(10);
        TDLNR_NAME1                        : String(35);
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
        STTRG                              : String(1);
        VSART_BEZEI_LANG                   : String(20);
        STTRG_DDTEXT_LANG                  : String(60);
        NPS                                : String(2);
        ISSUE                              : String(2);
        DUE_DATE                           : String(8);
        DUE_DATE_FORMATTED                 : Date = DUE_DATE;
        ISSUE_LOCATION                     : String(10);
        ISSUE_LOCATION_ITEM                : String(6);
        NOTE_TEXT                          : String(1000);
// BL_VBELN_INV_FIRST                 : String(10);
// BL_VBELN_INV_LAST                  : String(10);
// XBLNR                              : String(16);
// BL_MANDT_INV_FIRST                 : String(3);
// BL_MANDT_INV_LAST                  : String(3);
}

entity Contacts {
        key SapClient       : String(3);
        key PersonalNumber  : String(8);
            PersonalName    : String(40);
            EmailAddress    : String(241);
            PhoneNumber     : String(241);
            SalesDocument   : String(10);
            OrderItem       : String(6);
            PartnerFunction : String(2);
}

entity FollowUpNotes {
        key SalesOrder   : String(10);
        key OrderItem    : String(6);
        key FollowupNote : String(2);
}

entity ReasonComments {
        key SalesOrder   : String(10);
        key OrderItem    : String(6);
        key ReasonBucket : String(2);
            ReasonCode   : String(2);
}

entity ![DUE_DATE_LIMIT] {
        userId   : User;
        dayLimit : Integer;
}

entity Services {
        key SalesOrder            : String(10);
        key SalesOrderItem        : String(6);
        key ServiceId             : String(5);
        key DslServiceType        : String(3);
            ServiceLevelText      : String(60);
            Language              : String(2);
            Service               : String(40);
            ServiceRequested      : Boolean;
            CurrentOrderCondition : String(100);
            Specification         : String(100);
            ServiceLevel          : String(1);
            ResultsIcon           : String(1);
            Zcomment              : String(100);
            SurchargeDiscount     : String(10);
            Amount                : Decimal(14, 3);
            Currency              : String(5);
            WorkflowStatus        : String(4);
            ExceptionCategory     : String(25);

}

@cds.persistence.exists
@cds.persistence.calcview
entity ![SALESORDER_DETAILS](IP_LANG : String(2)) {
        key MANDT                  : String(3);
        key VBELN                  : String(10);
        key POSNR                  : String(6);
            ERDAT_ORDER            : String(8);
            ERDAT_ITEM             : String(8);
            AUART                  : String(4);
            WERKS                  : String(4);
            VTWEG                  : String(2);
            MATNR                  : String(18);
            MAKTX_LANG             : String(40);
            KDMAT                  : String(35);
            AG_PARTNER             : String(10);
            AG_PARTNER_NAME1       : String(35);
            AG_PARTNER_NAME2       : String(35);
            WE_PARTNER             : String(10);
            WE_PARTNER_NAME1       : String(35);
            WE_PARTNER_NAME2       : String(35);
            CO_PARTNER_HEAD        : String(10);
            CO_PARTNER_NAME1_HEAD  : String(35);
            CO_PARTNER_NAME2_HEAD  : String(35);
            CO_PARTNER_ITM         : String(10);
            CO_PARTNER_NAME1_ITM   : String(35);
            CO_PARTNER_NAME2_ITM   : String(35);
            NY_PARTNER_HEAD        : String(10);
            NY_PARTNER_NAME1_HEAD  : String(35);
            NY_PARTNER_NAME2_HEAD  : String(35);
            NY_PARTNER_ITM         : String(10);
            NY_PARTNER_NAME1_ITM   : String(35);
            NY_PARTNER_NAME2_ITM   : String(35);
            AS_PARTNER_HEAD        : String(8);
            AS_PARTNER_NAME_HEAD   : String(40);
            AS_PARTNER_ITM         : String(8);
            AS_PARTNER_NAME_ITM    : String(40);
            VE_PARTNER_HEAD        : String(8);
            VE_PARTNER_NAME_HEAD   : String(40);
            VE_PARTNER_ITM         : String(8);
            VE_PARTNER_NAME_ITM    : String(40);
            AM_PARTNER_HEAD        : String(8);
            AM_PARTNER_NAME_HEAD   : String(40);
            AM_PARTNER_ITM         : String(8);
            AM_PARTNER_NAME_ITM    : String(40);
            LAND1                  : String(3);
            LANDX_LANG             : String(15);
            ORT01                  : String(35);
            VKORG                  : String(4);
            VKORG_NAME1            : String(40);
            KNREF_HEAD             : String(30);
            KNREF_ITM              : String(30);
            VBUND                  : String(6);
            EDATU_REQUESTED        : String(8);
            KWMENG                 : Decimal(15, 3);
            VRKME                  : String(3);
            EDATU_CONFIRMED        : String(8);
            KBMENG                 : Decimal(15, 3);
            LDDAT                  : String(8);
            UNCONFIRMED_QTY        : Decimal(15, 3);
            REQ_TEXT               : String(250);
            FAKSP                  : String(2);
            FAKSP_VTEXT_LANG       : String(20);
            LGORT                  : String(4);
            SUPPLY_SITUATION       : Int16;
            SUPPLY_SITUATION_DESCR : String(60);
            KBETR                  : Decimal(11, 2);
            KBETR_ALT              : Decimal(11, 2);
            WAERS                  : String(5);
            WAERS_ALT              : String(5);
            KPEIN                  : Decimal(5);
            KPEIN_ALT              : String(5);
            KMEIN                  : String(3);
            KMEIN_ALT              : String(3);
            NETWR                  : Decimal(15, 2);
            WAERK                  : String(5);
            HTEXT                  : String(4000);
            PSTYV                  : String(4);
            PSTYV_VTEXT_LANG       : String(20);
            DISPO                  : String(3);
            KOSCH                  : String(18);
            VKBUR                  : String(4);
            VKBUR_BEZEI_LANG       : String(20);
            ABGRU                  : String(2);
            ABSTA                  : String(1);
            KNUMV                  : String(10);
            SPART                  : String(2);
            INCO1_HEAD             : String(3);
            INCO1_ITEM             : String(3);
            INCO2_HEAD             : String(3);
            INCO2_ITEM             : String(28);
            ZTERM_HEAD             : String(4);
            ZTERM_ITEM             : String(4);
            PRSDT                  : String(8);
            ZZ0S2REVG2             : String(10);
            ZZDKPPRODB             : String(18);
            BSARK                  : String(4);
            BSARK_VTEXT_LANG       : String(20);
            BASF_LOFCR             : String(20);
            GUSCON                 : String(15);
            GUSCON_ITM             : String(6);
            GUSCON_LEVEL           : String(2);
            FIRST_SO               : String(10);
            FIRST_POSNR            : String(6);
            ISCOMPLETED            : String(1);
            LEVEL_TYPE             : String(1);
            NEXT_SO                : String(10);
            NEXT_POSNR             : String(6);
            FINAL_SO               : String(10);
            FINAL_POSNR            : String(6);
            VBTYP                  : String(1);
            BSTKD                  : String(35);
            TRAGR                  : String(4);
            TRAGR_VTEXT_LANG       : String(20);
            VKGRP                  : String(3);
            VKGRP_BEZEI_LANG       : String(20);
            ROUTE                  : String(6);
            TDDAT                  : String(8);
            ZZ0S2MATUG             : String(18);
            VSBED                  : String(2);
            VSBED_VTEXT_LANG       : String(20);
            AUFNR                  : String(12);
            DGLTP                  : String(8);
            AMEIN                  : String(3);
            PSMNG                  : Decimal(13, 3);
            FAKSK                  : String(2);
            FAKSK_VTEXT_LANG       : String(20);
            SO_LAST_UPDATE         : Timestamp;
}

entity ScheduleLineRequested {
        key MyOrder    : String(10);
        key MyItem     : String(6);
        key SlNum      : String(4);
            FinalOrder : String(10);
            FinalItem  : String(6);
            NextOrder  : String(10);
            SlDate     : DateTime;
            NextItem   : String(6);
            Quantity   : Decimal(13, 3);
            Nps        : String(2);
            SalesUnit  : String(3);
}

entity ScheduleLineConfirmed {
        key FinalOrder : String(10);
        key FinalItem  : String(6);
        key SlNum      : String(4);
            MyOrder    : String(10);
            Quantity   : Decimal(13, 3);
            MyItem     : String(6);
            SalesUnit  : String(3);
            NextOrder  : String(10);
            NextItem   : String(6);
            SlDate     : DateTime;
            Nps        : String(2);
}

entity WorkflowPartner {
        key PartnFn    : String(2);
        key OrderNo    : String(10);
        key ItemNo     : String(6);
            FinalOrder : String(10);
            FinalItem  : String(6);
            NextOrder  : String(10);
            Usrid      : String(30);
            NextItem   : String(6);
            Name       : String(40);
            Nps        : String(2);
            MailAddr   : String(241);
            TelNum     : String(241);
}

entity FinalOrderLine {
        key MyOrder                 : String(10);
        key Nps                     : String(2);
        key MyItem                  : String(6);
        key FinalOrder              : String(10);
        key FinalItem               : String(6);
        key NextItem                : String(6);
        key NextOrder               : String(10);
            Editable                : Boolean;
            BusProc                 : String(60);
            PurchaseOrder           : String(20);
            ShippingCondition       : String(2);
            ShipToCountry           : String(3);
            SubmitWorkflow          : Boolean;
            SubmitChangeSap         : Boolean;
            SendEmail               : Boolean;
            FirstItem               : String(6);
            FirstOrder              : String(10);

            OrdWFPartnersFinalOrder : Association to many WorkflowPartner
                                              on  OrdWFPartnersFinalOrder.Nps        = Nps
                                              and OrdWFPartnersFinalOrder.NextOrder  = NextOrder
                                              and OrdWFPartnersFinalOrder.NextItem   = NextItem
                                              and OrdWFPartnersFinalOrder.FinalOrder = FinalOrder
                                              and OrdWFPartnersFinalOrder.FinalItem  = FinalItem
                                              and OrdWFPartnersFinalOrder.OrderNo    = MyOrder
                                              and OrdWFPartnersFinalOrder.ItemNo     = MyItem;

            OrdWFPartnersNextOrder  : Association to many WorkflowPartner
                                              on  OrdWFPartnersNextOrder.Nps        = Nps
                                              and OrdWFPartnersNextOrder.NextOrder  = NextOrder
                                              and OrdWFPartnersNextOrder.NextItem   = NextItem
                                              and OrdWFPartnersNextOrder.FinalOrder = FinalOrder
                                              and OrdWFPartnersNextOrder.FinalItem  = FinalItem
                                              and OrdWFPartnersNextOrder.OrderNo    = MyOrder
                                              and OrdWFPartnersNextOrder.ItemNo     = MyItem;

            OrdSchedReqAssociation  : Association to many ScheduleLineRequested
                                              on  OrdSchedReqAssociation.MyOrder    = MyOrder
                                              and OrdSchedReqAssociation.MyItem     = MyItem
                                              and OrdSchedReqAssociation.Nps        = Nps
                                              and OrdSchedReqAssociation.NextOrder  = NextOrder
                                              and OrdSchedReqAssociation.NextItem   = NextItem
                                              and OrdSchedReqAssociation.FinalOrder = FinalOrder
                                              and OrdSchedReqAssociation.FinalItem  = FinalItem;

            OrdSchedConfAssociation : Association to many ScheduleLineConfirmed
                                              on  OrdSchedConfAssociation.MyOrder    = MyOrder
                                              and OrdSchedConfAssociation.MyItem     = MyItem
                                              and OrdSchedConfAssociation.FinalOrder = FinalOrder
                                              and OrdSchedConfAssociation.FinalItem  = FinalItem
                                              and OrdSchedConfAssociation.NextOrder  = NextOrder
                                              and OrdSchedConfAssociation.NextItem   = NextItem
                                              and OrdSchedConfAssociation.Nps        = Nps;
}
