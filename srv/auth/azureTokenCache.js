const NodeCache = require('node-cache'); 

const azureTokenSessionCache = new NodeCache({ stdTTL: 3600, checkperiod: 120 }); // cache valid for 1h
const azureRefreshTokenSessionCache = new NodeCache({ stdTTL: 82800, checkperiod: 1800 }); // cache valid for 23h 

azureTokenSessionCache.on('delete', (key, value) => {
    console.log(`Access token expired. Key: ${key}`);
});

azureRefreshTokenSessionCache.on('delete', (key, value) => {
    console.log(`Refresh token expired. Key: ${key}`);
});

module.exports = { azureTokenSessionCache, azureRefreshTokenSessionCache };