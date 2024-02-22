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
      const response = await GET(`${baseUrl}/Results?$skip=0&$top=981&$filter=(%20SO_EDATU_REQUESTED%20ge%20${firstDay}%20and%20SO_EDATU_REQUESTED%20le%20${lastDay})&$select=SO_MANDT%2cSO_VBELN%2cSO_POSNR%2cSO_AUART%2cSO_ERDAT_ORDER%2cSO_ERDAT_ITEM%2cSO_WERKS%2cSO_VTWEG%2cSO_MATNR%2cSO_MAKTX%2cSO_KDMAT%2cSO_AG_PARTNER%2cSO_AG_PARTNER_NAME%2cSO_LAND1%2cSO_LANDX%2cSO_ORT01%2cSO_VKORG%2cSO_VKORG_NAME1%2cSO_KNREF_HEAD%2cSO_VBUND%2cSO_EDATU_REQUESTED%2cSO_KWMENG%2cSO_VRKME%2cSO_EDATU_CONFIRMED%2cSO_KBMENG%2cSO_F_LDDAT%2cSO_UNCONFIRMED_QTY%2cSO_REQ_TEXT%2cSO_FAKSP%2cSO_FAKSP_VTEXT%2cSO_LGORT%2cSO_SUPPLY_SITUATION%2cSO_SUPPLY_SITUATION_DESCR%2cSO_KBETR%2cSO_WAERS%2cSO_NETWR%2cSO_WAERK%2cSO_HTEXT%2cSO_PSTYV%2cSO_PSTYV_VTEXT%2cSO_DISPO%2cSO_KOSCH%2cSO_VKBUR%2cSO_VKBUR_BEZEI%2cSO_CO_PARTNER%2cSO_CO_PARTNER_NAME%2cSO_NY_PARTNER%2cSO_NY_PARTNER_NAME%2cSO_AS_PARTNER%2cSO_AS_PARTNER_NAME%2cSO_VE_PARTNER%2cSO_VE_PARTNER_NAME%2cSO_AM_PARTNER%2cSO_AM_PARTNER_NAME%2cSO_VBTYP`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` All Fields from the app for ==> ${currentMonthName}`, async function () {
    const timeout = 6000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${firstDay}%20and%20SO_EDATU_REQUESTED%20le%20${lastDay})&$select=TM_MANDT%2cDL_MANDT%2cSO_MANDT%2cDL_WADAT_IST%2cDL_CHARG%2cDL_TRAID%2cDL_VBELN%2cDL_LFIMG%2cDL_VRKME%2cDL_LFART%2cDL_LFART_VTEXT%2cDL_PEND_DEL_QUAN%2cDL_LFDAT%2cTM_TKNUM%2cTM_SHIPMENT_ALERT%2cTM_SHIPMENT_CURRENT_STATUS%2cTM_VSART%2cTM_VSART_BEZEI%2cTM_EXTI1%2cTM_DATEN%2cTM_DATBG%2cTM_AR_DATE%2cTM_DPTEN%2cTM_DPTBG%2cTM_TDLNR%2cTM_TDLNR_NAME1%2cDL_WADAT%2cBL_VBELN_INV_LAST%2cBL_VBELN_INV_FIRST%2cBL_XBLNR%2cSO_F_ZZ0S2MATUG%2cSO_AM_PARTNER%2cSO_AM_PARTNER_NAME%2cSO_AS_PARTNER%2cSO_AS_PARTNER_NAME%2cSO_F_AS_PARTNER%2cSO_F_AS_PARTNER_NAME%2cDL_ZZ0S2BLNR%2cSO_F_DGLTP%2cSO_FAKSP%2cSO_FAKSP_VTEXT%2cSO_CO_PARTNER%2cSO_CO_PARTNER_NAME%2cSO_EDATU_CONFIRMED%2cSO_KBMENG%2cSO_VRKME%2cSO_ERDAT_ORDER%2cSO_ERDAT_ITEM%2cSO_ZZ0S2REVG2%2cSO_KDMAT%2cSO_KNREF_HEAD%2cSO_VTWEG%2cSO_F_VBELN%2cSO_I_VBELN%2cSO_REQ_TEXT%2cSO_VBUND%2cSO_GUSCON_LEVEL%2cSO_HTEXT%2cSO_INCO1%2cSO_INCO2%2cSO_PSTYV%2cSO_PSTYV_VTEXT%2cSO_F_PSMNG%2cSO_F_AMEIN%2cSO_BASF_LOFCR%2cLAST_NOTE%2cSO_LEVEL_TYPE%2cSO_F_LDDAT%2cSO_MATNR%2cSO_MAKTX%2cSO_DISPO%2cSO_VBELN%2cSO_NETWR%2cSO_WAERK%2cSO_N_VBELN%2cSO_NY_PARTNER%2cSO_NY_PARTNER_NAME%2cSO_POSNR%2cSO_ISCOMPLETED%2cSO_AUART%2cTM_STTRG%2cTM_STTRG_DDTEXT%2cSO_ZTERM%2cSO_WERKS%2cSO_F_WERKS%2cSO_BSARK%2cSO_BSARK_VTEXT%2cSO_F_VKORG%2cSO_F_VKORG_VTEXT%2cSO_KBETR%2cSO_WAERS%2cSO_PRSDT%2cSO_F_AUFNR%2cSO_KOSCH%2cSO_BSTKD%2cSO_EDATU_REQUESTED%2cSO_KWMENG%2cSO_ROUTE%2cSO_VKGRP%2cSO_VKGRP_BEZEI%2cSO_VKBUR%2cSO_VKBUR_BEZEI%2cSO_VKORG%2cSO_VKORG_NAME1%2cSO_ZZDKPPRODB%2cSO_WE_PARTNER%2cSO_WE_PARTNER_NAME%2cSO_ORT01%2cSO_LAND1%2cSO_LANDX%2cSO_F_VSBED%2cSO_F_VSBED_VTEXT%2cSO_AG_PARTNER%2cSO_AG_PARTNER_NAME%2cSO_LGORT%2cSO_SUPPLY_SITUATION%2cSO_SUPPLY_SITUATION_DESCR%2cSO_TRAGR%2cSO_TRAGR_VTEXT%2cSO_F_TDDAT%2cSO_UNCONFIRMED_QTY%2cSO_VE_PARTNER%2cSO_VE_PARTNER_NAME%2cDL_HSDAT%2cDL_VFDAT%2cSO_VBTYP%2cTM_TRACKING_ID_ELEM%2cTM_TRACKING_ID_COMP`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${firstDay}%20and%20SO_EDATU_REQUESTED%20le%20${lastDay})&$select=DL_MANDT%2cSO_MANDT%2cSO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,DL_CHARG,DL_VBELN,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${firstDay}%20and%20SO_EDATU_REQUESTED%20le%20${lastDay})&$select=TM_MANDT%2cDL_MANDT%2cDL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${firstDay}%20and%20SO_EDATU_REQUESTED%20le%20${lastDay})&$select=TM_MANDT%2cDL_MANDT%2cBL_MANDT_INV_FIRST%2cBL_MANDT_INV_LAST%2cDL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,BL_VBELN_INV_FIRST,BL_VBELN_INV_LAST,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG,BL_XBLNR`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` order + finalorder  ==> ${currentMonthName}`, async function () {
    const timeout = 6000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${firstDay}%20and%20SO_EDATU_REQUESTED%20le%20${lastDay})&$select=SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_F_LDDAT,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_FAKSP,SO_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_F_VBELN,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,SO_F_WERKS,SO_F_VKORG,SO_F_TDDAT,SO_F_ZZ0S2MATUG,SO_F_VSBED,SO_F_AUFNR,SO_F_DGLTP,SO_F_PSMNG,SO_F_AS_PARTNER`)
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
      const response = await GET(`${baseUrl}/Results?$skip=0&$top=981&$filter=(%20SO_EDATU_REQUESTED%20ge%20${firstDayQuarter}%20and%20SO_EDATU_REQUESTED%20le%20${lastDayQuarter})&$select=SO_MANDT%2cSO_VBELN%2cSO_POSNR%2cSO_AUART%2cSO_ERDAT_ORDER%2cSO_ERDAT_ITEM%2cSO_WERKS%2cSO_VTWEG%2cSO_MATNR%2cSO_MAKTX%2cSO_KDMAT%2cSO_AG_PARTNER%2cSO_AG_PARTNER_NAME%2cSO_LAND1%2cSO_LANDX%2cSO_ORT01%2cSO_VKORG%2cSO_VKORG_NAME1%2cSO_KNREF_HEAD%2cSO_VBUND%2cSO_EDATU_REQUESTED%2cSO_KWMENG%2cSO_VRKME%2cSO_EDATU_CONFIRMED%2cSO_KBMENG%2cSO_F_LDDAT%2cSO_UNCONFIRMED_QTY%2cSO_REQ_TEXT%2cSO_FAKSP%2cSO_FAKSP_VTEXT%2cSO_LGORT%2cSO_SUPPLY_SITUATION%2cSO_SUPPLY_SITUATION_DESCR%2cSO_KBETR%2cSO_WAERS%2cSO_NETWR%2cSO_WAERK%2cSO_HTEXT%2cSO_PSTYV%2cSO_PSTYV_VTEXT%2cSO_DISPO%2cSO_KOSCH%2cSO_VKBUR%2cSO_VKBUR_BEZEI%2cSO_CO_PARTNER%2cSO_CO_PARTNER_NAME%2cSO_NY_PARTNER%2cSO_NY_PARTNER_NAME%2cSO_AS_PARTNER%2cSO_AS_PARTNER_NAME%2cSO_VE_PARTNER%2cSO_VE_PARTNER_NAME%2cSO_AM_PARTNER%2cSO_AM_PARTNER_NAME%2cSO_VBTYP`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${firstDayQuarter}%20and%20SO_EDATU_REQUESTED%20le%20${lastDayQuarter})&$select=TM_MANDT%2cDL_MANDT%2cSO_MANDT%2cSO_VBELN%2cSO_POSNR%2cSO_AUART%2cSO_ERDAT_ORDER%2cSO_ERDAT_ITEM%2cSO_WERKS%2cSO_VTWEG%2cSO_MATNR%2cSO_MAKTX%2cSO_KDMAT%2cSO_AG_PARTNER%2cSO_AG_PARTNER_NAME%2cSO_WE_PARTNER%2cSO_WE_PARTNER_NAME%2cSO_LAND1%2cSO_LANDX%2cSO_ORT01%2cSO_VKORG%2cSO_VKORG_NAME1%2cSO_KNREF_HEAD%2cSO_VBUND%2cSO_EDATU_REQUESTED%2cSO_KWMENG%2cSO_VRKME%2cSO_EDATU_CONFIRMED%2cSO_KBMENG%2cSO_F_LDDAT%2cSO_UNCONFIRMED_QTY%2cSO_REQ_TEXT%2cSO_FAKSP%2cSO_FAKSP_VTEXT%2cSO_LGORT%2cSO_SUPPLY_SITUATION%2cSO_SUPPLY_SITUATION_DESCR%2cSO_KBETR%2cSO_WAERS%2cSO_NETWR%2cSO_WAERK%2cSO_HTEXT%2cSO_PSTYV%2cSO_PSTYV_VTEXT%2cSO_DISPO%2cSO_KOSCH%2cSO_VKBUR%2cSO_VKBUR_BEZEI%2cSO_CO_PARTNER%2cSO_CO_PARTNER_NAME%2cSO_NY_PARTNER%2cSO_NY_PARTNER_NAME%2cSO_AS_PARTNER%2cSO_AS_PARTNER_NAME%2cSO_VE_PARTNER%2cSO_VE_PARTNER_NAME%2cSO_AM_PARTNER%2cSO_AM_PARTNER_NAME%2cDL_WADAT_IST%2cSO_F_ZZ0S2MATUG%2cSO_F_AS_PARTNER%2cSO_F_AS_PARTNER_NAME%2cTM_DATEN%2cTM_DATBG%2cDL_ZZ0S2BLNR%2cSO_F_DGLTP%2cDL_CHARG%2cBL_VBELN_INV_LAST%2cBL_VBELN_INV_FIRST%2cTM_AR_DATE%2cDL_TRAID%2cSO_ZZ0S2REVG2%2cDL_VBELN%2cDL_LFIMG%2cDL_VRKME%2cDL_LFART%2cDL_LFART_VTEXT%2cTM_DPTEN%2cTM_DPTBG%2cSO_F_VBELN%2cSO_I_VBELN%2cTM_TDLNR%2cTM_TDLNR_NAME1%2cSO_GUSCON_LEVEL%2cSO_INCO1%2cSO_INCO2%2cSO_F_PSMNG%2cSO_F_AMEIN%2cSO_BASF_LOFCR%2cLAST_NOTE%2cSO_LEVEL_TYPE%2cSO_N_VBELN%2cBL_XBLNR%2cSO_ISCOMPLETED%2cTM_STTRG%2cTM_STTRG_DDTEXT%2cSO_ZTERM%2cDL_PEND_DEL_QUAN%2cDL_LFDAT%2cDL_WADAT%2cSO_F_WERKS%2cSO_BSARK%2cSO_BSARK_VTEXT%2cSO_F_VKORG%2cSO_F_VKORG_VTEXT%2cSO_PRSDT%2cSO_F_AUFNR%2cSO_BSTKD%2cSO_ROUTE%2cSO_VKGRP%2cSO_VKGRP_BEZEI%2cSO_ZZDKPPRODB%2cTM_TKNUM%2cTM_SHIPMENT_ALERT%2cTM_SHIPMENT_CURRENT_STATUS%2cSO_F_VSBED%2cSO_F_VSBED_VTEXT%2cTM_VSART%2cTM_VSART_BEZEI%2cSO_TRAGR%2cSO_TRAGR_VTEXT%2cSO_F_TDDAT%2cTM_EXTI1%2cDL_HSDAT%2cDL_VFDAT%2cSO_VBTYP%2cTM_TRACKING_ID_ELEM%2cTM_TRACKING_ID_COMP`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${firstDayQuarter}%20and%20SO_EDATU_REQUESTED%20le%20${lastDayQuarter})&$select=DL_MANDT%2cSO_MANDT%2cSO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,DL_CHARG,DL_VBELN,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${firstDayQuarter}%20and%20SO_EDATU_REQUESTED%20le%20${lastDayQuarter})&$select=TM_MANDT%2cDL_MANDT%2cDL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG`)
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
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${firstDayQuarter}%20and%20SO_EDATU_REQUESTED%20le%20${lastDayQuarter})&$select=TM_MANDT%2cDL_MANDT%2cBL_MANDT_INV_FIRST%2cBL_MANDT_INV_LAST%2cDL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,BL_VBELN_INV_FIRST,BL_VBELN_INV_LAST,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG,BL_XBLNR`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` order + final order for  ==>  ${currentQuarter} Quarter`, async function () {
    const timeout = 6000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${firstDayQuarter}%20and%20SO_EDATU_REQUESTED%20le%20${lastDayQuarter})&$select=SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_F_LDDAT,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_FAKSP,SO_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_F_VBELN,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,SO_F_WERKS,SO_F_VKORG,SO_F_TDDAT,SO_F_ZZ0S2MATUG,SO_F_VSBED,SO_F_AUFNR,SO_F_DGLTP,SO_F_PSMNG,SO_F_AS_PARTNER`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` Standard Variant for Result set for ==> ${currentYear} `, async function () {

    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await GET(`${baseUrl}/Results?$skip=0&$top=981&$filter=(%20SO_EDATU_REQUESTED%20ge%20${YearFirstDay}%20and%20SO_EDATU_REQUESTED%20le%20${YearLastDay})&$select=SO_MANDT%2cSO_VBELN%2cSO_POSNR%2cSO_AUART%2cSO_ERDAT_ORDER%2cSO_ERDAT_ITEM%2cSO_WERKS%2cSO_VTWEG%2cSO_MATNR%2cSO_MAKTX%2cSO_KDMAT%2cSO_AG_PARTNER%2cSO_AG_PARTNER_NAME%2cSO_LAND1%2cSO_LANDX%2cSO_ORT01%2cSO_VKORG%2cSO_VKORG_NAME1%2cSO_KNREF_HEAD%2cSO_VBUND%2cSO_EDATU_REQUESTED%2cSO_KWMENG%2cSO_VRKME%2cSO_EDATU_CONFIRMED%2cSO_KBMENG%2cSO_F_LDDAT%2cSO_UNCONFIRMED_QTY%2cSO_REQ_TEXT%2cSO_FAKSP%2cSO_FAKSP_VTEXT%2cSO_LGORT%2cSO_SUPPLY_SITUATION%2cSO_SUPPLY_SITUATION_DESCR%2cSO_KBETR%2cSO_WAERS%2cSO_NETWR%2cSO_WAERK%2cSO_HTEXT%2cSO_PSTYV%2cSO_PSTYV_VTEXT%2cSO_DISPO%2cSO_KOSCH%2cSO_VKBUR%2cSO_VKBUR_BEZEI%2cSO_CO_PARTNER%2cSO_CO_PARTNER_NAME%2cSO_NY_PARTNER%2cSO_NY_PARTNER_NAME%2cSO_AS_PARTNER%2cSO_AS_PARTNER_NAME%2cSO_VE_PARTNER%2cSO_VE_PARTNER_NAME%2cSO_AM_PARTNER%2cSO_AM_PARTNER_NAME%2cSO_VBTYP`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` All Fields from the app for ==> ${currentYear}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${YearFirstDay}%20and%20SO_EDATU_REQUESTED%20le%20${YearLastDay})&$select=TM_MANDT%2cDL_MANDT%2cSO_MANDT%2cSO_VBELN%2cSO_POSNR%2cSO_AUART%2cSO_ERDAT_ORDER%2cSO_ERDAT_ITEM%2cSO_WERKS%2cSO_VTWEG%2cSO_MATNR%2cSO_MAKTX%2cSO_KDMAT%2cSO_AG_PARTNER%2cSO_AG_PARTNER_NAME%2cSO_WE_PARTNER%2cSO_WE_PARTNER_NAME%2cSO_LAND1%2cSO_LANDX%2cSO_ORT01%2cSO_VKORG%2cSO_VKORG_NAME1%2cSO_KNREF_HEAD%2cSO_VBUND%2cSO_EDATU_REQUESTED%2cSO_KWMENG%2cSO_VRKME%2cSO_EDATU_CONFIRMED%2cSO_KBMENG%2cSO_F_LDDAT%2cSO_UNCONFIRMED_QTY%2cSO_REQ_TEXT%2cSO_FAKSP%2cSO_FAKSP_VTEXT%2cSO_LGORT%2cSO_SUPPLY_SITUATION%2cSO_SUPPLY_SITUATION_DESCR%2cSO_KBETR%2cSO_WAERS%2cSO_NETWR%2cSO_WAERK%2cSO_HTEXT%2cSO_PSTYV%2cSO_PSTYV_VTEXT%2cSO_DISPO%2cSO_KOSCH%2cSO_VKBUR%2cSO_VKBUR_BEZEI%2cSO_CO_PARTNER%2cSO_CO_PARTNER_NAME%2cSO_NY_PARTNER%2cSO_NY_PARTNER_NAME%2cSO_AS_PARTNER%2cSO_AS_PARTNER_NAME%2cSO_VE_PARTNER%2cSO_VE_PARTNER_NAME%2cSO_AM_PARTNER%2cSO_AM_PARTNER_NAME%2cDL_WADAT_IST%2cSO_F_ZZ0S2MATUG%2cSO_F_AS_PARTNER%2cSO_F_AS_PARTNER_NAME%2cTM_DATEN%2cTM_DATBG%2cDL_ZZ0S2BLNR%2cSO_F_DGLTP%2cDL_CHARG%2cBL_VBELN_INV_LAST%2cBL_VBELN_INV_FIRST%2cTM_AR_DATE%2cDL_TRAID%2cSO_ZZ0S2REVG2%2cDL_VBELN%2cDL_LFIMG%2cDL_VRKME%2cDL_LFART%2cDL_LFART_VTEXT%2cTM_DPTEN%2cTM_DPTBG%2cSO_F_VBELN%2cSO_I_VBELN%2cTM_TDLNR%2cTM_TDLNR_NAME1%2cSO_GUSCON_LEVEL%2cSO_INCO1%2cSO_INCO2%2cSO_F_PSMNG%2cSO_F_AMEIN%2cSO_BASF_LOFCR%2cLAST_NOTE%2cSO_LEVEL_TYPE%2cSO_N_VBELN%2cBL_XBLNR%2cSO_ISCOMPLETED%2cTM_STTRG%2cTM_STTRG_DDTEXT%2cSO_ZTERM%2cDL_PEND_DEL_QUAN%2cDL_LFDAT%2cDL_WADAT%2cSO_F_WERKS%2cSO_BSARK%2cSO_BSARK_VTEXT%2cSO_F_VKORG%2cSO_F_VKORG_VTEXT%2cSO_PRSDT%2cSO_F_AUFNR%2cSO_BSTKD%2cSO_ROUTE%2cSO_VKGRP%2cSO_VKGRP_BEZEI%2cSO_ZZDKPPRODB%2cTM_TKNUM%2cTM_SHIPMENT_ALERT%2cTM_SHIPMENT_CURRENT_STATUS%2cSO_F_VSBED%2cSO_F_VSBED_VTEXT%2cTM_VSART%2cTM_VSART_BEZEI%2cSO_TRAGR%2cSO_TRAGR_VTEXT%2cSO_F_TDDAT%2cTM_EXTI1%2cDL_HSDAT%2cDL_VFDAT%2cSO_VBTYP%2cTM_TRACKING_ID_ELEM%2cTM_TRACKING_ID_COMP`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });
  it(` sales order + delivery for ==> ${currentYear}  `, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${YearFirstDay}%20and%20SO_EDATU_REQUESTED%20le%20${YearLastDay})&$select=DL_MANDT%2cSO_MANDT%2cSO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,DL_CHARG,DL_VBELN,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` Delivery + shipment fields for ==> ${currentYear}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${YearFirstDay}%20and%20SO_EDATU_REQUESTED%20le%20${YearLastDay})&$select=TM_MANDT%2cDL_MANDT%2cDL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` delivery + shipment + billing first and final for ==> ${currentYear}`, async function () {
    const timeout = 5000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${YearFirstDay}%20and%20SO_EDATU_REQUESTED%20le%20${YearLastDay})&$select=TM_MANDT%2cDL_MANDT%2cBL_MANDT_INV_FIRST%2cBL_MANDT_INV_LAST%2cDL_CHARG,DL_VBELN,TM_TKNUM,TM_SHIPMENT_CURRENT_STATUS,TM_SHIPMENT_ALERT,BL_VBELN_INV_FIRST,BL_VBELN_INV_LAST,DL_LFIMG,DL_LFART,DL_LFDAT,DL_TRAID,DL_ZZ0S2BLNR,DL_PEND_DEL_QUAN,DL_WADAT,DL_WADAT_IST,TM_VSART,TM_EXTI1,TM_TDLNR,TM_DPTBG,TM_DATBG,TM_DPTEN,TM_DATEN,TM_AR_DATE,TM_STTRG,BL_XBLNR`)
      assert.equal(200, response.status)
    } catch (error) {
      assert.strictEqual(error.code, 'ECONNABORTED');
      assert.strictEqual(error.message, `timeout of ${timeout}ms exceeded`);
    }
  });

  it(` order + final order for ==> ${currentYear}`, async function () {
    const timeout = 6000
    this.timeout(timeout);
    try {
      const response = await axios.get(`${baseUrl}/Results?$skip=0&$top=981&$filter=(SO_EDATU_REQUESTED%20ge%20${YearFirstDay}%20and%20SO_EDATU_REQUESTED%20le%20${YearLastDay})&$select=SO_MANDT,SO_VBELN,SO_POSNR,SO_AUART,SO_ERDAT_ORDER,SO_ERDAT_ITEM,SO_WERKS,SO_VTWEG,SO_MATNR,SO_KDMAT,SO_AG_PARTNER,SO_WE_PARTNER,SO_LAND1,SO_ORT01,SO_VKORG,SO_KNREF_HEAD,SO_VBUND,SO_EDATU_REQUESTED,SO_KWMENG,SO_EDATU_CONFIRMED,SO_KBMENG,SO_F_LDDAT,SO_UNCONFIRMED_QTY,SO_REQ_TEXT,SO_FAKSP,SO_LGORT,SO_SUPPLY_SITUATION,SO_KBETR,SO_NETWR,SO_HTEXT,SO_PSTYV,SO_DISPO,SO_KOSCH,SO_VKBUR,SO_CO_PARTNER,SO_NY_PARTNER,SO_AS_PARTNER,SO_VE_PARTNER,SO_AM_PARTNER,SO_ZZ0S2REVG2,SO_I_VBELN,SO_N_VBELN,SO_INCO1,SO_INCO2,SO_ZTERM,SO_PRSDT,SO_ZZDKPPRODB,SO_BSARK,SO_BASF_LOFCR,SO_GUSCON_LEVEL,SO_ISCOMPLETED,SO_LEVEL_TYPE,SO_F_VBELN,SO_BSTKD,SO_TRAGR,SO_VKGRP,SO_ROUTE,SO_F_WERKS,SO_F_VKORG,SO_F_TDDAT,SO_F_ZZ0S2MATUG,SO_F_VSBED,SO_F_AUFNR,SO_F_DGLTP,SO_F_PSMNG,SO_F_AS_PARTNER`)
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