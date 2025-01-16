require('dotenv').config({ path: '.env.dev' });
const { readCredential } =  require('./lib/cred')

let chatbotClientId = readCredential("order-monitoring", "password", "chatbotClientId")
let chatbotClientSecret = readCredential("order-monitoring", "password", "chatbotClientSecret")
let chatbotTenantId = readCredential("order-monitoring", "password", "chatbotTenantId")

if(!chatbotClientId){
    chatbotClientId :  process.env.clientId
}
if(!chatbotClientSecret){
    chatbotClientSecret :  process.env.clientSecret
}
if(!chatbotTenantId){
    chatbotTenantId :  process.env.tenantId
}

/**
 * Configuration object to be passed to MSAL instance on creation.
 * For a full list of MSAL Node configuration parameters, visit:
 * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-node/docs/configuration.md
 */
const msalConfig = {
    auth: {
        clientId: chatbotClientId, // 'Application (client) ID' of app registration in Azure portal - this value is a GUID
        authority: "https://login.microsoftonline.com/" + chatbotTenantId, // Full directory URL, in the form of https://login.microsoftonline.com/<tenant>
        clientSecret: chatbotClientSecret // Client secret generated from the app registration in Azure portal
    },
    system: {
        loggerOptions: {
            loggerCallback(loglevel, message, containsPii) {
                console.log(message);
            },
            piiLoggingEnabled: false,
            logLevel: 3,
        }
    }
}

const REDIRECT_URI = process.env.REDIRECT_URI;
const POST_LOGOUT_REDIRECT_URI = process.env.POST_LOGOUT_REDIRECT_URI;
const GRAPH_ME_ENDPOINT = process.env.GRAPH_API_ENDPOINT + "v1.0/me";

module.exports = {
    msalConfig,
    REDIRECT_URI,
    POST_LOGOUT_REDIRECT_URI,
    GRAPH_ME_ENDPOINT
};