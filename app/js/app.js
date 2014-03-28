var erpApp = angular.module('erpApp', [
    'ngRoute',
    'erpAnimations',
    'erpDirectives',
    'erpControllers',
    'erpServices',
    'erpFilters',
    'contactModule']);

erpApp.constant('erpSettings', {apiHost:'http://localhost:8000'});

erpApp.config(['$routeProvider',

function ($routeProvider) {
    $routeProvider.
    when('/home', {
        templateUrl: 'views/home.html',
        controller: 'HomeCtrl'
    }).
    when('/contact', {
        templateUrl: 'Contact/views/contactlist.html',
        controller: 'ContactListCtrl'
    }).
    when('/contact/new', {
        templateUrl: 'Contact/views/contactdetail.html',
        controller: 'NewContactCtrl'
    }).
    when('/contact/:id', {
        templateUrl: 'Contact/views/contactdetail.html',
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

erpApp.run(['$rootScope', '$location','$log', function ($rootScope, $location,$log) {
    $rootScope.$on('$routeChangeSuccess', function (event, next, current) {

        //if (true) $location.url("/login");
    });
    $rootScope.$on('errorHappened', function (event, status, next) {
        $log.log(event);
        $log.log(status);
        $log.log(next);
        if (status == "401") {
            $location.url("/login?path=" + next);
        } else if (status == "404") {
            $location.url("/404");
        }
    });
}]);