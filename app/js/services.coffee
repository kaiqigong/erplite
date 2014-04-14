erpServices = angular.module 'erpServices', ['ngCookies']
erpServices.factory 'security', ['$cookies','$http', ($cookies,$http) ->
	setHttpHeader: (header)->
		$http.defaults.headers.common.Authorization = "Token "+header.Authorization
		$cookies.access_token = header.Authorization
	getCSRF: () ->
		$cookies.csrftoken
	clearAccessToken: ()->
		delete $http.defaults.headers.common["Authorization"]
		delete $cookies["access_token"]
	restoreToken: ()->
		if $cookies.access_token?
			$http.defaults.headers.common.Authorization = "Token " + $cookies.access_token
]