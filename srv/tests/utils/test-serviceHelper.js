const assert = require('assert');
const serviceHelper = require('../../utils/serviceHelper');

///// transformWhereClause tests
describe('Service Helper Test', function () {

    it('transformWhereClause - empty dates', function () {
        const originalWhere = `((SO_EDATU_REQUESTED >= ''2025-07-21'' AND SO_EDATU_REQUESTED <= ''2025-07-21'') AND (DL_WADAT IS NULL OR DL_WADAT = ''00000000'' OR DL_WADAT = '''') AND (DL_WADAT_IST IS NOT NULL AND DL_WADAT_IST != ''00000000'' AND DL_WADAT_IST != ''''))AND SO_IGNORED = 0 AND`;
        const expectedWhere = `((SO_EDATU_REQUESTED >= '20250721' AND SO_EDATU_REQUESTED <= '20250721') AND (DL_WADAT IS NULL OR DL_WADAT = '00000000' OR DL_WADAT = '') AND (DL_WADAT_IST IS NOT NULL AND DL_WADAT_IST != '00000000' AND DL_WADAT_IST != ''))AND SO_IGNORED = 0`;
        const transformedWhere = serviceHelper.transformWhereClause(originalWhere);
        assert.strictEqual(transformedWhere, expectedWhere);
    });

    it('transformWhereClause - contains with space', function () {
        const originalWhere = `((SO_EDATU_REQUESTED >= ''2025-07-01'' AND SO_EDATU_REQUESTED <= ''2025-07-31'') AND SO_HTEXT LIKE ''%'' || ''Auftrag '' || ''%'' ESCAPE ''^'') AND SO_IGNORED = 0 AND`;
        const expectedWhere = `((SO_EDATU_REQUESTED >= '20250701' AND SO_EDATU_REQUESTED <= '20250731') AND SO_HTEXT LIKE '%' || 'Auftrag ' || '%' ESCAPE '^') AND SO_IGNORED = 0`;
        const transformedWhere = serviceHelper.transformWhereClause(originalWhere);
        assert.strictEqual(transformedWhere, expectedWhere);
    });

    it('transformWhereClause - combinations for same filter field', function () {
        const originalWhere = `((SO_EDATU_REQUESTED >= ''2025-07-22'' AND SO_EDATU_REQUESTED <= ''2025-07-22'') AND (DL_WADAT_IST IS NOT NULL AND DL_WADAT_IST != ''00000000'' AND DL_WADAT_IST != '''') AND ((LAST_NOTE IS NOT NULL AND LAST_NOTE != '''') AND (not LAST_NOTE LIKE ''%'' || ''ETA'' || ''%'' ESCAPE ''^'' OR LAST_NOTE IS NULL OR LAST_NOTE = ''''))) AND SO_DUE_DATE <= ''2025-07-22'' AND SO_IGNORED = 0 AND`;
        const expectedWhere = `((SO_EDATU_REQUESTED >= '20250722' AND SO_EDATU_REQUESTED <= '20250722') AND (DL_WADAT_IST IS NOT NULL AND DL_WADAT_IST != '00000000' AND DL_WADAT_IST != '') AND ((LAST_NOTE IS NOT NULL AND LAST_NOTE != '') AND (not LAST_NOTE LIKE '%' || 'ETA' || '%' ESCAPE '^' OR LAST_NOTE IS NULL OR LAST_NOTE = ''))) AND SO_DUE_DATE <= '20250722' AND SO_IGNORED = 0`;
        const transformedWhere = serviceHelper.transformWhereClause(originalWhere);
        assert.strictEqual(transformedWhere, expectedWhere);
    });

});


