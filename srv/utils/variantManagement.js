const cds = require('@sap/cds');

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

const _getUserVariants = async (req, res) => {
    const { Variants, VariantsUserSettings } = await cds.entities("srvOpenOrders");
    const appInput = req.params.app;
    const userId = req.user.id;
    const favorite = true;

    // Get content for user variants and favorite public ones only 
    const variantsWithContentQuery = SELECT.from(`${Variants.name} as Variants`)
        .leftJoin(`${VariantsUserSettings.name} as VariantSettings`)
        .on`Variants.fileName = VariantSettings.fileName
            and VariantSettings.userId = ${userId}`
        .where`Variants.reference = ${appInput}
            and (Variants.supportUser = ${userId} 
                or (Variants.layer = 'CUSTOMER' and VariantSettings.favorite = ${favorite}))`;
    
    // Get data for the rest only (content loaded on demand)
    const variantsWithoutContentQuery = SELECT.from(`${Variants.name} as Variants`)
        .leftJoin(`${VariantsUserSettings.name} as VariantSettings`)
        .on`Variants.fileName = VariantSettings.fileName
            and VariantSettings.userId = ${userId}`
        .columns([
            "Variants.fileName",
            "Variants.fileType",
            "Variants.changeType",
            "Variants.conditions",
            "Variants.contexts",
            "Variants.creation",
            "Variants.layer",
            "Variants.namespace",
            "Variants.originalLanguage",
            "Variants.packageName",
            "Variants.reference",
            "Variants.selector",
            "Variants.texts",
            "Variants.supportGenerator",
            "Variants.supportService",
            "Variants.supportUser",
            "Variants.variantId",
            "Variants.projectId",
            "VariantSettings.standardVariant",
            "VariantSettings.favorite",
            "VariantSettings.executeOnSelection"
        ])
        .where`Variants.reference = ${appInput} and Variants.layer = 'CUSTOMER'
            and (VariantSettings.favorite = false or VariantSettings.favorite = null)`;
    
    // Connect to DB
    const db = await cds.connect.to('db')
    // Run both promises in parallel to make it a little bit faster
    const [userVariants, publicVariantsNotFavorite] = await Promise.all([
        db.run(variantsWithContentQuery),
        db.run(variantsWithoutContentQuery)
    ]);
    // Concatenate both arrays
    const allVariants = userVariants.concat(publicVariantsNotFavorite);

    // Map properties to response
    const changes = allVariants.map(variant => ({
        fileName: variant.fileName,
        fileType: variant.fileType,
        changeType: variant.changeType,
        conditions: JSON.parse(variant.conditions),
        content:  variant.content ? JSON.parse(variant.content) : {},
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
        executeOnSelection: variant.executeOnSelection ?? false
    }));

    return {
        changes,
        settings: {
            isKeyUser: true,
            isAtoAvailable: true,
            isAtoEnabled: false,
            isProductiveSystem: true,
            isVariantSharingEnabled: true,
            isZeroDowntimeUpgradeRunning: false
        }
    }
}

const getUserVariants = async (req, res) => {
    const appInput = req.params.app;
    const userId = req.user.id;
    const { variantErrors } = await cds.entities("srvOpenOrders");
    try {
        // Timeout that rejects after 18 seconds
        const timeoutPromise = new Promise((_, reject) =>
            setTimeout(() => reject(new Error("Request timeout - took more than 18 seconds")), 18000)
        );
        
        // Race function and timeout, since we can't intercept the xhr timeout, we will use a fixed timeout of 18 seconds
        // If timeout is reached, it will return an error we can handle
        const data = await Promise.race([
            _getUserVariants(req, res),
            timeoutPromise
        ]);
        
        // Delete user errors
        await DELETE.from(variantErrors).where({ userId: userId, application: appInput });

        res.status(200).json(data);
    } catch (error) {
        // Add error to notify UI
        await UPSERT.into(variantErrors).entries([{
            userId : userId,
            application: appInput,
            errorTime: new Date()
        }])        
        res.status(408).json({ 
            errors: error.message || "Request timeout or error occurred" 
        });
    }
};

const deleteVariant = async (req, res) => {
    const { Variants, VariantsUserSettings } = await cds.entities("srvOpenOrders");
    // var body = req.body;
    var fileNameInput = req.params.fileName;
    try {
        // Delete variant and user settings
        await DELETE.from(Variants).where`fileName = ${fileNameInput}`;
        await DELETE.from(VariantsUserSettings).where`fileName = ${fileNameInput}`;
        res.type('application/json').status(200).send({});
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