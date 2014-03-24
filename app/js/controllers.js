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


 erpControllers.controller('ContactCtrl', ['$scope', '$http',

 function ($scope, $http) {
     $scope.title = "联系人";
     $scope.icon = "./img/128px/layers_128px.png";
     $scope.backUrl = "#/home";
     $scope.currentPage = 1;
     $http.get('../mockData/contacts.json').success(function (data, status) {
         $scope.items = data;
     }).
     error(function (data, status) {
         if (status == "404") {
             $scope.error = "404 not found";
         } else {
             $scope.error = "Error Code: " + status + ", Message: " + data;
         }
     });
 }]);

 erpControllers.controller('ContactDetailCtrl', ['$scope', '$http', '$routeParams',

 function ($scope, $http, $routeParams) {
     $scope.backUrl = "#/contact";
     $scope.contact = null;
     $scope.showToolbar = true;
     $scope.showRefresh = true;
     $scope.newLink = {
         type: "Supplier",
         name: ""
     };
     $scope.changeType = function (type) {
         $scope.newLink.type = type;
     };
     $scope.add = function () {
         $scope.newLink.lastModifiedTime = new Date();
         console.log($scope.newLink.lastModifiedTime);
         $scope.contact.links.push($scope.newLink);
         // $http.post('/someUrl',$scope.newLink).success()
         $scope.newLink = {
             type: "Supplier",
             name: ""
         };
     };
     $http.get('../mockData/contact' + $routeParams.id + '.json').success(function (data, status) {
         $scope.contact = data;
         $scope.title = data.name;
     }).
     error(function (data, status) {
         if (status == "404") {
             $scope.error = "404 not found";
         } else {
             $scope.error = "Error Code: " + status + ", Message: " + data;
         }
     });

     $scope.refreshLinks = function () {
         $http.get('../mockData/links.json').success(function (data, status) {
             $scope.contact.links = data;
             setTimeout(function () {
                 $("#progressbar").progressbar("start");
             }, 100);
             setTimeout(function () {
                 $("#progressbar").progressbar("almost");
             }, 500);
             setTimeout(function () {
                 $("#progressbar").progressbar("finish");
             }, 1000);
         });
     };

     $scope.save = function () {
         console.log($scope.contact);
     };
 }]);

 erpControllers.controller('NewContactCtrl', ['$scope', '$http',

 function ($scope, $http) {
     $scope.backUrl = "#/contact";
     $scope.contact = {
         info: {},
         avator: "./img/default_avatar.png",
         links: [],
         comments: []
     };
     $scope.title = "新建联系人";
     $scope.showToolbar = false;
     $scope.showRefresh = false;
     $scope.newLink = {
         type: "Supplier",
         name: ""
     };

     $scope.changeType = function (type) {
         $scope.newLink.type = type;
     };

     $scope.add = function () {
         $scope.newLink.lastModifiedTime = new Date();
         console.log($scope.newLink.lastModifiedTime);
         $scope.contact.links.push($scope.newLink);
         // $http.post('/someUrl',$scope.newLink).success()
         $scope.newLink = {
             type: "Supplier",
             name: ""
         };
     };

     $scope.refreshLinks = function () {
         $http.get('../mockData/links.json').success(function (data, status) {
             $scope.contact.links = data;
             setTimeout(function () {
                 $("#progressbar").progressbar("start");
             }, 100);
             setTimeout(function () {
                 $("#progressbar").progressbar("almost");
             }, 500);
             setTimeout(function () {
                 $("#progressbar").progressbar("finish");
             }, 1000);
         });
     };

     $scope.save = function () {
         console.log($scope.contact);
     };

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