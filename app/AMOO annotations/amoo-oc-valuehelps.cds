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


    // PO_EKGRP
    // @Common.ValueList: {
    //     $Type                  : 'Common.ValueListType',
    //     Label                  : '{@i18n>PO_EKGRP}',
    //     CollectionPath         : 'OCValueHelps',
    //     DistinctValuesSupported: true,
    //     SearchSupported        : true,
    //     Parameters             : [
    //         {
    //             $Type            : 'Common.ValueListParameterInOut',
    //             LocalDataProperty: PO_EKGRP,
    //             ValueListProperty: 'PO_EKGRP'
    //         },
    //         {
    //             $Type            : 'Common.ValueListParameterDisplayOnly',
    //             ValueListProperty: 'PO_EKNAM'
    //         }

    //     ]
    // };

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

    // PO_BSART
    // @Common.ValueList: {
    //     $Type                  : 'Common.ValueListType',
    //     Label                  : '{@i18n>PO_BSART}',
    //     CollectionPath         : 'valueHelps',
    //     DistinctValuesSupported: true,
    //     SearchSupported        : true,
    //     Parameters             : [
    //         {
    //             $Type            : 'Common.ValueListParameterInOut',
    //             LocalDataProperty: PO_BSART,
    //             ValueListProperty: 'PO_BSART'
    //         },
    //         {
    //             $Type            : 'Common.ValueListParameterDisplayOnly',
    //             ValueListProperty: 'PO_BSART_BATXT'
    //         }

    //     ]
    // };

};

// -------------------------------------------------
// ------- END OF ORDER CREATION ANNOTATIONS -------
// -------------------------------------------------