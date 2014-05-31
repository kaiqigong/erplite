// Generated by CoffeeScript 1.7.1
var erpControllers;

erpControllers = angular.module('erpControllers', ['erpServices']);

erpControllers.controller('RootCtrl', [
  '$scope', '$timeout', 'erpSettings', function($scope, $timeout, erpSettings) {
    $scope.title = "";
    $scope.hasError = false;
    $scope.progressShow = false;
    $scope.progressValue = 0;
    $scope.progressType = 'success';
    $scope.progressBar = {
      blink: function() {
        $timeout(function() {
          $scope.progressShow = true;
          return $scope.progressValue = 50;
        }, 500);
        $timeout(function() {
          return $scope.progressValue = 100;
        }, 1000);
        $timeout(function() {
          return $scope.progressShow = false;
        }, 1500);
        return $timeout(function() {
          return $scope.progressValue = 0;
        }, 2500);
      },
      start: function() {
        $scope.progressShow = true;
        return $scope.progressValue = 0;
      },
      set: function(progress) {
        return $scope.progressValue = progress;
      },
      end: function() {
        $scope.progressValue = 100;
        $scope.progressShow = false;
        return $timeout(function() {
          return $scope.progressValue = 0;
        }, 1000);
      }
    };
    return $scope.erpSettings = erpSettings;
  }
]);

erpControllers.controller('HomeCtrl', [
  '$scope', '$http', '$location', '$rootScope', function($scope, $http, $location, $rootScope) {
    $scope.title = "Welcome, Kaiqi";
    $scope.hasError = false;
    $scope.progressBar.start();
    $scope.progressBar.set(50);
    $http.get('../mockData/applist.json').success(function(data, status) {
      $scope.apps = data;
      return $scope.progressBar.end();
    }).error(function(data, status) {
      $scope.hasError = true;
      $scope.progressBar.end();
      if (status === "404") {
        $scope.error = "404 not found";
        return $rootScope.$broadcast('errorHappened', status, $location.url());
      } else if (status === "401") {
        return $location.url("/login");
      } else {
        return $scope.error = "Error Code: " + status + ", Message: " + data;
      }
    });
  }
]);

erpControllers.controller('LoginCtrl', [
  '$scope', '$http', 'security', '$routeParams', '$location', function($scope, $http, security, $routeParams, $location) {
    if ($location.url() === '/logout') {
      security.clearAccessToken();
      $http.get($scope.erpSettings.apiHost + '/accounts/logout').success(function() {
        return console.log('logout');
      });
    }
    security.clearAccessToken();
    $scope.rememberMe = false;
    $scope.login = function() {
      var loginParam;
      loginParam = {
        client_id: $scope.erpSettings.client_id,
        client_secret: $scope.erpSettings.client_secret,
        username: $scope.username,
        password: $scope.password,
        grant_type: 'password'
      };
      return $http({
        method: "POST",
        url: $scope.erpSettings.apiHost + '/login/access_token/',
        data: $.param(loginParam),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      }).success(function(data) {
        var headers, token, tokenType;
        console.log(data);
        token = data.access_token;
        tokenType = data.token_type;
        headers = {
          'token': token,
          'tokenType': tokenType
        };
        security.setHttpHeader(headers);
        if ($routeParams.query != null) {
          $location.url(encodeURIComponent($routeParams.query));
          return $location.replace();
        } else {
          $location.url('/home');
          return $location.replace();
        }
      }).error(function() {
        return console.log('error');
      })["finally"](function() {
        return console.log('finally');
      });
    };
  }
]);

erpControllers.controller('SignupCtrl', [
  '$scope', '$http', 'security', '$routeParams', '$location', function($scope, $http, security, $routeParams, $location) {
    $scope.signup = function() {
      var signupParam;
      signupParam = "csrfmiddlewaretoken=" + security.getCSRF() + "&username=" + $scope.username + "&email=" + $scope.email + "&password=" + $scope.password;
      return $http.post($scope.erpSettings.apiHost + '/accounts/register', signupParam, {
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        }
      }).success(function() {
        var loginParam;
        loginParam = {
          client_id: $scope.erpSettings.client_id,
          client_secret: $scope.erpSettings.client_secret,
          username: $scope.username,
          password: $scope.password,
          grant_type: 'password'
        };
        return $http({
          method: "POST",
          url: $scope.erpSettings.apiHost + '/login/access_token/',
          data: $.param(loginParam),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).success(function(data) {
          var headers, token, tokenType;
          console.log(data);
          token = data.access_token;
          tokenType = data.token_type;
          headers = {
            'token': token,
            'tokenType': tokenType
          };
          security.setHttpHeader(headers);
          if ($routeParams.query != null) {
            $location.url(encodeURIComponent($routeParams.query));
            return $location.replace();
          } else {
            $location.url('/home');
            return $location.replace();
          }
        }).error(function() {
          return console.log('error');
        });
      }).error(function() {
        return console.log('error');
      });
    };
  }
]);

erpControllers.controller('404Ctrl', ['$scope', '$http', function($scope, $http) {}]);

erpControllers.controller('ImgProcessCtrl', [
  '$scope', '$modalInstance', '$upload', 'erpSettings', function($scope, $modalInstance, $upload, erpSettings) {
    var files;
    $scope.avator = "";
    $scope.step = "Please Choose a Picture";
    files = null;
    $scope.onFileSelect = function($files) {
      var reader;
      console.log($files);
      reader = new FileReader();
      reader.onload = function(event) {
        $scope.avator = event.target.result;
        return $scope.$apply();
      };
      reader.readAsDataURL($files[0]);
      $scope.step = "Please Resize the Picture and Save";
      return files = $files;
    };
    $scope.save = function() {
      var file, _i, _len, _results;
      if (files == null) {
        return;
      }
      _results = [];
      for (_i = 0, _len = files.length; _i < _len; _i++) {
        file = files[_i];
        _results.push($scope.upload = $upload.upload({
          url: erpSettings.apiHost + '/files/upload/',
          data: {
            myObj: $scope.myModelObj
          },
          file: file,
          fileFormDataName: 'file'
        }).progress(function(evt) {
          return console.log('percent: ' + parseInt(100.0 * evt.loaded / evt.total));
        }).success(function(data, status, headers, config) {
          $scope.avator = erpSettings.apiHost + '/' + data;
          return $modalInstance.close($scope.avator);
        }).error(function(response) {
          console.log(response);
          return $scope.step = response;
        }));
      }
      return _results;
    };
    return $scope.cancel = function() {
      return $modalInstance.dismiss('cancel');
    };
  }
]);
