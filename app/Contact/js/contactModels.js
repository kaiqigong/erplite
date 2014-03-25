contactModule.factory('Contact', ['$http','apiHost', function($http,apiHost) {
    function Contact(contactData) {
        if (contactData) {
            this.setData(contactData):
        }
    };
    Contact.prototype = {
        setData: function(contactData) {
            angular.extend(this, contactData);
        },
        load: function(id) {
            var scope = this;
            $http.get('../mockData/contact' + id + '.json').success(function(contactData) {
                scope.setData(contactData);
            });
        },
        create: function(id) {
            $http.post(apiHost+'/contacts/', this);
        },
        delete: function(id) {
            $http.delete(apiHost+'/contacts/' + id);
        },
        update: function(id) {
            $http.put(apiHost+'/contacts/' + id, this);
        }
    };
    return Contact;
}]);