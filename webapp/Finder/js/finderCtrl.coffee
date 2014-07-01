angular.module 'erpApp'
.controller 'finderCtrl', ['$scope', '$rootScope', '$http', 'Restangular', '$upload',
	($scope, $rootScope, $http, Restangular, $upload)->
		$scope.onFileSelected = ($file)->
			console.log 'file'
			$scope.fileToUpload = $file[0]

		$scope.upload = ()->
			console.log $scope.uptoken
			qiniuParam =
				'key':$scope.key
				#'uploadToken': $scope.uptoken
				'token':$scope.uptoken
				'fileName': $scope.fileToUpload.name
			$upload.upload
				url: 'http://up.qiniu.com'
				method: 'POST'
				data: qiniuParam
				withCredentials: false
				file: $scope.fileToUpload
			.progress (evt)->
				console.log parseInt(100 * evt.loaded / evt.total) + '%'
				$scope.uploadProgress = 50 * evt.loaded / evt.total
			.success (data)->
				console.log data
			.error (error)->
				console.log error
]
