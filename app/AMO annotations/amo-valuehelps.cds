using srvOpenOrders as service from '../../srv/order-monitoring-amo-services.cds';

annotate service.Results with {
    SO_MAKTX
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_MAKTX}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_MATNR'
            },
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_MAKTX,
                ValueListProperty: 'SO_MAKTX'
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
        },
        {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'SO_ZTERM_VTEXT_LANG'
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
        CollectionPath         : 'DCPStatus',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_DCP_ITEM_STATUS,
                ValueListProperty: 'DCPStatusKey'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DCPStatusText'
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
    SO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_MANDT}',
        CollectionPath         : 'SAPSystems',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_MANDT,
                ValueListProperty: 'mandantKey'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'mandantText'
            }
        ]
    }
}

annotate service.Results with {
    DL_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_MANDT}',
        CollectionPath         : 'SAPSystems',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DL_MANDT,
                ValueListProperty: 'mandantKey'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'mandantText'
            }
        ]
    }
}

annotate service.Results with {
    TM_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_MANDT}',
        CollectionPath         : 'SAPSystems',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: TM_MANDT,
                ValueListProperty: 'mandantKey'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'mandantText'
            }
        ]
    }
}

annotate service.Results with {
    BL_MANDT_INV_FIRST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_MANDT_INV_FIRST}',
        CollectionPath         : 'SAPSystems',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: BL_MANDT_INV_FIRST,
                ValueListProperty: 'mandantKey'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'mandantText'
            }
        ]
    }
}

annotate service.Results with {
    BL_MANDT_INV_LAST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BL_MANDT_INV_LAST}',
        CollectionPath         : 'SAPSystems',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: BL_MANDT_INV_LAST,
                ValueListProperty: 'mandantKey'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'mandantText'
            }
        ]
    }
}

annotate service.Results with {
    SO_FIRST_SO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_FIRST_SO_MANDT}',
        CollectionPath         : 'SAPSystems',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_FIRST_SO_MANDT,
                ValueListProperty: 'mandantKey'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'mandantText'
            }
        ]
    }
}

annotate service.Results with {
    SO_FINAL_SO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_FINAL_SO_MANDT}',
        CollectionPath         : 'SAPSystems',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_FINAL_SO_MANDT,
                ValueListProperty: 'mandantKey'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'mandantText'
            }
        ]
    }
}

annotate service.Results with {
    PO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_MANDT}',
        CollectionPath         : 'SAPSystems',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PO_MANDT,
                ValueListProperty: 'mandantKey'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'mandantText'
            }
        ]
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
    TM_VISTA_STATUS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_VISTA_STATUS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_VISTA_STATUS,
            ValueListProperty: 'TM_VISTA_STATUS'
        }

        ]
    }
};

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
};

annotate service.Results with {
    SO_BNAME
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_BNAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_BNAME,
            ValueListProperty: 'SO_BNAME'
        }

        ]
    }
};

annotate service.Results with {
    SO_AUGRU
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_AUGRU}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_AUGRU,
                ValueListProperty: 'SO_AUGRU'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_AUGRU_BEZEI_LANG'
            }
        ]
    }
};

annotate service.Results with {
    SO_KDGRP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KDGRP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_KDGRP,
                ValueListProperty: 'SO_KDGRP'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_KDGRP_KTEXT_LANG'
            }
        ]
    }
};

annotate service.Results with {
    SO_WE_PARTNER_REGION
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_WE_PARTNER_REGION}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_WE_PARTNER_REGION,
                ValueListProperty: 'SO_WE_PARTNER_REGION'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_WE_PARTNER_REGION_BEZEI_LANG'
            }
        ]
    }
};

annotate service.Results with {
    SO_TO_PARTNER
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_TO_PARTNER_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_TO_PARTNER,
                ValueListProperty: 'SO_TO_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_TO_PARTNER_NAME'
            }

        ]
    }
};


annotate service.Results with {
    SO_FOLLOWUP_NOTES_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_FOLLOWUP_NOTES_LANG}',
        CollectionPath         : 'PredefFollowupNotes',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_FOLLOWUP_NOTES_LANG,
            ValueListProperty: 'FollowUpNoteId'
        },
        {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'FollowUpNoteContent'
        }]
    }
};

annotate service.Results with {
    SO_REASON_CODE_01_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REASON_CODE_01_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REASON_CODE_01_LANG,
            ValueListProperty: 'SO_REASON_CODE_01_LANG'
        }

        ]
    }
};

annotate service.Results with {
    SO_REASON_CODE_02_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REASON_CODE_02_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REASON_CODE_02_LANG,
            ValueListProperty: 'SO_REASON_CODE_02_LANG'
        }

        ]
    }
};

annotate service.Results with {
    SO_REASON_CODE_03_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REASON_CODE_03_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REASON_CODE_03_LANG,
            ValueListProperty: 'SO_REASON_CODE_03_LANG'
        }

        ]
    }
};

annotate service.Results with {
    SO_REASON_CODE_04_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REASON_CODE_04_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REASON_CODE_04_LANG,
            ValueListProperty: 'SO_REASON_CODE_04_LANG'
        }

        ]
    }
};

