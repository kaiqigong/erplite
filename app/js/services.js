var erpServices = angular.module('erpServices', ['ngCookies']);
erpServices.factory('security', function ($cookies) {

    return {
        saveCookie: function () {
            $cookies.test = "test";
            return true;
        },
        getCookie: function () {
            return {
                token: $cookies.test
            };
        }
    };
});