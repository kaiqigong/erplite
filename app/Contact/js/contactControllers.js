contactModule.controller('ContactListCtrl', ['$scope', '$http', 'contactManager','$log',

  function($scope, $http, contactManager,$log) {
    $scope.title = "联系人";
    $scope.icon = "./img/128px/layers_128px.png";
    $scope.backUrl = "#/home";
    $scope.currentPage = 1;
    $scope.contactMatch = function(query) {
      return function(item) {
        if (!query) {
          return true;
        }
        return item.name.indexOf(query) >= 0 || item.description.indexOf(query) >= 0;
      };
    };
    var promise = contactManager.loadContactList();
    promise.then(function(contacts) {
      $scope.items = contacts;
      $log.log(contacts);
    }, function(data, status) {
      if (status == "404") {
        $rootScope.$broadcast('errorHappened', status, $location.url());
      } else if (status == "401") {
        $location.url("/login");
      } else {
        $log.log("Error Code: " + status + ", Message: " + data);
      }
    }, null);
  }
]).
controller('ContactDetailCtrl', ['$scope', '$http', '$routeParams', 'contactManager','$location','$log',

  function($scope, $http, $routeParams, contactManager,$location,$log) {
    $scope.backUrl = "#/contact";
    $scope.contact = null;
    $scope.showToolbar = true;
    $scope.showRefresh = true;
    $scope.newLink = {
      type: "Supplier",
      name: ""
    };
    $scope.changeType = function(type) {
      $scope.newLink.type = type;
    };
    $scope.addLink = function() {
      $scope.newLink.modifiedDate = new Date();
      $log.log($scope.newLink.modifiedDate);
      $scope.contact.links.push(angular.copy($scope.newLink));
      // $http.post('/someUrl',$scope.newLink).success()
      $scope.newLink = {
        type: "Supplier",
        name: ""
      };
    };

    $scope.addData = function() {
        $scope.newData.createdBy = "cage";
        $scope.newData.modifiedBy = "cage";
        $scope.newData.contact = $scope.contact.id;
        var newData = contactManager.initContactData($scope.newData);
        $scope.contact.data.push(newData);
    };
    
    $scope.save = function() {
      $log.log($scope.contact);
      $scope.contact.data.forEach(function(contactData){
          if(!contactData.url){
              if(contactData.valuePair===""||contactData.valuePair===null){
                  // will not create, maybe the user decides not to add this field.
              }else{
                  contactData.create();
              }              
          }
          else if(contactData.valuePair===""||contactData.valuePair===null){
              // delete
              contactData.delete();
          }else {
              contactData.update();
          }
      });
    };
    
    var promise = contactManager.loadContact($routeParams.id);
    promise.then(function(contactData) {
      $scope.contact = contactData;
      $scope.title = contactData.name;
      $log.log(contactData);
    }, function(error, status) {
      if (status == "404") {
        $rootScope.$broadcast('errorHappened', status, $location.url());
      } else if (status == "401") {
        $location.url("/login");
      } else {
        $log.log("Error Code: " + status + ", Message: " + error);
      }
    }, null);
    
    $scope.previousId = function(){
        
        var previousId = contactManager.getPreviousContact($scope.contact.id);
        if(previousId!=$scope.contact.id && angular.isNumber(previousId)){
            $location.url("/contact/"+previousId);
        }
    };
    
    $scope.nextId = function(){

        var nextId = contactManager.getNextContact($scope.contact.id);
        if(nextId!=$scope.contact.id && angular.isNumber(nextId)){
            $location.url("/contact/"+nextId);
        }
    };
    $scope.refreshLinks = function() {
      $http.get('../mockData/links.json').success(function(data, status) {
        $scope.contact.links = data;
      });
    };

  }
]).controller('NewContactCtrl', ['$scope', '$http','$log',

  function($scope, $http,$log) {
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

    $scope.changeType = function(type) {
      $scope.newLink.type = type;
    };

    $scope.addLink = function() {
      $scope.newLink.modifiedDate = new Date();
      $log.log($scope.newLink.modifiedDate);
      $scope.contact.links.push($scope.newLink);
      // $http.post('/someUrl',$scope.newLink).success()
      $scope.newLink = {
        type: "Supplier",
        name: ""
      };
    };

    $scope.save = function() {
      // $scope.contact.create();
      $log.log($scope.contact);
    };

  }
]);