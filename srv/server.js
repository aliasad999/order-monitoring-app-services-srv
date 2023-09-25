const proxy = require('@sap/cds-odata-v2-adapter-proxy')
const cds = require('@sap/cds')
const express = require('express')()
var bodyParser = require('body-parser');

cds.on('bootstrap', (app) => {
    app.use(proxy());
    app.use(bodyParser.json({ limit: '100mb' }));
})
module.exports = cds.server