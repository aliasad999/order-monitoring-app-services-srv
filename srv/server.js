const tracer = require('@sap/xotel-agent-ext-js/dist/common/tracer');
const proxy = require("@cap-js-community/odata-v2-adapter");
const cds = require('@sap/cds')
const express = require('express')()
var bodyParser = require('body-parser');
require('hdb/lib/protocol/common/Constants').MAX_PACKET_SIZE = Math.pow(4,15);

const fesr = require("@sap/fesr-to-otel-js");

module.exports = cds.server;

cds.on('bootstrap', (app) => {
    app.use(proxy());
    fesr.registerFesrEndpoint(app);
})
module.exports = cds.server