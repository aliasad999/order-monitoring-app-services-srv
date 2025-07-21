const assert = require('assert');
const serviceHelper = require('../../utils/serviceHelper');


describe('Service Helper Test', function () {

    it('transformWhereClause - empty dates', function () {
        const originalWhere = `((SO_EDATU_REQUESTED >= ''2025-07-21'' AND SO_EDATU_REQUESTED <= ''2025-07-21'') AND (DL_WADAT IS NULL OR DL_WADAT = ''00000000'' OR DL_WADAT = '''') AND (DL_WADAT_IST IS NOT NULL AND DL_WADAT_IST != ''00000000'' AND DL_WADAT_IST != ''''))AND SO_IGNORED = 0 AND`;
        const expectedWhere = `((SO_EDATU_REQUESTED >= '20250721' AND SO_EDATU_REQUESTED <= '20250721') AND (DL_WADAT IS NULL OR DL_WADAT = '00000000' OR DL_WADAT = '') AND (DL_WADAT_IST IS NOT NULL AND DL_WADAT_IST != '00000000' AND DL_WADAT_IST != ''))AND SO_IGNORED = 0`;
        const transformedWhere = serviceHelper.transformWhereClause(originalWhere);
        assert.strictEqual(transformedWhere, expectedWhere);
    });

    it('transformWhereClause - contains with space', function () {
        const originalWhere = `((SO_EDATU_REQUESTED >= ''2025-07-01'' AND SO_EDATU_REQUESTED <= ''2025-07-31'') AND SO_HTEXT LIKE ''%'' || ''Auftrag '' || ''%'' ESCAPE ''^'') AND TM_SHIPMENT_ETA_UPDATED IS NULL AND SO_IGNORED = 0 AND`;
        const expectedWhere = `((SO_EDATU_REQUESTED >= '20250701' AND SO_EDATU_REQUESTED <= '20250731') AND SO_HTEXT LIKE '%' || 'Auftrag ' || '%' ESCAPE '^') AND TM_SHIPMENT_ETA_UPDATED IS NULL AND SO_IGNORED = 0`;
        const transformedWhere = serviceHelper.transformWhereClause(originalWhere);
        assert.strictEqual(transformedWhere, expectedWhere);
    });

});