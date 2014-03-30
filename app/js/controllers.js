 var erpControllers = angular.module('erpControllers', ['erpServices']);

erpControllers.controller('RootCtrl', ['$scope','$timeout',

 function ($scope,$timeout) {
     $scope.title = "";
     $scope.hasError = false;
     
     $scope.progressBar={
         value:0,
         show:false,
         type:'success',
         blink:function(){
             // TODO: don't work :(
             $timeout(function(){
                 show = true;
                 value = 50;
                 $scope.$apply();
             },500); 
             $timeout(function(){
                 value = 100;
                 $scope.$apply();
             },1000);    
             $timeout(function(){
                 show = false;
                 $scope.$apply();
             },1500);
         }
     };

    $scope.progressBar.blink();

 }]);

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