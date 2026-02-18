#!/bin/bash

dir_projects_root() {
    cd ~/projects
}
install_defaultenv_plugin() {
    if ! cf plugins | grep -q "default-env"; then
        yes | cf install-plugin DefaultEnv

        if [ $? -eq 0 ]; then
            echo "Plugin installed successfully."        
        else
            echo "Error: Failed to install the DefaultEnv plugin."
            exit 1
        fi
    else
        echo "Plugin already installed." 
    fi
    
}

setup_app_services() {
    cd OTC-MON-Order-Monitoring-App-Service/    
    cf default-env order-monitoring-app-services-srv
    if [ $? -eq 0 ]; then
        echo "Default environment set successfully."
    else
        echo "Error: Failed to set default environment for order-monitoring-app-services-srv."
        exit 1
    fi
    cd ..
}

prepare_env_json() {
    DEFAULT_ENV_FILE=default-env.json
    DESTINATIONS_FILE=.destinations

    jq --argjson newDestinations "{$(cat "$DESTINATIONS_FILE")}" '
        walk(
            if type == "object" then
                if has("html5-apps-repo") then del(.["html5-apps-repo"]) 
                elif has("destinations") then .destinations = $newDestinations[] 
                else .  end
            else . end
        )
        ' "$DEFAULT_ENV_FILE" > "new_$DEFAULT_ENV_FILE"

    mv "$DEFAULT_ENV_FILE" "backup_$DEFAULT_ENV_FILE" # renaming required, because took some time to reflect changes in new file
    mv "new_$DEFAULT_ENV_FILE" "$DEFAULT_ENV_FILE"
    echo "Finished preparing $DEFAULT_ENV_FILE"
}

setup_amo() {
    cd OTC-MON-Order-Monitoring-All-My-Orders/app/allmyorders
    npm ci
    cd ../local-approuter
    npm ci
    cf default-env order-monitoring-approuter
    prepare_env_json
    dir_projects_root
}


setup_amoo() {
    cd OTC-MON-All-My-Open-Orders/app/openorders
    npm ci
    cd ../local-approuter
    npm ci
    cf default-env order-monitoring-approuter
    prepare_env_json    
    dir_projects_root
}

dir_projects_root
cf login --sso

install_defaultenv_plugin
setup_app_services
setup_amo
setup_amoo
