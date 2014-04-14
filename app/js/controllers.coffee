erpControllers = angular.module 'erpControllers', ['erpServices']

erpControllers.controller 'RootCtrl', ['$scope','$timeout','erpSettings', ($scope,$timeout,erpSettings) ->
	$scope.title = ""
	$scope.hasError = false
	$scope.progressShow = false
	$scope.progressValue = 0
	$scope.progressType = 'success'
	$scope.progressBar=
		blink:()->
			# TODO: don't work :(
			$timeout ()->
				$scope.progressShow = true
				$scope.progressValue = 50
			,500
			$timeout () ->
				$scope.progressValue = 100
			,1000
			$timeout () ->
				$scope.progressShow = false
			,1500
			$timeout () ->
				$scope.progressValue = 0
			,2500

		start: () ->
			$scope.progressShow = true
			$scope.progressValue = 0
		
		set: (progress) ->
			$scope.progressValue = progress

		end: () ->
			$scope.progressValue = 100; 
			$scope.progressShow = false;
			$timeout ()->
				$scope.progressValue = 0
			,1000

	$scope.erpSettings = erpSettings
]

erpControllers.controller 'HomeCtrl', ['$scope', '$http', '$location', '$rootScope', ($scope, $http, $location, $rootScope) ->
	$scope.title = "Welcome, Kaiqi"
	$scope.hasError = false
	$scope.progressBar.start()
	$scope.progressBar.set 50
	$http.get '../mockData/applist.json' 
	.success (data, status) ->
		$scope.apps = data
		$scope.progressBar.end()
	.error (data, status) ->
		$scope.hasError = true
		$scope.progressBar.end()
		if status == "404"
			$scope.error = "404 not found"
			$rootScope.$broadcast 'errorHappened', status, $location.url()
		else if status == "401"
			$location.url "/login"
		else
			$scope.error = "Error Code: #{status}, Message: #{data}"
	return
]

erpControllers.controller 'LoginCtrl', ['$scope', '$http', 'security','$routeParams','$location', ($scope, $http, security,$routeParams,$location) ->
	if $location.url() is '/logout'
		$http.get($scope.erpSettings.apiHost+'/accounts/logout')
		.success ->
			console.log 'logout'
	$scope.rememberMe = false
	$scope.login = () ->
		loginParam = "csrfmiddlewaretoken="+security.getCSRF() +
		"&username=" + $scope.username +
		"&password=" + $scope.password # security.encrypt($scope.password)"
		$http.post($scope.erpSettings.apiHost+'/accounts/login',loginParam,{headers: {
		'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'}})
		.success (data)->
			console.log data # TODO: crawl the user name in dom html
			result = angular.element data
			token = result.find("#code").text()
			headers=
				'Authorization': token
			security.setHttpHeader headers
			if $routeParams.query?
				$location.url(encodeURIComponent($routeParams.query))
				$location.replace()
			else
				$location.url('/home')
				$location.replace()
		.error ()->
			console.log 'error'
		.finally ()->
			console.log 'finally'
		security.saveCookie()
		# add token to cookie. Need a security service in which can get and set the token.
	return
]

erpControllers.controller 'SignupCtrl', ['$scope', '$http', 'security','$routeParams','$location', ($scope, $http, security,$routeParams,$location) ->
	$scope.signup = () ->
		signupParam = "csrfmiddlewaretoken="+security.getCSRF() +
		"&username=" + $scope.username +
		"&email=" + $scope.email +
		"&password=" + $scope.password # security.encrypt($scope.password)"
		$http.post($scope.erpSettings.apiHost+'/accounts/register',signupParam,{headers: {
		'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'}})
		.success ->
			if $routeParams.query?
				$location.url(encodeURIComponent($routeParams.query))
				$location.replace()
			else
				$location.url('/home')
				$location.replace()
		.error ()->
			console.log 'error'
		.finally ()->
			console.log 'finally'
		security.saveCookie()
		# add token to cookie. Need a security service in which can get and set the token.
	return
]

erpControllers.controller '404Ctrl', ['$scope', '$http', ($scope, $http) ->
	return
]
