erpControllers = angular.module 'erpControllers', ['erpServices']

erpControllers.controller 'RootCtrl', ['$scope','$timeout', ($scope,$timeout) ->
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
	return
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

erpControllers.controller 'LoginCtrl', ['$scope', '$http', 'security', ($scope, $http, security) ->
	$scope.rememberMe = false
	$scope.login = () ->
		loginParam =
			username: $scope.username
			password: $scope.password # security.encrypt($scope.password)
			rememberMe: $scope.rememberMe
		# $http.post('/someUrl',loginParam).success()
		security.saveCookie()
		# add token to cookie. Need a security service in which can get and set the token.
	return
]

erpControllers.controller '404Ctrl', ['$scope', '$http', ($scope, $http) ->
	return
]
