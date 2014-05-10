// Generated by CoffeeScript 1.7.1
(function() {
  var erpApp;

  erpApp = angular.module('erpApp', ['ngRoute', 'restangular', 'erpAnimations', 'erpDirectives', 'angularFileUpload', 'erpControllers', 'erpServices', 'erpFilters', 'contactModule', 'ui.bootstrap']);

  erpApp.constant('erpSettings', {
    apiHost: 'http://localhost:8000',
    client_id: '24777dd22781c6e783a6',
    client_secret: '5abb4a5bd64e98cf720ac97985482dd374ae73d5'
  });

  erpApp.config([
    '$routeProvider', function($routeProvider) {
      return $routeProvider.when('/home', {
        templateUrl: 'views/home.html',
        controller: 'HomeCtrl'
      }).when('/contact', {
        templateUrl: 'Contact/views/contactlist.html',
        controller: 'ContactListCtrl'
      }).when('/contact/new', {
        templateUrl: 'Contact/views/contactdetail.html',
        controller: 'NewContactCtrl'
      }).when('/contact/:id', {
        templateUrl: 'Contact/views/contactdetail.html',
        controller: 'ContactDetailCtrl'
      }).when('/login', {
        templateUrl: 'views/login.html',
        controller: 'LoginCtrl'
      }).when('/logout', {
        templateUrl: 'views/login.html',
        controller: 'LoginCtrl'
      }).when('/login/:query', {
        templateUrl: 'views/login.html',
        controller: 'LoginCtrl'
      }).when('/signup', {
        templateUrl: 'views/signup.html',
        controller: 'SignupCtrl'
      }).when('/404', {
        templateUrl: 'views/404.html',
        controller: '404Ctrl'
      }).otherwise({
        redirectTo: '/home'
      });
    }
  ]);

  erpApp.run([
    '$rootScope', '$location', '$log', '$http', 'erpSettings', 'Restangular', 'security', function($rootScope, $location, $log, $http, erpSettings, Restangular, security) {
      security.restoreToken();
      $http.get(erpSettings.apiHost).success(function(data) {
        return $rootScope.apimap = data;
      }).error(function(error) {
        return $log.log(error);
      });
      Restangular.setBaseUrl(erpSettings.apiHost);
      Restangular.setRestangularFields({
        selfLink: 'url'
      });
      Restangular.setRequestSuffix('/');
      $rootScope.$on('$routeChangeSuccess', function(event, next, current) {});
      return $rootScope.$on('errorHappened', function(event, status, next) {
        switch (status) {
          case '401':
            return $location.url("/login?path=" + next);
          case '404':
            return $location.url("/404");
        }
      });
    }
  ]);

}).call(this);

//# sourceMappingURL=app.map
