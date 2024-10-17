#!/bin/bash
npm install --save-dev date-fns
yes | cf install-plugin https://github.com/SAP/cf-cli-defaultenv-plugin/releases/download/v1.1.1/DefaultEnv.linux64

if [ $? -eq 0 ]; then
    echo "Plugin installed successfully."
    cf default-env order-monitoring-app-services-srv
    if [ $? -eq 0 ]; then
        echo "Default environment set successfully."
        npm run test-amoo
    else
        echo "Error: Failed to set default environment for order-monitoring-app-services-srv."
    fi
else
    echo "Error: Failed to install the DefaultEnv plugin."
fi