///// processExpression tests
describe('processExpression Method Tests', function () {

    describe('Basic operations', function () {
        
        it('should handle simple reference', function () {
            const expr = [{ ref: ['table', 'column'] }];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, 'table.column');
        });

        it('should handle simple value - string', function () {
            const expr = [{ val: 'test' }];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "''test''");
        });

        it('should handle simple value - number', function () {
            const expr = [{ val: 123 }];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, '123');
        });

        it('should handle NULL value', function () {
            const expr = [{ val: null }];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, 'NULL');
        });

        it('should handle comparison operators', function () {
            const expr = [
                { ref: ['column'] },
                '=',
                { val: 'value' }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "column = ''value''");
        });
    });

    describe('Logical operators', function () {
        
        it('should convert AND to uppercase', function () {
            const expr = [
                { ref: ['col1'] },
                '=',
                { val: 'val1' },
                'and',
                { ref: ['col2'] },
                '=',
                { val: 'val2' }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "col1 = ''val1'' AND col2 = ''val2''");
        });

        it('should convert OR to uppercase', function () {
            const expr = [
                { ref: ['col1'] },
                '=',
                { val: 'val1' },
                'or',
                { ref: ['col2'] },
                '=',
                { val: 'val2' }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "col1 = ''val1'' OR col2 = ''val2''");
        });
    });

    describe('Nested expressions', function () {
        
        it('should handle nested expression with parentheses', function () {
            const expr = [
                { ref: ['col1'] },
                '=',
                { val: 'val1' },
                'and',
                {
                    xpr: [
                        { ref: ['col2'] },
                        '=',
                        { val: 'val2' },
                        'or',
                        { ref: ['col3'] },
                        '=',
                        { val: 'val3' }
                    ]
                }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "col1 = ''val1'' AND (col2 = ''val2'' OR col3 = ''val3'')");
        });
    });

    describe('Date function', function () {
        
        it('should handle date function with string value', function () {
            const expr = [
                {
                    func: 'date',
                    args: [{ val: '2025-07-21' }]
                }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "''2025-07-21''");
        });
    });

    describe('Contains function', function () {
        
        it('should handle contains without toUpper', function () {
            const expr = [
                {
                    func: 'contains',
                    args: [
                        { ref: ['table', 'column'] },
                        { val: 'search' }
                    ]
                }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "( table.column LIKE ( ''%'' || ''search'' || ''%'' ) ESCAPE ''^'' )");
        });

        it('should handle contains with toUpper', function () {
            const expr = [
                {
                    func: 'contains',
                    args: [
                        {
                            func: 'toUpper',
                            args: [{ ref: ['table', 'column'] }]
                        },
                        { val: 'SEARCH' }
                    ]
                }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "( upper (table.column) LIKE ( ''%'' || ''SEARCH'' || ''%'' ) ESCAPE ''^'' )");
        });

        it('should handle contains with space in value', function () {
            const expr = [
                {
                    func: 'contains',
                    args: [
                        { ref: ['SO_HTEXT'] },
                        { val: 'Auftrag ' }
                    ]
                }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "( SO_HTEXT LIKE ( ''%'' || ''Auftrag '' || ''%'' ) ESCAPE ''^'' )");
        });
    });

    describe('StartsWith function', function () {
        
        it('should handle startswith without toUpper', function () {
            const expr = [
                {
                    func: 'startswith',
                    args: [
                        { ref: ['column'] },
                        { val: 'prefix' }
                    ]
                }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "( column LIKE ( ''prefix'' || ''%'' ) ESCAPE ''^'' )");
        });

        it('should handle startswith with toUpper', function () {
            const expr = [
                {
                    func: 'startswith',
                    args: [
                        {
                            func: 'toUpper',
                            args: [{ ref: ['column'] }]
                        },
                        { val: 'PREFIX' }
                    ]
                }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "( upper (column) LIKE ( ''PREFIX'' || ''%'' ) ESCAPE ''^'' )");
        });
    });

    describe('EndsWith function', function () {
        
        it('should handle endswith without toUpper', function () {
            const expr = [
                {
                    func: 'endswith',
                    args: [
                        { ref: ['column'] },
                        { val: 'suffix' }
                    ]
                }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "( column LIKE ( ''%'' || ''suffix'' ) ESCAPE ''^'' )");
        });

        it('should handle endswith with toUpper', function () {
            const expr = [
                {
                    func: 'endswith',
                    args: [
                        {
                            func: 'toUpper',
                            args: [{ ref: ['column'] }]
                        },
                        { val: 'SUFFIX' }
                    ]
                }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "( upper (column) LIKE ( ''%'' || ''SUFFIX'' ) ESCAPE ''^'' )");
        });
    });

    describe('ToUpper function', function () {
        
        it('should handle toUpper function standalone', function () {
            const expr = [
                {
                    func: 'toUpper',
                    args: [{ ref: ['table', 'column'] }]
                }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, 'upper (table.column)');
        });
    });

    describe('Complex scenarios', function () {
        
        it('should handle multiple conditions with different operators', function () {
            const expr = [
                { ref: ['SO_EDATU_REQUESTED'] },
                '>=',
                { val: '2025-07-21' },
                'and',
                { ref: ['SO_EDATU_REQUESTED'] },
                '<=',
                { val: '2025-07-21' },
                'and',
                { ref: ['DL_WADAT'] },
                '=',
                { val: null }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "SO_EDATU_REQUESTED >= ''2025-07-21'' AND SO_EDATU_REQUESTED <= ''2025-07-21'' AND DL_WADAT = NULL");
        });

        it('should handle complex nested expression with multiple functions', function () {
            const expr = [
                {
                    xpr: [
                        { ref: ['SO_EDATU_REQUESTED'] },
                        '>=',
                        { val: '2025-07-01' },
                        'and',
                        { ref: ['SO_EDATU_REQUESTED'] },
                        '<=',
                        { val: '2025-07-31' }
                    ]
                },
                'and',
                {
                    func: 'contains',
                    args: [
                        { ref: ['SO_HTEXT'] },
                        { val: 'Auftrag' }
                    ]
                },
                'and',
                { ref: ['SO_IGNORED'] },
                '=',
                { val: 0 }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "(SO_EDATU_REQUESTED >= ''2025-07-01'' AND SO_EDATU_REQUESTED <= ''2025-07-31'') AND ( SO_HTEXT LIKE ( ''%'' || ''Auftrag'' || ''%'' ) ESCAPE ''^'' ) AND SO_IGNORED = 0");
        });

        it('should handle NOT with contains', function () {
            const expr = [
                'not',
                {
                    func: 'contains',
                    args: [
                        { ref: ['LAST_NOTE'] },
                        { val: 'ETA' }
                    ]
                },
                'or',
                { ref: ['LAST_NOTE'] },
                '=',
                { val: null }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "not ( LAST_NOTE LIKE ( ''%'' || ''ETA'' || ''%'' ) ESCAPE ''^'' ) OR LAST_NOTE = NULL");
        });
    });

    describe('Edge cases', function () {

        it('should handle numeric zero value', function () {
            const expr = [
                { ref: ['SO_IGNORED'] },
                '=',
                { val: 0 }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, 'SO_IGNORED = 0');
        });
        
        it('should handle empty expression', function () {
            const expr = [];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, '');
        });

        it('should handle expression with empty string value', function () {
            const expr = [
                { ref: ['column'] },
                '=',
                { val: '' }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "column = ''''");
        });

        it('should handle multiple nested levels', function () {
            const expr = [
                {
                    xpr: [
                        {
                            xpr: [
                                { ref: ['col1'] },
                                '=',
                                { val: 'val1' }
                            ]
                        },
                        'and',
                        { ref: ['col2'] },
                        '=',
                        { val: 'val2' }
                    ]
                }
            ];
            const result = serviceHelper.processExpression(expr);
            assert.strictEqual(result, "((col1 = ''val1'') AND col2 = ''val2'')");
        });
    });

});

