const constants = require('./utils/constants');
const assert = require('assert');
const axios = require('axios');
const cds = require('@sap/cds');
const express = require('express');
const url = require("url");
const { PORT = 4004 } = process.env;
const { format, lastDayOfMonth, startOfMonth, startOfQuarter, endOfQuarter, getQuarter, startOfYear, endOfYear } = require('date-fns');
const baseUrl = 'http://localhost:4004/odata/v4/srv-open-orders';

var server;

describe('Start Server and check various ODATA  calls', function () {
  const { GET } = cds.test();
  const currentDate = new Date();
  const monthLastDay = lastDayOfMonth(currentDate);
  const monthFirstDay = startOfMonth(currentDate)
  const lastDay = format(monthLastDay, "yyyy-MM-dd'T'00:00:00'Z'");
  const firstDay = format(monthFirstDay, "yyyy-MM-dd'T'00:00:00'Z'");
  const currentQuarterFirstDay = startOfQuarter(currentDate);
  const currentQuarterLastDay = endOfQuarter(currentDate);
  const currentMonthName = currentDate.toLocaleString('default', { month: 'long' });
  const currentYearFirstDay = startOfYear(currentDate);
  const currentYearLastDay = endOfYear(currentDate);
  const firstDayQuarter = format(currentQuarterFirstDay, "yyyy-MM-dd'T'00:00:00'Z'");
  const lastDayQuarter = format(currentQuarterLastDay, "yyyy-MM-dd'T'00:00:00'Z'");
  const currentQuarter = getQuarter(currentDate);
  const YearFirstDay = format(currentYearFirstDay, "yyyy-MM-dd'T'00:00:00'Z'");
  const YearLastDay = format(currentYearLastDay, "yyyy-MM-dd'T'00:00:00'Z'");
  const currentYear = currentDate.getFullYear();



  before(async () => {
    const app = express();
    server = app.listen(PORT);
    await cds.connect(!cds.db && cds.env.requires.db || false);
    await cds.serve(undefined,).in(app);

  });
  it('Check Service', async () => {
    try {
      const response = await GET(`${baseUrl}`)
      assert.equal(200, response.status);
    } catch (error) {
      assert.fail(error)
    }
  });

  it(` Standard Variant for Result set for ==> ${currentMonthName} `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.standardVariantResult}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` All Fields from the app  ==> for the month of ${currentMonthName}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.allFieldsResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` sales order + delivery for ==> ${currentMonthName}  `, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.salesOrderDeliveryResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` Delivery + shipment fields for ==> ${currentMonthName}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.deliveryShipmentResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` delivery + shipment + billing first and final for ==> ${currentMonthName}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.deliveryShipmentBillingResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` order + finalorder  ==> ${currentMonthName}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.orderFinalOrderResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` Standard Variant for Result set for ==> ${currentQuarter} Quarter`, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/Results?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.standardVariantResult}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` All Fields from the app for ==> ${currentQuarter} Quarter`, async function () {
    const timeout = 10000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.allFieldsResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` sales order + delivery for ==> ${currentQuarter} Quarter `, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.salesOrderDeliveryResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` Delivery + shipment fields for ==> ${currentQuarter} Quarter`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.deliveryShipmentResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` delivery + shipment + billing first and final for ==>  ${currentQuarter} Quarter`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.deliveryShipmentBillingResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` order + final order for  ==>  ${currentQuarter} Quarter`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.orderFinalOrderResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` Standard Variant for Result set for ==> year ${currentYear} `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/Results?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.standardVariantResult}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` All Fields from the app for ==> year ${currentYear}`, async function () {
    const timeout = 18000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.allFieldsResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  // it(` sales order + delivery for ==> year ${currentYear}  `, async function () {
  //   const timeout = 6000
  //   this.timeout(timeout);
  //   try {
  //     const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.salesOrderDeliveryResults}`)
  //     assert.equal(200, response.status)
  //   } catch (error) {
  //     assert.strictEqual(error.code, 'ECONNABORTED');
  //     assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
  //   }
  // });

  it(` Delivery + shipment fields for ==> year ${currentYear}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.deliveryShipmentResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` delivery + shipment + billing first and final for ==> year ${currentYear}`, async function () {
    const timeout = 7000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.deliveryShipmentBillingResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` order + final order for ==> year ${currentYear}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.orderFinalOrderResults}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  after(function () {
    cds.disconnect();
    server.close()
  });
});