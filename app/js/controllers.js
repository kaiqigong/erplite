 var erpControllers = angular.module('erpControllers', []);
 
erpControllers.controller('HomeCtrl', ['$scope', '$http',
  function ($scope, $http) {
    $scope.title="Welcome, Kaiqi";
	 $http.get('../mockData/applist.json').success(function(data) {
      $scope.apps = data;
    });    
    
  }]);
 