annotate service.Results with {
    SO_REASON_CODE_05_LANG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_REASON_CODE_05_LANG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_REASON_CODE_05_LANG,
            ValueListProperty: 'SO_REASON_CODE_05_LANG'
        }

        ]
    }
};

annotate service.Results with {
    SO_ZZ0S2VGANN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ZZ0S2VGANN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ZZ0S2VGANN,
            ValueListProperty: 'SO_ZZ0S2VGANN'
        }

        ]
    }
};


annotate service.Results with {
    SO_ZZ0S2LOANN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ZZ0S2LOANN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ZZ0S2LOANN,
            ValueListProperty: 'SO_ZZ0S2LOANN'
        }

        ]
    }
};


annotate service.Results with {
    SO_ABLAD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ABLAD}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ABLAD,
            ValueListProperty: 'SO_ABLAD'
        }
        ]
    }
};



annotate service.Results with {
    SO_DGSTA
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_DGSTA}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_DGSTA,
            ValueListProperty: 'SO_DGSTA'
        },
        {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'SO_DGSTA_DDTEXT_LANG'
        }
        ]
    }
};


annotate service.Results with {
    SO_MVGR2
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_MVGR2}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_MVGR2,
            ValueListProperty: 'SO_MVGR2'
        },
        {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'SO_MVGR2_BEZEI_LANG'
        }
        ]
    }
};

annotate service.Results with {
    SO_MFRGR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_MFRGR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_MFRGR,
            ValueListProperty: 'SO_MFRGR'
        },
        {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'SO_MFRGR_BEZEI_LANG'
        }
        ]
    }
};

annotate service.Results with {
    TM_TS_PARTNER
    @Common.ValueList      : {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_TS_PARTNER_NAME1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: TM_TS_PARTNER,
                ValueListProperty: 'TM_TS_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'TM_TS_PARTNER_NAME1'
            }

        ]
    }
};

// Added VHs after first fix
// ----------------------------------
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
    DL_WERKS_DEL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_WERKS_DEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_WERKS_DEL,
            ValueListProperty: 'DL_WERKS_DEL'
        }

        ]
    }
};

annotate service.Results with {
    DL_VKORG_DEL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DL_VKORG_DEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DL_VKORG_DEL,
            ValueListProperty: 'DL_VKORG_DEL'
        }

        ]
    }
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
    SO_SPART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_SPART}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_SPART,
            ValueListProperty: 'SO_SPART'
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
    PO_PARTNER_9A_HEAD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_PARTNER_9A_HEAD}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_PARTNER_9A_HEAD,
            ValueListProperty: 'PO_PARTNER_9A_HEAD'
        }

        ]
    }
};


annotate service.Results with {
    PO_PARTNER_9O_HEAD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_PARTNER_9O_HEAD}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_PARTNER_9O_HEAD,
            ValueListProperty: 'PO_PARTNER_9O_HEAD'
        }

        ]
    }
};

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
};

annotate service.Results with {
    SO_PRCTR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_PRCTR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_PRCTR,
            ValueListProperty: 'SO_PRCTR'
        }

        ]
    }
};

annotate service.Results with {
    SO_ZZATP_CUST
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ZZATP_CUST}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_ZZATP_CUST,
            ValueListProperty: 'SO_ZZATP_CUST'
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
    SO_VMSTA
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_VMSTA}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_VMSTA,
            ValueListProperty: 'SO_VMSTA'
        }

        ]
    }
};

annotate service.Results with {
    SO_IHREZ
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_IHREZ}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_IHREZ,
            ValueListProperty: 'SO_IHREZ'
        }

        ]
    }
};

annotate service.Results with {
    LAST_NOTE_FROMORDERCHAIN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>LAST_NOTE_FROMORDERCHAIN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: LAST_NOTE_FROMORDERCHAIN,
            ValueListProperty: 'LAST_NOTE_FROMORDERCHAIN'
        }

        ]
    }
};

annotate service.Results with {
    LAST_NOTE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>LAST_NOTE}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: LAST_NOTE,
            ValueListProperty: 'LAST_NOTE'
        }

        ]
    }
};

annotate service.Results with {
    TM_TNDR_TRKID
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TM_TNDR_TRKID}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: TM_TNDR_TRKID,
            ValueListProperty: 'TM_TNDR_TRKID'
        }

        ]
    }
};

annotate service.Results with {
    SO_MTVFP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_MTVFP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SO_MTVFP,
            ValueListProperty: 'SO_MTVFP'
        }

        ]
    }
};

annotate service.Results with {
    SO_OM_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_OM_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_OM_PARTNER,
                ValueListProperty: 'SO_OM_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_OM_PARTNER_NAME'
            }

        ]
    }
};

annotate service.Results with {
    SO_AH_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_AH_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_AH_PARTNER,
                ValueListProperty: 'SO_AH_PARTNER'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_AH_PARTNER_NAME'
            }

        ]
    }
};

annotate service.Results with {
    SO_KVGR5
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_KVGR5}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SO_KVGR5,
                ValueListProperty: 'SO_KVGR5'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SO_KVGR5_TEXT'
            }

        ]
    }
};