///// convertCQNtoCQL tests
describe('convertCQNtoCQL Method Tests', function () {
    
        it('Simple expression - Should remove SO_IGNORED', function () {
            const expr = [{"xpr":[{"ref":["SO_EDATU_REQUESTED"]},">=",{"val":"20251014"},"and",{"ref":["SO_EDATU_REQUESTED"]},"<=",{"val":"20251014"}]},"and",{"ref":["SO_IGNORED"]},"=",{"val":0}];
            const result = serviceHelper.convertCQNtoCQL(expr, true);
            assert.strictEqual(result, "(SO_EDATU_REQUESTED >= ''20251014'' AND SO_EDATU_REQUESTED <= ''20251014'') AND");
        });

        it('Simple expression - Should keep SO_IGNORED', function () {
            const expr = [{"xpr":[{"ref":["SO_EDATU_REQUESTED"]},">=",{"val":"20251014"},"and",{"ref":["SO_EDATU_REQUESTED"]},"<=",{"val":"20251014"}]},"and",{"ref":["SO_IGNORED"]},"=",{"val":0}];
            const result = serviceHelper.convertCQNtoCQL(expr, false);
            assert.strictEqual(result, "(SO_EDATU_REQUESTED >= ''20251014'' AND SO_EDATU_REQUESTED <= ''20251014'') AND SO_IGNORED = 0 AND");
        });

        it('Simple filter - Should remove SO_IGNORED', function () {
            const expr = [{"ref":["SO_VBELN"]},"=",{"val":"6013006712"},"and",{"ref":["SO_IGNORED"]},"=",{"val":0}]
            const result = serviceHelper.convertCQNtoCQL(expr, true);
            assert.strictEqual(result, "SO_VBELN = ''6013006712'' AND");
        });

        it('Simple filter - Should keep SO_IGNORED', function () {
            const expr = [{"ref":["SO_VBELN"]},"=",{"val":"6013006712"},"and",{"ref":["SO_IGNORED"]},"=",{"val":0}]
            const result = serviceHelper.convertCQNtoCQL(expr, false);
            assert.strictEqual(result, "SO_VBELN = ''6013006712'' AND SO_IGNORED = 0 AND");
        });
        
        it('Complex expression - Should remove SO_IGNORED', function () {
            const expr = [{"xpr":[{"func":"contains","args":[{"ref":["SO_VBELN"]},{"val":"12"}]},"and",{"xpr":[{"ref":["SO_EDATU_REQUESTED"]},">=",{"val":"20251014"},"and",{"ref":["SO_EDATU_REQUESTED"]},"<=",{"val":"20251014"}]},"and",{"func":"endswith","args":[{"func":"toupper","args":[{"ref":["SO_ORT01"]}]},{"val":"CANG"}]}]},"and",{"ref":["SO_IGNORED"]},"=",{"val":0}]
            const result = serviceHelper.convertCQNtoCQL(expr, true);
            assert.strictEqual(result, "((SO_VBELN LIKE (''%'' || ''12'' || ''%'') ESCAPE ''^'') AND (SO_EDATU_REQUESTED >= ''20251014'' AND SO_EDATU_REQUESTED <= ''20251014'') AND (upper (SO_ORT01) LIKE (''%'' || ''CANG'') ESCAPE ''^''))AND");
        });

        it('Complex expression - Should keep SO_IGNORED', function () {
            const expr = [{"xpr":[{"func":"contains","args":[{"ref":["SO_VBELN"]},{"val":"12"}]},"and",{"xpr":[{"ref":["SO_EDATU_REQUESTED"]},">=",{"val":"20251014"},"and",{"ref":["SO_EDATU_REQUESTED"]},"<=",{"val":"20251014"}]},"and",{"func":"endswith","args":[{"func":"toupper","args":[{"ref":["SO_ORT01"]}]},{"val":"CANG"}]}]},"and",{"ref":["SO_IGNORED"]},"=",{"val":0}]
            const result = serviceHelper.convertCQNtoCQL(expr, false);
            assert.strictEqual(result, "((SO_VBELN LIKE (''%'' || ''12'' || ''%'') ESCAPE ''^'') AND (SO_EDATU_REQUESTED >= ''20251014'' AND SO_EDATU_REQUESTED <= ''20251014'') AND (upper (SO_ORT01) LIKE (''%'' || ''CANG'') ESCAPE ''^''))AND SO_IGNORED = 0 AND");
        });
});