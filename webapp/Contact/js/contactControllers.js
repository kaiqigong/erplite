// Generated by CoffeeScript 1.7.1
angular.module('contactModule').controller('ContactListCtrl', [
  '$scope', '$http', '$location', '$log', 'ModelBase', 'Restangular', '$rootScope', function($scope, $http, $location, $log, ModelBase, Restangular, $rootScope) {
    $scope.title = "联系人";
    $scope.icon = "./img/128px/layers_128px.png";
    $scope.backUrl = "#/home";
    $scope.addUrl = '#/contact/new';
    $scope.isAdvanceSearchCollapsed = true;
    $scope.toggleAdvanceSearch = function() {
      if ($scope.isAdvanceSearchCollapsed) {
        return $scope.isAdvanceSearchCollapsed = false;
      } else {
        return $scope.isAdvanceSearchCollapsed = true;
      }
    };
    $scope.currentPage = 1;
    $scope.contactMatch = function(query) {
      return function(item) {
        if (query == null) {
          return true;
        }
        return item.name.indexOf(query) >= 0 || item.description.indexOf(query) >= 0;
      };
    };
    $scope.progressBar.start();
    $scope.progressBar.set(50);
    return Restangular.all('contacts').getList().then(function(data) {
      $scope.items = data;
      return $scope.progressBar.end();
    }, function(reason) {
      if (reason.status === 404) {
        $rootScope.$broadcast('errorHappened', reason.status, $location.url());
      } else if (reason.status === 401 || reason.status === 403) {
        $location.url("/login?query=" + encodeURIComponent($location.url()));
        $location.replace();
      } else {
        $log.log("Error Code: " + reason.status + ", Message: " + reason.data);
      }
      return $scope.progressBar.end();
    });
  }
]).controller('ContactDetailCtrl', [
  '$scope', '$http', '$q', '$routeParams', '$location', '$log', 'ModelBase', 'Restangular', '$upload', '$modal', '$rootScope', function($scope, $http, $q, $routeParams, $location, $log, ModelBase, Restangular, $upload, $modal, $rootScope) {
    $scope.progressBar.start();
    $scope.progressBar.set(50);
    $scope.backUrl = "#/contact";
    $scope.contact = null;
    $scope.showToolbar = true;
    $scope.showRefresh = true;
    $scope.newLink = {
      type: "Supplier",
      name: ""
    };
    $scope.changeType = function(type) {
      return $scope.newLink.type = type;
    };
    $scope.addLink = function() {
      $scope.newLink.modifiedDate = new Date();
      $scope.contact.links.push(angular.copy($scope.newLink));
      return $scope.newLink = {
        type: "Supplier",
        name: ""
      };
    };
    $scope.addData = function() {
      var newData;
      newData = angular.copy($scope.newData);
      $scope.newData.key = "";
      $scope.newData.value = "";
      return $scope.contactDatas.push(newData);
    };
    $scope.save = function() {
      $scope.progressBar.start();
      $scope.progressBar.set(20);
      $scope.contact.name = $scope.title;
      if ($scope.contactData.id == null) {
        $scope.contactData.createdBy = 'Cage';
        $scope.contactData.modifiedBy = 'Cage';
        $scope.contactData.contact = $scope.contact.id;
        return Restangular.one('contacts', $scope.contact.id).all('contactdata').post($scope.contactData).then(function(contactdata) {
          console.log(contactdata);
          return $scope.contact.put().then($scope.reload);
        });
      } else {
        return $scope.contactData.put().then(function() {
          return $scope.contact.put().then($scope.reload);
        });
      }
    };
    $scope.reload = function() {
      Restangular.one('contacts', $routeParams.id).get().then(function(contact) {
        $scope.contact = contact;
        $scope.title = contact.name;
        return $scope.progressBar.end();
      }, function(reason) {
        $scope.progressBar.end();
        if (reason.status === 404) {
          return $rootScope.$broadcast('errorHappened', reason.status, $location.url());
        } else if (reason.status === 401 || reason.status === 403) {
          return $location.url("/login");
        } else {
          return $log.log("Error Code: " + reason.status + ", Message: " + reason.data);
        }
      }, null);
      return Restangular.one('contacts', $routeParams.id).all('contactdata').getList().then(function(contactData) {
        if (contactData.length > 0) {
          return $scope.contactData = contactData[0];
        }
      });
    };
    $scope.previousId = function() {
      var previousId;
      previousId = contactManager.getPreviousContact($scope.contact.id);
      if (previousId !== $scope.contact.id && angular.isNumber(previousId)) {
        return $location.url("/contact/" + previousId);
      }
    };
    $scope.nextId = function() {
      var nextId;
      nextId = contactManager.getNextContact($scope.contact.id);
      if (nextId !== $scope.contact.id && angular.isNumber(nextId)) {
        return $location.url("/contact/" + nextId);
      }
    };
    $scope.refreshLinks = function() {
      return $http.get('../mockData/links.json').success(function(data, status) {
        return $scope.contact.links = data;
      });
    };
    $scope.onAvatorClick = function() {
      var modalInstance;
      modalInstance = $modal.open({
        templateUrl: '../app/views/imageprocess.html',
        controller: "ImgProcessCtrl"
      });
      return modalInstance.result.then(function(avatorUrl) {
        return $scope.contact.avator = avatorUrl;
      }, function() {
        return $log.info('Modal dismissed');
      });
    };
    return $scope.reload();
  }
]).controller('NewContactCtrl', [
  '$scope', '$http', '$log', 'Restangular', '$upload', '$modal', '$location', '$rootScope', function($scope, $http, $log, Restangular, $upload, $modal, $location, $rootScope) {
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
      return $scope.newLink.type = type;
    };
    $scope.addLink = function() {
      $scope.newLink.modifiedDate = new Date();
      $scope.contact.links.push($scope.newLink);
      return $scope.newLink = {
        type: "Supplier",
        name: ""
      };
    };
    $scope.onAvatorClick = function() {
      var modalInstance;
      modalInstance = $modal.open({
        templateUrl: '../app/views/imageprocess.html',
        controller: "ImgProcessCtrl"
      });
      return modalInstance.result.then(function(avatorUrl) {
        return $scope.contact.avator = avatorUrl;
      }, function() {
        return $log.info('Modal dismissed');
      });
    };
    return $scope.save = function() {
      $scope.progressBar.start();
      $scope.progressBar.set(20);
      $scope.contactData.createdBy = 'Cage';
      $scope.contactData.modifiedBy = 'Cage';
      $scope.contact.createdBy = 'Cage';
      $scope.contact.modifiedBy = 'Cage';
      $scope.contact.name = $scope.title;
      return Restangular.all('contacts').post($scope.contact).then(function(contact) {
        $scope.contactData.contact = contact.id;
        return Restangular.one('contacts', contact.id).all('contactdata').post($scope.contactData).then(function(contactData) {
          console.log(contactData);
          $location.url("/contact/" + contact.id);
          return $scope.progressBar.end();
        });
      });
    };
  }
]);