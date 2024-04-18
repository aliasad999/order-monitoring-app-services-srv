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
  const lastDay = format(monthLastDay, 'yyyy-MM-dd');
  const firstDay = format(monthFirstDay, 'yyyy-MM-dd');
  const currentQuarterFirstDay = startOfQuarter(currentDate);
  const currentQuarterLastDay = endOfQuarter(currentDate);
  const currentMonthName = currentDate.toLocaleString('default', { month: 'long' });
  const currentYearFirstDay = startOfYear(currentDate);
  const currentYearLastDay = endOfYear(currentDate);
  const firstDayQuarter = format(currentQuarterFirstDay, 'yyyy-MM-dd');
  const lastDayQuarter = format(currentQuarterLastDay, 'yyyy-MM-dd');
  const currentQuarter = getQuarter(currentDate);
  const YearFirstDay = format(currentYearFirstDay, 'yyyy-MM-dd');
  const YearLastDay = format(currentYearLastDay, 'yyyy-MM-dd');
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
      const response = await GET(`${baseUrl}/Results?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_MAKTX,SO_KDMAT,SO_AG_PARTNER,SO_AG_PARTNER_NAME,SO_LAND1,SO_LANDX,SO_ORT01,SO_VKORG,SO_VKORG_NAME1,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_VRKME,SO_EDATU_CONFIRMED,SO_KBMENG,SO_F_LDDAT,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_FAKSP,SO_FAKSP_VTEXT,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_SUPPLY_SITUATION_DESCR,SO_KBETR,SO_WAERS,SO_NETWR,SO_WAERK,SO_HTEXT,SO_PSTYV,SO_PSTYV_VTEXT,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_VKBUR_BEZEI,SO_CO_PARTNER,SO_CO_PARTNER_NAME,SO_NY_PARTNER,SO_NY_PARTNER_NAME,SO_AS_PARTNER,SO_AS_PARTNER_NAME,SO_VE_PARTNER,SO_VE_PARTNER_NAME,SO_AM_PARTNER,SO_AM_PARTNER_NAME,SO_VBTYP`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=TM_MANDT,DL_MANDT,SO_MANDT,DL_WADAT_IST,DL_CHARG,DL_TRAID,DL_VBELN,DL_LFIMG,DL_VRKME,DL_LFART,DL_LFART_VTEXT,DL_PEND_DEL_QUAN,DL_LFDAT,TM_TKNUM,TM_SHIPMENT_ALERT,TM_SHIPMENT_CURRENT_STATUS,TM_VSART,TM_VSART_BEZEI,TM_EXTI1,TM_DATEN,TM_DATBG,TM_AR_DATE,TM_DPTEN,TM_DPTBG,TM_TDLNR,TM_TDLNR_NAME1,DL_WADAT,BL_VBELN_INV_LAST,BL_VBELN_INV_FIRST,BL_XBLNR,SO_F_ZZ0S2MATUG,SO_AM_PARTNER,SO_AM_PARTNER_NAME,SO_AS_PARTNER,SO_AS_PARTNER_NAME,SO_F_AS_PARTNER,SO_F_AS_PARTNER_NAME,DL_ZZ0S2BLNR,SO_F_DGLTP,SO_FAKSP,SO_FAKSP_VTEXT,SO_CO_PARTNER,SO_CO_PARTNER_NAME,SO_EDATU_CONFIRMED,SO_KBMENG,SO_VRKME,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_ZZ0S2REVG2,SO_KDMAT,SO_KNREF_HEAD,SO_VTWEG,SO_F_VBELN,SO_I_VBELN,SO_REQ_TEXT,SO_VBUND,SO_GUSCON_LEVEL,SO_HTEXT,SO_INCO1,SO_INCO2,SO_PSTYV,SO_PSTYV_VTEXT,SO_F_PSMNG,SO_F_AMEIN,SO_BASF_LOFCR,LAST_NOTE,SO_LEVEL_TYPE,SO_F_LDDAT,SO_MATNR,SO_MAKTX,SO_DISPO,SO_VBELN,SO_NETWR,SO_WAERK,SO_N_VBELN,SO_NY_PARTNER,SO_NY_PARTNER_NAME,SO_POSNR,SO_ISCOMPLETED,SO_AUART,TM_STTRG,TM_STTRG_DDTEXT,SO_ZTERM,SO_WERKS,SO_F_WERKS,SO_BSARK,SO_BSARK_VTEXT,SO_F_VKORG,SO_F_VKORG_VTEXT,SO_KBETR,SO_WAERS,SO_PRSDT,SO_F_AUFNR,SO_KOSCH,SO_BSTKD,SO_EDATU_REQUESTED,SO_KWMENG,SO_ROUTE,SO_VKGRP,SO_VKGRP_BEZEI,SO_VKBUR,SO_VKBUR_BEZEI,SO_VKORG,SO_VKORG_NAME1,SO_ZZDKPPRODB,SO_WE_PARTNER,SO_WE_PARTNER_NAME,SO_ORT01,SO_LAND1,SO_LANDX,SO_F_VSBED,SO_F_VSBED_VTEXT,SO_AG_PARTNER,SO_AG_PARTNER_NAME,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_SUPPLY_SITUATION_DESCR,SO_TRAGR,SO_TRAGR_VTEXT,SO_F_TDDAT,SO_UNCONFIRMED_QTY,SO_VE_PARTNER,SO_VE_PARTNER_NAME,DL_HSDAT,DL_VFDAT,SO_VBTYP,TM_TRACKING_ID_ELEM,TM_TRACKING_ID_COMP`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=DL_MANDT,SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,DL_CHARG,DL_VBELN,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=TM_MANDT,DL_MANDT,DL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=TM_MANDT,DL_MANDT,BL_MANDT_INV_FIRST,BL_MANDT_INV_LAST,DL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,BL_VBELN_INV_FIRST,BL_VBELN_INV_LAST,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG,BL_XBLNR`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDay} and SO_EDATU_REQUESTED le ${lastDay})&$select=SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_F_LDDAT,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_FAKSP,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_F_VBELN,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,SO_F_WERKS,SO_F_VKORG,SO_F_TDDAT,SO_F_ZZ0S2MATUG,SO_F_VSBED,SO_F_AUFNR,SO_F_DGLTP,SO_F_PSMNG,SO_F_AS_PARTNER`)
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
      const response = await GET(`${baseUrl}/Results?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_MAKTX,SO_KDMAT,SO_AG_PARTNER,SO_AG_PARTNER_NAME,SO_LAND1,SO_LANDX,SO_ORT01,SO_VKORG,SO_VKORG_NAME1,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_VRKME,SO_EDATU_CONFIRMED,SO_KBMENG,SO_F_LDDAT,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_FAKSP,SO_FAKSP_VTEXT,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_SUPPLY_SITUATION_DESCR,SO_KBETR,SO_WAERS,SO_NETWR,SO_WAERK,SO_HTEXT,SO_PSTYV,SO_PSTYV_VTEXT,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_VKBUR_BEZEI,SO_CO_PARTNER,SO_CO_PARTNER_NAME,SO_NY_PARTNER,SO_NY_PARTNER_NAME,SO_AS_PARTNER,SO_AS_PARTNER_NAME,SO_VE_PARTNER,SO_VE_PARTNER_NAME,SO_AM_PARTNER,SO_AM_PARTNER_NAME,SO_VBTYP`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` All Fields from the app for ==> ${currentQuarter} Quarter`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=TM_MANDT,DL_MANDT,SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_MAKTX,SO_KDMAT,SO_AG_PARTNER,SO_AG_PARTNER_NAME,SO_WE_PARTNER,SO_WE_PARTNER_NAME,SO_LAND1,SO_LANDX,SO_ORT01,SO_VKORG,SO_VKORG_NAME1,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_VRKME,SO_EDATU_CONFIRMED,SO_KBMENG,SO_F_LDDAT,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_FAKSP,SO_FAKSP_VTEXT,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_SUPPLY_SITUATION_DESCR,SO_KBETR,SO_WAERS,SO_NETWR,SO_WAERK,SO_HTEXT,SO_PSTYV,SO_PSTYV_VTEXT,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_VKBUR_BEZEI,SO_CO_PARTNER,SO_CO_PARTNER_NAME,SO_NY_PARTNER,SO_NY_PARTNER_NAME,SO_AS_PARTNER,SO_AS_PARTNER_NAME,SO_VE_PARTNER,SO_VE_PARTNER_NAME,SO_AM_PARTNER,SO_AM_PARTNER_NAME,DL_WADAT_IST,SO_F_ZZ0S2MATUG,SO_F_AS_PARTNER,SO_F_AS_PARTNER_NAME,TM_DATEN,TM_DATBG,DL_ZZ0S2BLNR,SO_F_DGLTP,DL_CHARG,BL_VBELN_INV_LAST,BL_VBELN_INV_FIRST,TM_AR_DATE,DL_TRAID,SO_ZZ0S2REVG2,DL_VBELN,DL_LFIMG,DL_VRKME,DL_LFART,DL_LFART_VTEXT,TM_DPTEN,TM_DPTBG,SO_F_VBELN,SO_I_VBELN,TM_TDLNR,TM_TDLNR_NAME1,SO_GUSCON_LEVEL,SO_INCO1,SO_INCO2,SO_F_PSMNG,SO_F_AMEIN,SO_BASF_LOFCR,LAST_NOTE,SO_LEVEL_TYPE,SO_N_VBELN,BL_XBLNR,SO_ISCOMPLETED,TM_STTRG,TM_STTRG_DDTEXT,SO_ZTERM,DL_PEND_DEL_QUAN,DL_LFDAT,DL_WADAT,SO_F_WERKS,SO_BSARK,SO_BSARK_VTEXT,SO_F_VKORG,SO_F_VKORG_VTEXT,SO_PRSDT,SO_F_AUFNR,SO_BSTKD,SO_ROUTE,SO_VKGRP,SO_VKGRP_BEZEI,SO_ZZDKPPRODB,TM_TKNUM,TM_SHIPMENT_ALERT,TM_SHIPMENT_CURRENT_STATUS,SO_F_VSBED,SO_F_VSBED_VTEXT,TM_VSART,TM_VSART_BEZEI,SO_TRAGR,SO_TRAGR_VTEXT,SO_F_TDDAT,TM_EXTI1,DL_HSDAT,DL_VFDAT,SO_VBTYP,TM_TRACKING_ID_ELEM,TM_TRACKING_ID_COMP`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=DL_MANDT,SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,DL_CHARG,DL_VBELN,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=TM_MANDT,DL_MANDT,DL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=TM_MANDT,DL_MANDT,BL_MANDT_INV_FIRST,BL_MANDT_INV_LAST,DL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,BL_VBELN_INV_FIRST,BL_VBELN_INV_LAST,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG,BL_XBLNR`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${firstDayQuarter} and SO_EDATU_REQUESTED le ${lastDayQuarter})&$select=SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_F_LDDAT,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_FAKSP,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_F_VBELN,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,SO_F_WERKS,SO_F_VKORG,SO_F_TDDAT,SO_F_ZZ0S2MATUG,SO_F_VSBED,SO_F_AUFNR,SO_F_DGLTP,SO_F_PSMNG,SO_F_AS_PARTNER`)
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
      const response = await GET(`${baseUrl}/Results?$skip=0&$top=981&$filter=( SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_MAKTX,SO_KDMAT,SO_AG_PARTNER,SO_AG_PARTNER_NAME,SO_LAND1,SO_LANDX,SO_ORT01,SO_VKORG,SO_VKORG_NAME1,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_VRKME,SO_EDATU_CONFIRMED,SO_KBMENG,SO_F_LDDAT,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_FAKSP,SO_FAKSP_VTEXT,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_SUPPLY_SITUATION_DESCR,SO_KBETR,SO_WAERS,SO_NETWR,SO_WAERK,SO_HTEXT,SO_PSTYV,SO_PSTYV_VTEXT,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_VKBUR_BEZEI,SO_CO_PARTNER,SO_CO_PARTNER_NAME,SO_NY_PARTNER,SO_NY_PARTNER_NAME,SO_AS_PARTNER,SO_AS_PARTNER_NAME,SO_VE_PARTNER,SO_VE_PARTNER_NAME,SO_AM_PARTNER,SO_AM_PARTNER_NAME,SO_VBTYP`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` All Fields from the app for ==> year ${currentYear}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=TM_MANDT,DL_MANDT,SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_MAKTX,SO_KDMAT,SO_AG_PARTNER,SO_AG_PARTNER_NAME,SO_WE_PARTNER,SO_WE_PARTNER_NAME,SO_LAND1,SO_LANDX,SO_ORT01,SO_VKORG,SO_VKORG_NAME1,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_VRKME,SO_EDATU_CONFIRMED,SO_KBMENG,SO_F_LDDAT,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_FAKSP,SO_FAKSP_VTEXT,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_SUPPLY_SITUATION_DESCR,SO_KBETR,SO_WAERS,SO_NETWR,SO_WAERK,SO_HTEXT,SO_PSTYV,SO_PSTYV_VTEXT,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_VKBUR_BEZEI,SO_CO_PARTNER,SO_CO_PARTNER_NAME,SO_NY_PARTNER,SO_NY_PARTNER_NAME,SO_AS_PARTNER,SO_AS_PARTNER_NAME,SO_VE_PARTNER,SO_VE_PARTNER_NAME,SO_AM_PARTNER,SO_AM_PARTNER_NAME,DL_WADAT_IST,SO_F_ZZ0S2MATUG,SO_F_AS_PARTNER,SO_F_AS_PARTNER_NAME,TM_DATEN,TM_DATBG,DL_ZZ0S2BLNR,SO_F_DGLTP,DL_CHARG,BL_VBELN_INV_LAST,BL_VBELN_INV_FIRST,TM_AR_DATE,DL_TRAID,SO_ZZ0S2REVG2,DL_VBELN,DL_LFIMG,DL_VRKME,DL_LFART,DL_LFART_VTEXT,TM_DPTEN,TM_DPTBG,SO_F_VBELN,SO_I_VBELN,TM_TDLNR,TM_TDLNR_NAME1,SO_GUSCON_LEVEL,SO_INCO1,SO_INCO2,SO_F_PSMNG,SO_F_AMEIN,SO_BASF_LOFCR,LAST_NOTE,SO_LEVEL_TYPE,SO_N_VBELN,BL_XBLNR,SO_ISCOMPLETED,TM_STTRG,TM_STTRG_DDTEXT,SO_ZTERM,DL_PEND_DEL_QUAN,DL_LFDAT,DL_WADAT,SO_F_WERKS,SO_BSARK,SO_BSARK_VTEXT,SO_F_VKORG,SO_F_VKORG_VTEXT,SO_PRSDT,SO_F_AUFNR,SO_BSTKD,SO_ROUTE,SO_VKGRP,SO_VKGRP_BEZEI,SO_ZZDKPPRODB,TM_TKNUM,TM_SHIPMENT_ALERT,TM_SHIPMENT_CURRENT_STATUS,SO_F_VSBED,SO_F_VSBED_VTEXT,TM_VSART,TM_VSART_BEZEI,SO_TRAGR,SO_TRAGR_VTEXT,SO_F_TDDAT,TM_EXTI1,DL_HSDAT,DL_VFDAT,SO_VBTYP,TM_TRACKING_ID_ELEM,TM_TRACKING_ID_COMP`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` sales order + delivery for ==> year ${currentYear}  `, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=DL_MANDT,SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,DL_CHARG,DL_VBELN,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` Delivery + shipment fields for ==> year ${currentYear}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=TM_MANDT,DL_MANDT,DL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` delivery + shipment + billing first and final for ==> year ${currentYear}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=TM_MANDT,DL_MANDT,BL_MANDT_INV_FIRST,BL_MANDT_INV_LAST,DL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,BL_VBELN_INV_FIRST,BL_VBELN_INV_LAST,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG,BL_XBLNR`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED ge ${YearFirstDay} and SO_EDATU_REQUESTED le ${YearLastDay})&$select=SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_F_LDDAT,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_FAKSP,SO_F_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_F_VBELN,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,SO_F_WERKS,SO_F_VKORG,SO_F_TDDAT,SO_F_ZZ0S2MATUG,SO_F_VSBED,SO_F_AUFNR,SO_F_DGLTP,SO_F_PSMNG,SO_F_AS_PARTNER`)
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