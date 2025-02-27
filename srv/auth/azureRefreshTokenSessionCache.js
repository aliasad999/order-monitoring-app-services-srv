const NodeCache = require('node-cache'); // Create a single instance of NodeCache
const refreshTokenSessionCache = new NodeCache({ stdTTL: 86400, checkperiod: 1800 }); // cache valid for 24h, checked every 30min

module.exports = refreshTokenSessionCache;
