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
      when('/contact', {
        templateUrl: 'views/contactlist.html',
        controller: 'ContactCtrl'
      }).
      when('/contact/:id', {
        templateUrl: 'views/contactdetail.html',
        controller: 'ContactDetailCtrl'
      }).
      otherwise({
        redirectTo: '/home'
      });
  }]);