# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch` 
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.

## Scripts
### setup-local-test.sh
In case you want to test locally (= w/o deploying to a CF space), this script prepares your environment, executing the following steps:
1. In App-Services Folder:
    ```bash
    user: OTC-MON-Order-Monitoring-App-Service $ cf install-plugin DefaultEnv
    user: OTC-MON-Order-Monitoring-App-Service $ cf default-env order-monitoring-app-services-srv
    ```
2. in App-Folder (AMO and AMOO, example with AMO):
    ```bash
    user: OTC-MON-Order-Monitoring-All-My-Order $ cd app/local-approuter
    user: local-approuter $ cf default-env order-monitoring-approuter
    ```
    Adapt default-env.json: Copy .destinations-file content to "destinations" and delete attribute "html5-apps-repo"
3. Start App-Services in a separate terminal:
    ```bash
    user: OTC-MON-Order-Monitoring-App-Service $ cds run
    ```

4. Start App (AMO or AMOO) in app/local-approuter: 
    ```bash
    user: local-approuter $ npm start
    ```

The script "setup-local-test.sh" covers the steps 1. and 2. The other step will not be covered in case you need to debug.
To ensure the script is working properly, please make sure the folders are below the project folder /home/user/projects:
- OTC-MON-All-My-Open-Orders
- OTC-MON-Order-Monitoring-All-My-Orders
- OTC-MON-Order-Monitoring-App-Service