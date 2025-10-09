const cds = require('@sap/cds')

const isEmpty = (obj) => {
    for (var prop in obj) {
        if (Object.prototype.hasOwnProperty.call(obj, prop)) {
            return false;
        }
    }

    return true
}

const upsertVariant = async (req, res, body) => {
    const { Variants, VariantsUserSettings } = await cds.entities("srvOpenOrders");
    // var body = req.body[0];
    var userId = req.user.id;
    var generator = '';
    var service = '';
    var variantName = '';

    if (typeof body.support !== 'undefined') {
        generator = body.support.generator;
        service = body.support.service;
    }
    if (typeof body.texts !== 'undefined') {
        if (typeof body.texts.variantName !== 'undefined') {
            variantName = body.texts.variantName.value;
        }
    }
    let variantData = [{
        fileName: body.fileName,
        fileType: body.fileType,
        changeType: body.changeType,
        reference: body.reference,
        packageName: body.packageName,
        content: JSON.stringify(body.content),
        namespace: body.namespace,
        originalLanguage: body.originalLanguage,
        conditions: JSON.stringify(body.conditions),
        contexts: JSON.stringify(body.contexts),
        supportGenerator: generator,
        supportService: service,
        supportUser: userId,
        layer: body.layer,
        selector: JSON.stringify(body.selector),
        texts: JSON.stringify(body.texts),
        variantName: variantName,
        variantId: body.variantId,
        projectId: body.projectId,
        changedBy: userId,
        changedOn: new Date()
    }];
    // add variant user settings for user
    let variantUserSettings = [{
        fileName: body.fileName,
        userId: userId,
        favorite: body.favorite,
        standardVariant: body.standardVariant,
        executeOnSelection: body.executeOnSelection
    }]
    try {
        if (body.fileName.indexOf("_updateVariant") < 0) {
            await UPSERT.into(Variants).entries(variantData);
            if(body.fileName.indexOf("_defaultVariant") < 0){
                await UPSERT.into(VariantsUserSettings).entries(variantUserSettings);
            } 
        } else {
            var updateObject = {};
            if (body.content.favorite !== undefined) {
                updateObject.favorite = body.content.favorite;
            }else{
                updateObject.favorite = false;
            }
            if (body.content.executeOnSelection !== undefined) {
                updateObject.executeOnSelection = body.content.executeOnSelection;
            }else{
                updateObject.executeOnSelection = false;
            }
            if (!isEmpty(updateObject)) {
                let variantExists = await SELECT.from(VariantsUserSettings, {fileName:body.selector.variantId, userId:userId});
                if(variantExists){
                    await UPDATE(VariantsUserSettings, {fileName:body.selector.variantId, userId:userId}).with(updateObject)
                }else{
                    updateObject.fileName = body.selector.variantId;
                    updateObject.userId = userId;
                    updateObject.standardVariant = false;
                    await INSERT.into(VariantsUserSettings).entries(updateObject);
                }
            }
        }
        res.type('application/json').status(200).send(body);
    } catch (err) {
        res.type('text/plain').status(500).send(`ERROR: ${err.toString()}`);
        return;
    }

}

const getVariantManagementSettings = async (req, res) => {
    var settings = {
        'settings': {
            "isKeyUser": true,
            "isAtoAvailable": true,
            "isAtoEnabled": false,
            "isProductiveSystem": true,
            "isVariantSharingEnabled": true,
            "isZeroDowntimeUpgradeRunning": false
        }
    };
    res.type('application/json').status(200).send(settings);
}

const getUserVariants = async (req, res) => {
    const { Variants, VariantsUserSettings } = await cds.entities("srvOpenOrders");
    const appInput = req.params.app;
    const userId = req.user.id;
    
    // Only one query
    const userVariants = await SELECT.from(`${Variants.name} as Variants`)
        .leftJoin(`${VariantsUserSettings.name} as VariantSettings`)
        .on`Variants.fileName = VariantSettings.fileName
            and VariantSettings.userId = ${userId}`
        .where`Variants.reference = ${appInput}
            and ((Variants.supportUser = ${userId} and Variants.layer = 'USER') 
                or Variants.layer = 'CUSTOMER')`;

    // Map properties to response
    const changes = userVariants.map(variant => ({
        fileName: variant.fileName,
        fileType: variant.fileType,
        changeType: variant.changeType,
        conditions: JSON.parse(variant.conditions),
        content: JSON.parse(variant.content),
        contexts: JSON.parse(variant.contexts),
        creation: variant.creation,
        layer: variant.layer,
        namespace: variant.namespace,
        originalLanguage: variant.originalLanguage,
        packageName: variant.packageName,
        reference: variant.reference,
        selector: JSON.parse(variant.selector),
        texts: JSON.parse(variant.texts),
        support: {
            generator: variant.supportGenerator,
            service: variant.supportService,
            user: variant.supportUser
        },
        variantId: variant.variantId,
        projectId: variant.projectId,
        // JOIN Data (VariantsUserSettings)
        standardVariant: variant.standardVariant ?? false,
        favorite: variant.favorite ?? false,
        executeOnSelection: variant.executeOnSelection ?? false,
        changedBy: userId,
        changedOn: new Date()
    }));

    // Response
    res.status(200).json({
        changes,
        settings: {
            isKeyUser: true,
            isAtoAvailable: true,
            isAtoEnabled: false,
            isProductiveSystem: true,
            isVariantSharingEnabled: true,
            isZeroDowntimeUpgradeRunning: false
        }
    });
};

const deleteVariant = async (req, res) => {
    const { Variants, VariantsUserSettings } = await cds.entities("srvOpenOrders");
    var body = req.body;
    var fileNameInput = req.params.fileName;
    try {
        // Delete variant and user settings
        await DELETE.from(Variants).where`fileName = ${fileNameInput}`;
        await DELETE.from(VariantsUserSettings).where`fileName = ${fileNameInput}`;
        res.type('application/json').status(200).send(body);
    } catch (err) {
        res.type('text/plain').status(500).send(`ERROR: ${err.toString()}`);
        return;
    }
}

module.exports = {
    upsertVariant,
    deleteVariant,
    getUserVariants,
    getVariantManagementSettings
};