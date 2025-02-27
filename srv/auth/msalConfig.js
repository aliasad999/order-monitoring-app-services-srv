const msal = require('@azure/msal-node');
const { readCredential } = require('../lib/cred');

let pca = null;

function loadCredentials() {
  return new Promise(async (resolve, reject) => {
    try {
      const chatbotClientId = await readCredential("order-monitoring", "password", "chatbotClientId");
      const chatbotTenantId = await readCredential("order-monitoring", "password", "chatbotTenantId");
      const finalChatbotClientId = chatbotClientId || process.env.clientId;
      const finalChatbotTenantId = chatbotTenantId || process.env.tenantId;

      const msalConfig = {
        auth: {
          clientId: finalChatbotClientId.value,
          authority: "https://login.microsoftonline.com/" + finalChatbotTenantId.value
        },
        system: {
          loggerOptions: {
            loggerCallback(logLevel, message) {
              console.log(message);
            },
            piiLoggingEnabled: false,
            logLevel: msal.LogLevel.Verbose,
          },
        },
      };
      pca = new msal.PublicClientApplication(msalConfig);
      resolve(pca);
    } catch (error) {
      reject(error);
    }
  });
}

function getPca() {
  if (pca) {
    return Promise.resolve(pca);
  } else {
    return loadCredentials();
  }
}

module.exports = { getPca };
