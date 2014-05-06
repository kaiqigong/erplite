// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty;

  angular.module('contactModule').controller('ContactListCtrl', [
    '$scope', '$http', '$location', 'contactManager', '$log', 'ModelBase', 'Restangular', '$rootScope', function($scope, $http, $location, contactManager, $log, ModelBase, Restangular, $rootScope) {
      var promise;
      $scope.title = "联系人";
      $scope.icon = "./img/128px/layers_128px.png";
      $scope.backUrl = "#/home";
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
      promise = contactManager.loadContactList();
      return promise.then(function(contacts) {
        $scope.items = contacts;
        $log.log(contacts);
        return $scope.progressBar.end();
      }, function(reason) {
        $scope.progressBar.end();
        if (reason.status === 404) {
          return $rootScope.$broadcast('errorHappened', reason.status, $location.url());
        } else if (reason.status === 401 || reason.status === 403) {
          $location.url("/login?query=" + encodeURIComponent($location.url()));
          return $location.replace();
        } else {
          return $log.log("Error Code: " + reason.status + ", Message: " + reason.data);
        }
      }, null);
    }
  ]).controller('ContactDetailCtrl', [
    '$scope', '$http', '$q', '$routeParams', 'contactManager', '$location', '$log', 'ModelBase', 'Restangular', '$upload', '$modal', '$rootScope', function($scope, $http, $q, $routeParams, contactManager, $location, $log, ModelBase, Restangular, $upload, $modal, $rootScope) {
      var dataFields;
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
      $scope.contactDatas = [];
      dataFields = [];
      $scope.unsetFields = [];
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
        var contactData, promises, _i, _len, _ref, _ref1;
        $log.log($scope.contact);
        promises = [];
        $scope.progressBar.start();
        $scope.progressBar.set(20);
        if ($scope.contact.data == null) {
          $scope.contact.dataObj = {};
          $scope.contact.dataObj.createdBy = 'Cage';
          $scope.contact.dataObj.modifiedBy = 'Cage';
        }
        _ref = $scope.contactDatas;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          contactData = _ref[_i];
          if ((_ref1 = contactData.key) === 'surname' || _ref1 === 'givenname' || _ref1 === 'company' || _ref1 === 'department' || _ref1 === 'title' || _ref1 === 'phone' || _ref1 === 'mobile' || _ref1 === 'fax' || _ref1 === 'origin' || _ref1 === 'email' || _ref1 === 'address' || _ref1 === 'birthday' || _ref1 === 'region' || _ref1 === 'website' || _ref1 === 'qq' || _ref1 === 'weibo' || _ref1 === 'im') {
            (function(contactData) {
              return $scope.contact.dataObj[contactData.key] = contactData.value;
            })(contactData);
          }
        }
        if ($scope.contact.data == null) {
          $scope.contact.dataObj.contact = $scope.contact.id;
          promises.push(Restangular.one('contacts', contact.id).all('contactdata').post($scope.contact.dataObj).then(function(contactdata) {
            return console.log(contactdata);
          }));
        } else {
          promises.push($scope.contact.dataObj.put());
        }
        promises.push($scope.contact.put());
        return $q.all(promises).then($scope.reload);
      };
      $scope.reload = function() {
        var promise;
        promise = contactManager.loadContact($routeParams.id);
        return promise.then(function(contact) {
          var propName, propValue, _ref;
          $scope.contact = contact;
          $scope.contactDatas = [];
          $scope.unsetFields = [];
          dataFields = [];
          _ref = contact.dataObj;
          for (propName in _ref) {
            if (!__hasProp.call(_ref, propName)) continue;
            propValue = _ref[propName];
            if (!(propName === 'surname' || propName === 'givenname' || propName === 'company' || propName === 'department' || propName === 'title' || propName === 'phone' || propName === 'mobile' || propName === 'fax' || propName === 'origin' || propName === 'email' || propName === 'address' || propName === 'birthday' || propName === 'region' || propName === 'website' || propName === 'qq' || propName === 'weibo' || propName === 'im')) {
              continue;
            }
            dataFields.push(propName);
            if ((propValue != null) && propValue !== "") {
              $scope.contactDatas.push({
                key: propName,
                value: propValue
              });
            } else {
              $scope.unsetFields.push(propName);
            }
          }
          if (!contact.dataObj) {
            $scope.unsetFields = ['surname', 'givenname', 'company', 'department', 'title', 'phone', 'mobile', 'fax', 'origin', 'email', 'address', 'birthday', 'region', 'website', 'qq', 'weibo', 'im'];
          }
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
      var dataFields;
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
      $scope.contactDatas = [];
      dataFields = [];
      $scope.unsetFields = ['surname', 'givenname', 'company', 'department', 'title', 'phone', 'mobile', 'fax', 'origin', 'email', 'address', 'birthday', 'region', 'website', 'qq', 'weibo', 'im'];
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
      $scope.addData = function() {
        var newData;
        newData = angular.copy($scope.newData);
        $scope.newData.key = "";
        $scope.newData.value = "";
        return $scope.contactDatas.push(newData);
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
        var contactData, _i, _len, _ref, _ref1;
        $log.log($scope.contact);
        $scope.progressBar.start();
        $scope.progressBar.set(20);
        $scope.contact.dataObj = {};
        $scope.contact.dataObj.createdBy = 'Cage';
        $scope.contact.dataObj.modifiedBy = 'Cage';
        _ref = $scope.contactDatas;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          contactData = _ref[_i];
          if ((_ref1 = contactData.key) === 'surname' || _ref1 === 'givenname' || _ref1 === 'company' || _ref1 === 'department' || _ref1 === 'title' || _ref1 === 'phone' || _ref1 === 'mobile' || _ref1 === 'fax' || _ref1 === 'origin' || _ref1 === 'email' || _ref1 === 'address' || _ref1 === 'birthday' || _ref1 === 'region' || _ref1 === 'website' || _ref1 === 'qq' || _ref1 === 'weibo' || _ref1 === 'im') {
            (function(contactData) {
              return $scope.contact.dataObj[contactData.key] = contactData.value;
            })(contactData);
          }
        }
        $scope.contact.dataObj.contact = $scope.contact.id;
        $scope.contact.createdBy = 'Cage';
        $scope.contact.modifiedBy = 'Cage';
        $scope.contact.name = $scope.title;
        return Restangular.all('contacts').post($scope.contact).then(function(contact) {
          $scope.contact.dataObj.contact = contact.id;
          return Restangular.one('contacts', contact.id).all('contactdata').post($scope.contact.dataObj).then(function(contactData) {
            console.log(contactData);
            $location.url("/contact/" + contact.id);
            return $scope.progressBar.end();
          });
        });
      };
    }
  ]);

}).call(this);
