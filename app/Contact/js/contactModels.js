contactModule.factory('Contact', ['$http','erpSettings', function($http,erpSettings) {
    function Contact(contactData) {
        if (contactData) {
            this.setData(contactData);
        }
    };
    Contact.prototype = {
        setData: function(contactData) {
            angular.extend(this, contactData);
        },
        load: function(id) {
            var scope = this;
            $http.get(erpSettings.apiHost+'/contacts/' + id).success(function(contactData) {
                scope.setData(contactData);
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
}]);