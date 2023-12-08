module.exports = class Helper {

    constructor(){
        this.authObject = [];
    }

    setAuthObject(auth) {
        this.authObject = auth;
    }

    getAuthObject(sServiceType) {
        return this.authObject;
    }

};