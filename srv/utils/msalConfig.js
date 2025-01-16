const msal = require('@azure/msal-node');
const { readCredential } = require('../lib/cred');

let cca = null;

function loadCredentials() {
  return new Promise(async (resolve, reject) => {
    try {
      const chatbotClientId = await readCredential("order-monitoring", "password", "chatbotClientId");
      const chatbotClientSecret = await readCredential("order-monitoring", "password", "chatbotClientSecret");
      const chatbotTenantId = await readCredential("order-monitoring", "password", "chatbotTenantId");

      const finalChatbotClientId = chatbotClientId || process.env.clientId;
      const finalChatbotClientSecret = chatbotClientSecret || process.env.clientSecret;
      const finalChatbotTenantId = chatbotTenantId || process.env.tenantId;

      const msalConfig = {
        auth: {
          clientId: finalChatbotClientId.value,
          authority: "https://login.microsoftonline.com/" + finalChatbotTenantId.value,
          clientSecret: finalChatbotClientSecret.value,
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

      cca = new msal.ConfidentialClientApplication(msalConfig);

      resolve(cca); 
    } catch (error) {
      reject(error); 
    }
  });
}

function getCca() {
  if (cca) {
    return Promise.resolve(cca); 
  } else {
    return loadCredentials(); 
  }
}

module.exports = { getCca };
