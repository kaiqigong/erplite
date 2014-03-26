 var erpControllers = angular.module('erpControllers', ['erpServices']);

 erpControllers.controller('HomeCtrl', ['$scope', '$http', '$location', '$rootScope',

 function ($scope, $http, $location, $rootScope) {
     $scope.title = "Welcome, Kaiqi";
     $scope.hasError = false;
     $http.get('../mockData/applist.json').success(function (data, status) {
         $scope.apps = data;
     }).
     error(function (data, status) {
         $scope.hasError = true;
         if (status == "404") {
             $scope.error = "404 not found";
             $rootScope.$broadcast('errorHappened', status, $location.url());
         } else if (status == "401") {
             $location.url("/login");
         } else {
             $scope.error = "Error Code: " + status + ", Message: " + data;
         }
     });
 }]);

 erpControllers.controller('LoginCtrl', ['$scope', '$http', 'security',

 function ($scope, $http, security) {
     $scope.rememberMe = false;

     $scope.login = function () {

         var loginParam = {
             username: $scope.username,
             password: $scope.password, // security.encrypt($scope.password)
             rememberMe: $scope.rememberMe
         };
         // $http.post('/someUrl',loginParam).success()
         security.saveCookie();
         // add token to cookie. Need a security service in which can get and set the token.

     };
 }]);

 erpControllers.controller('404Ctrl', ['$scope', '$http',

 function ($scope, $http) {

 }]);