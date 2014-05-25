erpApp = angular.module 'erpApp', [
	'ngRoute'
	'restangular'
	'erpAnimations'
	'erpDirectives'
	'angularFileUpload'
	'calendarModule'
	'erpControllers'
	'erpServices'
	'erpFilters'
	'taskModule'
	'contactModule'
	'ui.bootstrap']

erpApp.constant 'erpSettings', {
	apiHost: 'http://localhost:8000'
	client_id: '8389f350ee86e1eac562'
	client_secret: 'bc421ecd94575e8614ec0e4dd28da7f8c9b7186f'
}

erpApp.config ['$routeProvider', ($routeProvider) ->
	$routeProvider
	.when '/home',
		{templateUrl: 'views/home.html', controller: 'HomeCtrl'}
	.when '/contact',
		{templateUrl: 'Contact/views/contactlist.html', controller: 'ContactListCtrl'}
	.when '/contact/new',
		{templateUrl: 'Contact/views/contactdetail.html', controller: 'NewContactCtrl'}
	.when '/contact/:id',
		{templateUrl: 'Contact/views/contactdetail.html', controller: 'ContactDetailCtrl'}
	.when '/login',
		{templateUrl: 'views/login.html', controller: 'LoginCtrl'}
	.when '/logout',
		{templateUrl: 'views/login.html', controller: 'LoginCtrl'}
	.when '/login/:query',
		{templateUrl: 'views/login.html', controller: 'LoginCtrl'}
	.when '/signup',
		{templateUrl: 'views/signup.html', controller: 'SignupCtrl'}
	.when '/404',
		{templateUrl: 'views/404.html', controller: '404Ctrl'}
	.when '/calendar',
		{templateUrl: 'Calendar/views/calendar.html', controller: 'CalendarCtrl'}
	.when '/task',
		{templateUrl: 'Task/views/tasklist.html', controller: 'TaskListCtrl'}
	.otherwise redirectTo: '/home'
]
erpApp.config (RestangularProvider) ->
	# add a response intereceptor
	RestangularProvider.addResponseInterceptor (data, operation, what, url, response, deferred) ->
		extractedData
		if operation is "getList"
			extractedData = data.results;
		else
			extractedData = data;
		return extractedData
erpApp.run ['$rootScope', '$location', '$log', '$http', 'erpSettings', 'Restangular', 'security', 'erplite.utils',
	($rootScope, $location, $log, $http, erpSettings, Restangular, security, utils) ->
		security.restoreToken()

		# Restangular settings
		Restangular.setBaseUrl(erpSettings.apiHost)
		Restangular.setRestangularFields
			selfLink: 'url'
		Restangular.setRequestSuffix '/'

		$rootScope
		.$on '$routeChangeSuccess', (event, next, current)->
			#if (true) $location.url("/login");
		$rootScope
		.$on 'errorHappened', (event, status, next) ->
			switch status
				when '401' then $location.url "/login?path=" + next
				when '404' then $location.url "/404"

		$rootScope.$utils = utils

		$http
		.get erpSettings.apiHost
		.success (data)->
			$rootScope.apimap = data
		.error (error, status)->
			utils.HttpHandle({status: status, data: error})
]


