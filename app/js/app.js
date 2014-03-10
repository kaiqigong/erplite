var erpApp = angular.module('erpApp', [
  'ngRoute',
  'erpControllers',
  'erpFilters'
]);
 
erpApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/home', {
        templateUrl: 'views/home.html',
        controller: 'HomeCtrl'
      }).
      otherwise({
        redirectTo: '/home'
      });
  }]);