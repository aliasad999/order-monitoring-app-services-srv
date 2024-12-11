#!/bin/bash
npm install
yes | cf install-plugin DefaultEnv

if [ $? -eq 0 ]; then
    echo "Plugin installed successfully."
    cf default-env order-monitoring-app-services-srv
    if [ $? -eq 0 ]; then
        echo "Default environment set successfully."
        npm run test
    else
        echo "Error: Failed to set default environment for order-monitoring-app-services-srv."
    fi
else
    echo "Error: Failed to install the DefaultEnv plugin."
fi