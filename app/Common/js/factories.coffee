angular.module 'erplite.common'
.factory 'HttpHandle', ['$location','$rootScope','$log', ($location, $rootScope,$log)->
	return (reason)->
		if reason.status is 404
			$location.url('/404')
			$location.replace()
		else if reason.status is 401 or reason.status is 403
			$location.url "/login?query=" + encodeURIComponent($location.url())
			$location.replace()
		else
			$log.log("Error Code: " + reason.status + ", Message: " + reason.data)
]
.factory 'erplite.utils', ['HttpHandle',(HttpHdl)->
	HttpHandle : HttpHdl
]