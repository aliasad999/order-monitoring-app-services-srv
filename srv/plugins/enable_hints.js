const SelectBuilder = require("@sap/cds/libx/_runtime/db/sql-builder/SelectBuilder");
const { build } = SelectBuilder.prototype;

// with hint support
Object.assign(SelectBuilder.prototype, {
  build() {
    const result = build.apply(this, arguments);

    // to support also expands we will proxy all found hints to the end of the query
    const hintsRegex = /(?<=WITH HINT\().*?(?=\))/g;
    const foundHints = [result.sql.match(hintsRegex)]
      .flat()
      .filter((hints) => hints)
      .flatMap((hints) => hints.split(","));
    if (!this._obj.SELECT.withHint) {
      this._obj.SELECT.withHint = foundHints;
      // remove current hints to avoid duplicate definition
      result.sql = result.sql.replace(/(WITH HINT\().*?(\))/g, "");
    }

    if (
      Array.isArray(this._obj.SELECT.withHint) &&
      this._obj.SELECT.withHint.length
    ) {
      this._withHint(result);
    }

    return result;
  },
  _withHint(result) {
    result.sql = result.sql.replace(/ with parameters \(.*\)$/, '');
    result.sql = result.sql.concat(
      ` WITH HINT(${this._obj.SELECT.withHint.join(",")})`
    );
  },
});

// query handler
module.exports = function enableHints({ target, query }) {
  let withHint = target["@Consumption.dbHints"];
  if (!withHint) withHint = ['USE_HEX_PLAN','HEX_INDEX_JOIN']
  Array.isArray(withHint) && Object.assign(query.SELECT, { withHint });
};