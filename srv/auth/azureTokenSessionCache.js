const NodeCache = require('node-cache'); // Create a single instance of NodeCache
const tokenSessionCache = new NodeCache({ stdTTL: 3600, checkperiod: 120 });

module.exports = tokenSessionCache;
