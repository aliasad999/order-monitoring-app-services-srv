using openOrdersSrv as service from '../../srv/order-monitoring-amoo-services.cds';


// ------------- ORDER CREATION VALUE HELPS -------
annotate service.orderCreation with {
    PO_MANDT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_MANDT}',
        CollectionPath         : 'OCValueHelps',
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
    };

    PO_EBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EBELN}',
        CollectionPath         : 'OCValueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EBELN,
            ValueListProperty: 'PO_EBELN'
        }

        ]
    };

    PO_EBELP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EBELP}',
        CollectionPath         : 'OCValueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EBELP,
            ValueListProperty: 'PO_EBELP'
        }

        ]
    };

    PO_EKORG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EKORG}',
        CollectionPath         : 'OCValueHelps',
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
    };


    PO_EKGRP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EKGRP}',
        CollectionPath         : 'OCValueHelps',
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
    };

    PO_EMATN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_EMATN}',
        CollectionPath         : 'OCValueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_EMATN,
            ValueListProperty: 'PO_EMATN'
        }

        ]
    };

    PO_WERKS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_WERKS}',
        CollectionPath         : 'OCValueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_WERKS,
            ValueListProperty: 'PO_WERKS'
        }

        ]
    };

    PO_ERROR_TEXT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_ERROR_TEXT}',
        CollectionPath         : 'OCValueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_ERROR_TEXT,
            ValueListProperty: 'PO_ERROR_TEXT'
        }

        ]
    };

    PO_ISSUE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_ISSUE}',
        CollectionPath         : 'OCValueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_ISSUE,
            ValueListProperty: 'PO_ISSUE'
        }

        ]
    };

    PO_NPS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SO_NPS}',
        CollectionPath         : 'OCValueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_NPS,
            ValueListProperty: 'PO_NPS'
        }

        ]
    };

    PO_KUNNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_KUNNR}',
        CollectionPath         : 'OCValueHelps',
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
    };

    PO_PARTNER_9A_HEAD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_PARTNER_9A_HEAD}',
        CollectionPath         : 'OCValueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_PARTNER_9A_HEAD,
            ValueListProperty: 'PO_PARTNER_9A_HEAD'
        }

        ]
    };

    PO_PARTNER_9O_HEAD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_PARTNER_9O_HEAD}',
        CollectionPath         : 'OCValueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PO_PARTNER_9O_HEAD,
            ValueListProperty: 'PO_PARTNER_9O_HEAD'
        }

        ]
    };

    PO_BSART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PO_BSART}',
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
    };

};

// -------------------------------------------------
// ------- END OF ORDER CREATION ANNOTATIONS -------
// -------------------------------------------------