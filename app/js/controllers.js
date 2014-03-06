 var erpControllers = angular.module('erpControllers', []);
 
erpControllers.controller('HomeCtrl', ['$scope', '$http',
  function ($scope, $http) {
    $scope.title="Welcome, Kaiqi";
  }]);
 