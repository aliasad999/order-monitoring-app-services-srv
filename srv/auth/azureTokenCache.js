const NodeCache = require('node-cache'); 

const azureTokenSessionCache = new NodeCache({ stdTTL: 7200, checkperiod: 120 });
const azureRefreshTokenSessionCache = new NodeCache({ stdTTL: 86400, checkperiod: 1800 });

azureTokenSessionCache.on('delete', (key, value) => {
    console.log(`Access token expired. Key: ${key}`);
});

azureRefreshTokenSessionCache.on('delete', (key, value) => {
    console.log(`Refresh token expired. Key: ${key}`);
});

module.exports = { azureTokenSessionCache, azureRefreshTokenSessionCache };