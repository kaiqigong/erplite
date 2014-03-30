contactModule.factory('ModelBase', ['$http', function($http) {
    function ModelBase(modelBase,postUrl) {
        if (postUrl) {
            this.postUrl = postUrl;
        }
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
}]).
factory('Contact', ['$rootScope','ModelBase', function($rootScope,ModelBase) {
    function Contact(contact) {
        ModelBase.call(this,contact,$rootScope.apimap.contact);
    };
    Contact.prototype = new ModelBase();
    return Contact;
}]).
factory('ContactData', ['$rootScope','ModelBase', function($rootScope,ModelBase) {
    function ContactData(contactData) {
        ModelBase.call(this,contactData,$rootScope.apimap.contactdata);
    };
    ContactData.prototype = new ModelBase();
    return ContactData;
}]).
factory('ContactLink', ['$rootScope','ModelBase', function($rootScope,ModelBase) {
    function ContactLink(contactLink) {
        ModelBase.call(this,contactLink,$rootScope.apimap.contactlink);
    };
    ContactLink.prototype = new ModelBase();
    return ContactLink;
}]).
factory('ContactTag', ['$rootScope','ModelBase', function($rootScope,ModelBase) {
    function ContactTag(contactTag) {
        ModelBase.call(this,contactTag,$rootScope.apimap.contacttag);
    };
    ContactTag.prototype = new ModelBase();
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
}]);