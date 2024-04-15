using openOrdersSrv as service from '../srv/order-monitoring-amoo-services.cds';

annotate service.allIssues with @(UI: {SelectionFields: [
    SO_VBELN,
    SO_VKORG,
    SO_VTWEG,
    SO_AG_PARTNER,
    SO_WE_PARTNER
],
});

annotate service.allIssues with @UI.LineItem: {
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

annotate service.salesorder_nps with @UI.LineItem: {
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


annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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


annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
    SO_LGORT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_LGORT}',
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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


annotate service.allIssues with {
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

 annotate service.allIssues with {
     DL_POSNR
     @Common.ValueList: {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

// annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
    DL_ZZ0S2BLNR
    @Common.ValueList      : {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
    SO_BASF_LOFCR
    @Common.ValueList      : {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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


annotate service.allIssues with {
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


annotate service.allIssues with {
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

annotate service.allIssues with {
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

annotate service.allIssues with {
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