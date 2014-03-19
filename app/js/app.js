var erpApp = angular.module('erpApp', [
    'ngRoute',
    'erpAnimations',
    'erpDirectives',
    'erpControllers',
    'erpFilters']);

erpApp.config(['$routeProvider',

function ($routeProvider) {
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
    when('/login', {
        templateUrl: 'views/login.html',
        controller: 'LoginCtrl'
    }).
    when('/login/:id', {
        templateUrl: 'views/login.html',
        controller: 'LoginCtrl'
    }).
    when('/404', {
        templateUrl: 'views/404.html',
        controller: '404Ctrl'
    }).
    otherwise({
        redirectTo: '/home'
    });
}]);

erpApp.run(['$rootScope', '$location', function ($rootScope, $location) {
    $rootScope.$on('$routeChangeSuccess', function (event, next, current) {

        //if (true) $location.url("/login");
    });
    $rootScope.$on('errorHappened', function (event, status, next) {
        console.log(event);
        console.log(status);
        console.log(next);
        if (status == "401") {
            $location.url("/login?path=" + next);
        } else if (status == "404") {
            $location.url("/404");
        }
    });
}]);