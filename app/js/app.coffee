erpApp = angular.module 'erpApp', [
    'ngRoute'
    'erpAnimations'
    'erpDirectives'
    'erpControllers'
    'erpServices'
    'erpFilters'
    'contactModule'
    'ui.bootstrap']

erpApp.constant 'erpSettings', {apiHost:'http://localhost:8000'}

erpApp.config(['$routeProvider',($routeProvider) -> 
	$routeProvider
	.when '/home',
		{templateUrl: 'views/home.html',controller: 'HomeCtrl'}
	.when '/contact', 
		{templateUrl: 'Contact/views/contactlist.html',controller: 'ContactListCtrl'}
	.when '/contact/new', 
		{templateUrl: 'Contact/views/contactdetail.html',controller: 'NewContactCtrl'}
	.when '/contact/:id', 
		{templateUrl: 'Contact/views/contactdetail.html',controller: 'ContactDetailCtrl'}
	.when '/login', 
		{templateUrl: 'views/login.html',controller: 'LoginCtrl'}
	.when '/logout', 
		{templateUrl: 'views/login.html',controller: 'LoginCtrl'}
	.when '/login/:query', 
		{templateUrl: 'views/login.html',controller: 'LoginCtrl'}
	.when '/404', 
		{templateUrl: 'views/404.html',controller: '404Ctrl'}
	.otherwise redirectTo: '/home'
])

erpApp.run ['$rootScope', '$location','$log','$http','erpSettings', ($rootScope, $location,$log,$http,erpSettings) ->
	$http
	.get erpSettings.apiHost 
	.success (data)->
		$rootScope.apimap = data
	.error (error)->
		$log.log error
	$rootScope
	.$on '$routeChangeSuccess', (event, next, current)->
		#if (true) $location.url("/login");
	$rootScope
	.$on 'errorHappened', (event, status, next) ->
		switch status
			when '401' then $location.url "/login?path=" + next 
			when '404' then $location.url "/404" 
]

