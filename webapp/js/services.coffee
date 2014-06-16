erpServices = angular.module 'erpServices', ['ngCookies']
erpServices.factory 'security', ['$cookies','$http', ($cookies,$http) ->
	setHttpHeader: (header)->
		$http.defaults.headers.common.Authorization =header.tokenType+' '+header.token
		$cookies.authorization = $http.defaults.headers.common.Authorization
	getCSRF: () ->
		$cookies.csrftoken
	clearAccessToken: ()->
		delete $http.defaults.headers.common["Authorization"]
		delete $cookies["authorization"]
	restoreToken: ()->
		if $cookies.authorization?
			$http.defaults.headers.common.Authorization = $cookies.authorization
]