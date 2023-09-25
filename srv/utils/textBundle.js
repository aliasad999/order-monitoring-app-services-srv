const TextBundle = require('@sap/textbundle').TextBundle

function getTextBundle(locale){
    return new TextBundle('../i18n/i18n',locale);

}
module.exports = { getTextBundle }