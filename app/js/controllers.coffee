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
		security.clearAccessToken()
		$http.get($scope.erpSettings.apiHost+'/accounts/logout')
		.success ->
			console.log 'logout'
	security.clearAccessToken()
	$scope.rememberMe = false
	$scope.login = () ->
		loginParam =
			client_id:$scope.erpSettings.client_id
			client_secret:$scope.erpSettings.client_secret
			username:$scope.username
			password:$scope.password
			grant_type:'password'
		$http
			method:"POST"
			url:$scope.erpSettings.apiHost+'/login/access_token/'
			data:$.param(loginParam)
			headers:
				'Content-Type': 'application/x-www-form-urlencoded'
		.success (data)->
			console.log data
			token = data.access_token
			tokenType=data.token_type
			headers=
				'token': token
				'tokenType':tokenType
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
			loginParam =
				client_id:$scope.erpSettings.client_id
				client_secret:$scope.erpSettings.client_secret
				username:$scope.username
				password:$scope.password
				grant_type:'password'
			$http
				method:"POST"
				url:$scope.erpSettings.apiHost+'/login/access_token/'
				data:$.param(loginParam)
				headers:
					'Content-Type': 'application/x-www-form-urlencoded'
			.success (data)->
				console.log data
				token = data.access_token
				tokenType=data.token_type
				headers=
					'token': token
					'tokenType':tokenType
				security.setHttpHeader headers
				if $routeParams.query?
					$location.url(encodeURIComponent($routeParams.query))
					$location.replace()
				else
					$location.url('/home')
					$location.replace()
			.error ()->
				console.log 'error'
		.error ()->
			console.log 'error'
		# add token to cookie. Need a security service in which can get and set the token.
	return
]

erpControllers.controller '404Ctrl', ['$scope', '$http', ($scope, $http) ->
	return
]

erpControllers.controller 'ImgProcessCtrl', ['$scope', '$modalInstance','$upload','erpSettings', ($scope, $modalInstance,$upload,erpSettings) ->
	$scope.avator =""
	$scope.step = "Please Choose a Picture"
	files = null
	$scope.onFileSelect= ($files)->
		console.log $files
		reader = new FileReader()
		reader.onload = (event) ->
			$scope.avator = event.target.result
			$scope.$apply()
		reader.readAsDataURL($files[0])
		$scope.step = "Please Resize the Picture and Save"
		files = $files

	$scope.save = ()->
		if not files?
			return
		# $files: an array of files selected, each file has name, size, and type.
		for file in files
			$scope.upload = $upload.upload
				url:erpSettings.apiHost + '/files/upload/', #upload.php script, node.js route, or servlet url
				# method: POST or PUT,
				# headers: {'header-key': 'header-value'},
				# withCredentials: true,
				data: {myObj: $scope.myModelObj},
				file: file
				# set the file formData name ('Content-Desposition'). Default is 'file'
				fileFormDataName: 'file', # or a list of names for multiple files (html5).
				# customize how data is added to formData. See #40#issuecomment-28612000 for sample code
				# formDataAppender: function(formData, key, val){}
			.progress (evt)->
				console.log('percent: ' + parseInt(100.0 * evt.loaded / evt.total));
			.success (data, status, headers, config) ->
				# file is uploaded successfully
				$scope.avator = '/'+data
				$modalInstance.close($scope.avator)
			.error (response)->
				console.log response
				$scope.step = response
			#.then(success, error, progress);
			#.xhr(function(xhr){xhr.upload.addEventListener(...)})// access and attach any event listener to XMLHttpRequest.

	$scope.cancel = ->
		$modalInstance.dismiss 'cancel'
]
