contactModule.factory('contactManager', ['$http', '$q', 'Contact','erpSettings', function($http, $q, Contact, erpSettings) {
    var contactManager = {
        _pool: {},
        _retrieveInstance: function(id, data) {
            var instance = this._pool[id];

            if (instance) {
                instance.setData(data);
            } else {
                instance = new Contact(data);
                this._pool[id] = instance;
            }

            return instance;
        },
        _search: function(id) {
            return this._pool[id];
        },
        _load: function(id, deferred) {
            var scope = this;

            $http.get(erpSettings.apiHost+'/contacts/' + id)
                .success(function(contactData) {
                    var contact = scope._retrieveInstance(contactData.id, contactData);
                    deferred.resolve(contact);
                })
                .error(function(data,status) {
                    deferred.reject(data,status);
                });
        },
        /* Public Methods */
        /* Use this function in order to get a contact instance by it's id */
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
        /* Use this function in order to get instances of all the contacts */
        loadAllContact: function() {
            var deferred = $q.defer();
            var scope = this;
            $http.get(erpSettings.apiHost+'/contacts')
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