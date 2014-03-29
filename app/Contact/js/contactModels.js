contactModule.factory('Contact', ['$http','erpSettings', function($http,erpSettings) {
    function Contact(contact) {
        if (contact) {
            this.setData(contact);
        }
    };
    Contact.prototype = {
        setData: function(contact) {
            angular.extend(this, contact);
        },
        load: function(id) {
            var scope = this;
            $http.get(erpSettings.apiHost+'/contacts/' + id).success(function(contact) {
                scope.setData(contact);
            });
        },
        create: function() {
            $http.post(erpSettings.apiHost+'/contacts/', this);
        },
        delete: function(id) {
            $http.delete(erpSettings.apiHost+'/contacts/' + id);
        },
        update: function(id) {
            $http.put(erpSettings.apiHost+'/contacts/' + id, this);
        }
    };
    return Contact;
}]).
factory('ContactData', ['$http','erpSettings', function($http,erpSettings) {
    function ContactData(contactData) {
        this.postUrl = erpSettings.apiHost+'/contactdata/';
        if (contactData) {
            this.setData(contactData);
        }
    };
    ContactData.prototype = {
        setData: function(contactData) {
            angular.extend(this, contactData);
        },
        load: function(id) {
            var scope = this;
            $http.get(this.postUrl + id).success(function(contactData) {
                if(!contactData.url){
                    contactData.url = this.postUrl + id;
                }
                scope.setData(contactData);
            });
        },
        fromUrl: function(success,fail) {
            $http.get(this.url).success(success).error(fail);
        },
        create: function(success,fail) {
            $http.post(this.postUrl, this).success(success).error(fail);
        },
        delete: function(success,fail) {
            $http.delete(this.url).success(success).error(fail);
        },
        update: function(success,fail) {
            $http.put(this.url, this).success(success).error(fail);
        }
    };
    return ContactData;
}]).
factory('ContactLink', ['$http','erpSettings', function($http,erpSettings) {
    function ContactLink(contactLink) {
        if (contactLink) {
            this.setData(contactLink);
        }
    };
    ContactLink.prototype = {
        setData: function(contactLink) {
            angular.extend(this, contactLink);
        },
        load: function(id) {
            var scope = this;
            $http.get(erpSettings.apiHost+'/contactlink/' + id).success(function(contactLink) {
                scope.setData(contactLink);
            });
        },
        create: function() {
            $http.post(erpSettings.apiHost+'/contactlink/', this);
        },
        delete: function(id) {
            $http.delete(erpSettings.apiHost+'/contactlink/' + id);
        },
        update: function(id) {
            $http.put(erpSettings.apiHost+'/contactlink/' + id, this);
        }
    };
    return ContactLink;
}]).
factory('ContactTag', ['$http','erpSettings', function($http,erpSettings) {
    function ContactTag(contactTag) {
        if (contactTag) {
            this.setData(contactTag);
        }
    };
    ContactTag.prototype = {
        setData: function(contactTag) {
            angular.extend(this, contactTag);
        },
        load: function(id) {
            var scope = this;
            $http.get(erpSettings.apiHost+'/contacttag/' + id).success(function(contactTag) {
                scope.setData(contactTag);
            });
        },
        create: function() {
            $http.post(erpSettings.apiHost+'/contacttag/', this);
        },
        delete: function(id) {
            $http.delete(erpSettings.apiHost+'/contacttag/' + id);
        },
        update: function(id) {
            $http.put(erpSettings.apiHost+'/contacttag/' + id, this);
        }
    };
    return ContactTag;
}]).
factory('ContactComment', ['$http','erpSettings', function($http,erpSettings) {
    function ContactComment(contactComment) {
        if (contactComment) {
            this.setData(contactComment);
        }
    };
    ContactComment.prototype = {
        setData: function(contactComment) {
            angular.extend(this, contactComment);
        },
        load: function(id) {
            var scope = this;
            $http.get(erpSettings.apiHost+'/contactcomment/' + id).success(function(contactComment) {
                scope.setData(contactComment);
            });
        },
        create: function() {
            $http.post(erpSettings.apiHost+'/contactcomment/', this);
        },
        delete: function(id) {
            $http.delete(erpSettings.apiHost+'/contactcomment/' + id);
        },
        update: function(id) {
            $http.put(erpSettings.apiHost+'/contactcomment/' + id, this);
        }
    };
    return ContactComment;
}]).
factory('ContactAttachment', ['$http','erpSettings', function($http,erpSettings) {
    function ContactAttachment(contactAttachment) {
        if (contactAttachment) {
            this.setData(contactAttachment);
        }
    };
    ContactAttachment.prototype = {
        setData: function(contactAttachment) {
            angular.extend(this, contactAttachment);
        },
        load: function(id) {
            var scope = this;
            $http.get(erpSettings.apiHost+'/contactattachment/' + id).success(function(contactAttachment) {
                scope.setData(contactAttachment);
            });
        },
        create: function() {
            $http.post(erpSettings.apiHost+'/contactattachment/', this);
        },
        delete: function(id) {
            $http.delete(erpSettings.apiHost+'/contactattachment/' + id);
        },
        update: function(id) {
            $http.put(erpSettings.apiHost+'/contactattachment/' + id, this);
        }
    };
    return ContactAttachment;
}]).
factory('ModelBase', ['$http', function($http) {
    function ModelBase(modelBase,postUrl) {
        this.postUrl = postUrl;
        if (modelBase) {
            this.setData(modelBase);
        }
    };
    ModelBase.prototype = {
        setData: function(modelBase) {
            angular.extend(this, modelBase);
        },
        fromId: function(id,success,fail) {
            if(!this.postUrl) {
                throw new Error("PostUrl not defined!");
            }
            $http.get(this.postUrl + id).success(function(modelBase) {
                if(!modelBase.url){
                    modelBase.url = this.postUrl + id;
                }
                this.setData(modelBase);
                success(modelBase);
            }).error(fail);
        },
        fromUrl: function(success,fail) {
            $http.get(this.url).success(success).error(fail);
        },
        create: function(success,fail) {
            $http.post(this.postUrl, this).success(success).error(fail);
        },
        delete: function(success,fail) {
            $http.delete(this.url).success(success).error(fail);
        },
        update: function(success,fail) {
            $http.put(this.url, this).success(success).error(fail);
        }
    };
    return ModelBase;
}]);