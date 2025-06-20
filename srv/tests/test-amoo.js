const constants = require('./utils/constants');
const assert = require('assert');
const axios = require('axios');
const cds = require('@sap/cds');
const express = require('express');
const url = require("url");
const { PORT = 4004 } = process.env;
const { format, lastDayOfMonth, startOfMonth, startOfQuarter, endOfQuarter, getQuarter, startOfYear, endOfYear } = require('date-fns');
const baseUrl = 'http://localhost:4004/odata/v4/open-orders-srv';


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
// ----------------------------ALL ISSUES -----------------------------------------------------
      // -------------------------Current Months Variant-------------------------------
  it(` Standard Variant -- All Issues for ==> ${currentMonthName} `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.standardVariantAllIssuesSelect}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` All Fields from the app --All Issues ==> for the month of ${currentMonthName}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.allFieldsViaAppAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` sales order + delivery --- All Issues ==> ${currentMonthName}  `, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.salesOrderDeliveryAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` Delivery + shipment fields -- All Issues  ==> ${currentMonthName}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.deliveryShipmentAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` delivery + shipment + billing first and final -- All Issues  ==> ${currentMonthName}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.deliveryShipmentBillingAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` order + finalorder --All Issues  ==> ${currentMonthName}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=${constants.orderFinalOrderAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
      // -------------------------ALL ISSUES  Current Months Variant-------------------------------
      // -------------------------ALL ISSUES  Current Quarter Variant-------------------------------

  it(` Standard Variant -- All Issues for ==> ${currentQuarter} Quarter `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.standardVariantAllIssuesSelect}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` All Fields from the app -- All Issues for ==> ${currentQuarter} Quarter `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.allFieldsViaAppAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` sales order + delivery  -- All Issues  ==> ${currentQuarter} Quarter `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.salesOrderDeliveryAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` Delivery + shipment fields -- All Issues  ==> ${currentQuarter} Quarter `, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.deliveryShipmentAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` delivery + shipment + billing first and final -- All Issues for ==> ${currentQuarter} Quarter `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.deliveryShipmentBillingAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` order + finalorder  -- All Issues for ==> ${currentQuarter} Quarter `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=${constants.orderFinalOrderAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
      // -------------------------ALL ISSUES  Current Quarter Variant-------------------------------
      // -------------------------ALL ISSUES  Current Year  Variant-------------------------------
  it(` Standard Variant -- All Issues for ==> ${currentYear} Year `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.standardVariantAllIssuesSelect}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` All Fields from the app -- All Issues for ==> ${currentYear} Year `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.allFieldsViaAppAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` sales order + delivery -- All Issues for ==> ${currentYear} Year `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.salesOrderDeliveryAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` Delivery + shipment fields for -- All Issues for ==> ${currentYear} Year `, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.deliveryShipmentAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` delivery + shipment + billing first and final -- All Issues for ==> ${currentYear} year `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.deliveryShipmentBillingAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` order + finalorder  -- All Issues for ==> ${currentYear} year `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=${constants.orderFinalOrderAllIssues}`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
      // -------------------------ALL ISSUES  Current Year  Variant-------------------------------
// ----------------------------ALL ISSUES -----------------------------------------------------

      const npsValues = Array.from({ length: 9 }, (_, i) => (i + 1) * 10);
      npsValues.forEach((nps)=>{
      // -------------------------Current Months Variant-------------------------------

        it(` Standard Variant -- All Issues NPS ${nps} for ==> ${currentMonthName} `, async function () {

        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay}) and SO_NPS eq '${nps}'&$select=${constants.standardVariantsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` All Fields from the app --All Issues NPS ${nps} ==> for the month of ${currentMonthName}`, async function () {
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await axios.get(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay}) and SO_NPS eq '${nps}'&$select=${constants.allFieldsViaAppsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` sales order + delivery -- All Issues NPS ${nps} ==> ${currentMonthName}  `, async function () {
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await axios.get(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay}) and SO_NPS eq '${nps}'&$select=${constants.salesOrderDeliverysalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` Delivery + shipment fields  -- All Issues NPS ${nps}  ==> ${currentMonthName}`, async function () {
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await axios.get(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay}) and SO_NPS eq '${nps}'&$select=${constants.deliveryShipmentsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` delivery + shipment + billing first and final  -- All Issues ${nps}  ==> ${currentMonthName}`, async function () {
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await axios.get(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay}) and SO_NPS eq '${nps}'&$select=${constants.deliveryShipmentBillingsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` order + finalorder  --All Issues NPS ${nps} ==> ${currentMonthName}`, async function () {
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await axios.get(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay}) and SO_NPS eq '${nps}'&$select=${constants.orderFinalOrdersalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
          // ------------------------- Current Months Variant-------------------------------
          // ------------------------- Current Quarter Variant-------------------------------
    
      it(` Standard Variant -- All Issues NPS ${nps} for ==> ${currentQuarter} Quarter `, async function () {
    
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter}) and SO_NPS eq '${nps}'&$select=${constants.standardVariantsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` All Fields from the app --All Issues NPS ${nps} for ==> ${currentQuarter} Quarter `, async function () {
    
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter}) and SO_NPS eq '${nps}'&$select=${constants.allFieldsViaAppsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` sales order + delivery -- All Issues NPS ${nps} for ==> ${currentQuarter} Quarter `, async function () {
    
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter}) and SO_NPS eq '${nps}'&$select=${constants.salesOrderDeliverysalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` Delivery + shipment fields for -- All Issues NPS ${nps} ==> ${currentQuarter} Quarter `, async function () {
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter}) and SO_NPS eq '${nps}'&$select=${constants.deliveryShipmentsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` delivery + shipment + billing first and final -- All Issues NPS ${nps} for ==> ${currentQuarter} Quarter `, async function () {
    
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter}) and SO_NPS eq '${nps}'&$select=${constants.deliveryShipmentBillingsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` order + finalorder  -- All Issues ${nps} for ==> ${currentQuarter} Quarter `, async function () {
    
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter}) and SO_NPS eq '${nps}'&$select=${constants.orderFinalOrdersalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
          // ------------------------- Current Quarter Variant-------------------------------
          // ------------------------- Current Year  Variant-------------------------------
      it(` Standard Variant -- All Issues ${nps} for ==> ${currentYear} Year `, async function () {
    
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay}) and SO_NPS eq '${nps}'&$select=${constants.standardVariantsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` All Fields from the app -- All Issues NPS ${nps} ==> ${currentYear} Year `, async function () {
    
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay}) and SO_NPS eq '${nps}'&$select=${constants.allFieldsViaAppsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` sales order + delivery --All Issues NPS ${nps}==> ${currentYear} Year `, async function () {
    
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay}) and SO_NPS eq '${nps}'&$select=${constants.salesOrderDeliverysalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` Delivery + shipment fields for -- All Issues NPS ${nps} for ==> ${currentYear} Year `, async function () {
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay}) and SO_NPS eq '${nps}'&$select=${constants.deliveryShipmentsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` delivery + shipment + billing first and final -- All Issues NPS ${nps} for ==> ${currentYear} year `, async function () {
    
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay}) and SO_NPS eq '${nps}'&$select=${constants.deliveryShipmentBillingsalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });
      it(` order + finalorder  --All Issues NPS ${nps}==> ${currentYear} year `, async function () {
    
        const timeout = 5000
        this.timeout(timeout);
        try {
          const response = await GET(`${baseUrl}/allIssues?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay}) and SO_NPS eq '${nps}'&$select=${constants.orderFinalOrdersalesorder_nps}`)
          assert.equal(200, response.status)
        } catch (error) {
          assert.strictEqual(error.code, 'ECONNABORTED');
          assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
        }
      });

    });
after(function () {
    cds.disconnect();
    server.close()
  })
});