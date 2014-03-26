contactModule.controller('ContactListCtrl', ['$scope', '$http','contactManager',

 function ($scope, $http,contactManager) {
     $scope.title = "联系人";
     $scope.icon = "./img/128px/layers_128px.png";
     $scope.backUrl = "#/home";
     $scope.currentPage = 1;
     var promise = contactManager.loadAllContact();
     promise.then(function(contacts){
          $scope.items = contacts;
          console.log(contacts);
     },function(data,status){
          if (status == "404") {
             $rootScope.$broadcast('errorHappened', status, $location.url());
         } else if (status == "401") {
             $location.url("/login");
         } else {
             console.log("Error Code: " + status + ", Message: " + data);
         }
     },null);
 }]).
controller('ContactDetailCtrl', ['$scope', '$http', '$routeParams','contactManager',

 function ($scope, $http, $routeParams,contactManager) {
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
     $scope.addLink = function () {
         $scope.newLink.lastModifiedTime = new Date();
         console.log($scope.newLink.lastModifiedTime);
         $scope.contact.links.push($scope.newLink);
         // $http.post('/someUrl',$scope.newLink).success()
         $scope.newLink = {
             type: "Supplier",
             name: ""
         };
     };
     var promise = contactManager.getContact($routeParams.id);
     promise.then(function(contactData){
          $scope.contact = contactData;
          $scope.title = contactData.name;
          console.log(contactData);
     },function(error,status){
          if (status == "404") {
             $rootScope.$broadcast('errorHappened', status, $location.url());
         } else if (status == "401") {
             $location.url("/login");
         } else {
             console.log("Error Code: " + status + ", Message: " + error);
         }
     },null);
     
     $scope.refreshLinks = function () {
         $http.get('../mockData/links.json').success(function (data, status) {
             $scope.contact.links = data;
         });
     };

     $scope.save = function () {
         // $scope.contact.update($routeParams.id);
         console.log($scope.contact);
     };
 }]).controller('NewContactCtrl', ['$scope', '$http',

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

     $scope.addLink = function () {
         $scope.newLink.lastModifiedTime = new Date();
         console.log($scope.newLink.lastModifiedTime);
         $scope.contact.links.push($scope.newLink);
         // $http.post('/someUrl',$scope.newLink).success()
         $scope.newLink = {
             type: "Supplier",
             name: ""
         };
     };

     $scope.save = function () {
         // $scope.contact.create();
         console.log($scope.contact);        
     };

 }]);