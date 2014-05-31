// Generated by CoffeeScript 1.7.1
var erpServices;

erpServices = angular.module('erpServices', ['ngCookies']);

erpServices.factory('security', [
  '$cookies', '$http', function($cookies, $http) {
    return {
      setHttpHeader: function(header) {
        $http.defaults.headers.common.Authorization = header.tokenType + ' ' + header.token;
        return $cookies.authorization = $http.defaults.headers.common.Authorization;
      },
      getCSRF: function() {
        return $cookies.csrftoken;
      },
      clearAccessToken: function() {
        delete $http.defaults.headers.common["Authorization"];
        return delete $cookies["authorization"];
      },
      restoreToken: function() {
        if ($cookies.authorization != null) {
          return $http.defaults.headers.common.Authorization = $cookies.authorization;
        }
      }
    };
  }
]);
