contactModule.factory('contactManager', ['$http', '$q', 'Contact','ContactData','erpSettings','$log','$rootScope', 
function($http, $q, Contact, ContactData, erpSettings,$log,$rootScope) {
    var contactManager = {
        _pool: {},
        _syncTimeDict:{},
        _contactList:[],
        _retrieveInstance: function(id, data) {
            var instance = this._pool[id];

            if (instance) {
                instance.setData(data);
            } else {
                instance = new Contact(data);
                this._pool[id] = instance;
                this._syncTimeDict[id] = new Date();
            }

            return instance;
        },
        _search: function(id) {
            return this._pool[id];
        },
        _load: function(id, deferred) {
            var scope = this;

            $http.get($rootScope.apimap.contact + id)
                .success(function(data) {
                    var contact = new Contact(data);
                    contact.url = $rootScope.apimap.contact + id;
                    contact.data = [];
                    var contactDataUrls = data.data;
                    contactDataUrls.forEach(function(contactDataUrl){
                        $http.get(contactDataUrl).success(function(contactData){
                            contactData.url = contactDataUrl;
                            contact.data.push(new ContactData(contactData));
                            });
                        });

                    deferred.resolve(contact);
                })
                .error(function(data,status) {
                    deferred.reject(data,status);
                });
        },
        /* Public Methods */
        /* Use this function in order to get a contact instance by it's id */
        
        loadContact : function(id){
            var deferred = $q.defer();
            this._load(id, deferred);
            return deferred.promise;
        },
        loadContactList:function(){
            var deferred = $q.defer();
            $http.get($rootScope.apimap.contact)
                .success(function(data,status) {
                    deferred.resolve(data);
                    _contactList=data;
                    $log.log(_contactList);
                })
                .error(function(data,status) {
                    deferred.reject(data,status);
                });
            return deferred.promise;
        },
        getPreviousContact : function(id){
            if(_contactList){
                for(var i=0;i<_contactList.length;i++){
                    if(_contactList[i].id === id){
                        if(i===0){
                            // should not happen, if happens, just tell the controller that no more previous item. by event?
                            return id;
                        }else {
                            return _contactList[i-1].id;
                        }
                        break;
                    }
                }
            }
            // should not go to here.
            return id;
        },
        getNextContact : function(id){
            if(_contactList){
                for(var i=0;i<_contactList.length;i++){
                    if(_contactList[i].id === id){
                        if(i===_contactList.length-1){
                            return id;
                        }else {
                            return _contactList[i+1].id;
                        }
                        break;
                    }
                }
            }
            // should not go to here.
            return id;
        },
        getContact: function(id) {
            var deferred = $q.defer();
            var contact = this._search(id);
            if (contact) {
                deferred.resolve(contact);
            } else {
                this._load(id, deferred);
            }
            return deferred.promise;
        },
        initContactData:function(contactData){
            return new ContactData(contactData);
        },
        /* Use this function in order to get instances of all the contacts */
        loadAllContact: function() {
            var deferred = $q.defer();
            var scope = this;
            $http.get($rootScope.apimap.contact)
                .success(function(contactsArray) {
                    var contacts = [];
                    contactsArray.forEach(function(contactData) {
                        // todo: remove this code
                        if(contactData.id){
                            
                        }else{
                            contactData.id =contacts.length+1;
                        }
                     
                        var contact = scope._retrieveInstance(contactData.id, contactData);
                        contacts.push(contact);
                    });

                    deferred.resolve(contacts);
                })
                .error(function(data,status) {
                    deferred.reject(data,status);
                });
            return deferred.promise;
        },
        /*  This function is useful when we got somehow the contact data and we wish to store it or update the pool and get a contact instance in return */
        setContact: function(contactData) {
            var scope = this;
            var contact = this._search(contactData.id);
            if (contact) {
                contact.setData(contactData);
            } else {
                contact = scope._retrieveInstance(contactData);
            }
            return contact;
        }

    };
    return contactManager;
}]);