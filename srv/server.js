const tracer = require('@sap/xotel-agent-ext-js/dist/common/tracer');
const proxy = require('@sap/cds-odata-v2-adapter-proxy')
const cds = require('@sap/cds')
const express = require('express')()
var bodyParser = require('body-parser');

const fesr = require("@sap/fesr-to-otel-js");

module.exports = cds.server;

cds.on('bootstrap', (app) => {
    app.use(proxy());
    fesr.registerFesrEndpoint(app);
})
module.exports = cds.server