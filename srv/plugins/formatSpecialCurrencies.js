/**
 * Formats the given amount based on currency decimal places.
 * @param {number} SO_NETWR - The amount to be formatted.
 * @param {string} SO_WAERK - The currency unit code.
 * @param {Array} currencyTable - Array of currency data with decimal places for each currency.
 * @returns {string} - Formatted amount based on currency rules.
 */
function formatSpecialCurrency(SO_NETWR, SO_WAERK, currencyTable) {
    if (SO_NETWR == null) return null;

    // Find the decimal places for the given currency in the currency table
    const currencyData = currencyTable.find(entry => entry.currencyCode === SO_WAERK);
    const decimalPlaces = currencyData ? currencyData.decimalPlaces : 2;
    if ( decimalPlaces !== 2 ){
    // Adjust amount based on currency-specific decimal places
    const adjustedAmount = SO_NETWR * Math.pow(10, 2 - decimalPlaces);
    return adjustedAmount.toFixed(decimalPlaces)
    }
    else return SO_NETWR;
}

module.exports = formatSpecialCurrency;
