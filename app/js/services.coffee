erpServices = angular.module 'erpServices', ['ngCookies']
erpServices.factory 'security', ($cookies) ->

	saveCookie: () ->
            $cookies.test = "test"
	getCookie: () ->
		token: $cookies.test