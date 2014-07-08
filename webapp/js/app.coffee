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
	'messageModule'
	'ui.select2'
	'ui.bootstrap']

erpApp.constant 'erpSettings', {
	###
	apiHost: 'http://localhost:8000'
	client_id: '9addd54d140b6262d909'
	client_secret: '76ce2a11810c35f742c824d1f1e197ce3f5f21ab'
	###
	apiHost: 'http://54.255.168.161'
	client_id:'92a302dcee81f97de5e4'
	client_secret: '939a9af44b98ab5935bbab68ca780a67822ba424'
	qiniuApiHost:'http://up.qiniu.com'
	qiniuBucketDoman:'http://erplite.qiniudn.com'
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
	.when '/message',
		{templateUrl: 'Message/views/message.html', controller: 'MessageCtrl'}
	.when '/finder',
		{templateUrl: 'Finder/views/finder.html', controller: 'finderCtrl'}
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


