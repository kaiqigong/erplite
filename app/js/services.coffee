erpServices = angular.module 'erpServices', ['ngCookies']
erpServices.factory 'security', ['$cookies','$http', ($cookies,$http) ->
	setHttpHeader: (header)->
		$http.defaults.headers.common.Authorization = header.Authorization
	saveCookie: () ->
		$cookies.test = "test"
	getCookie: () ->
		token: $cookies.test
	getCSRF: () ->
		$cookies.csrftoken
]