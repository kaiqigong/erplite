angular.module 'erpApp'
.controller 'finderCtrl', ['$scope', '$rootScope', '$http', 'Restangular', '$upload','erpSettings'
	($scope, $rootScope, $http, Restangular, $upload,erpSettings)->
		$scope.onFileSelected = ($file)->
			console.log 'file'
			$scope.fileToUpload = $file[0]

		$scope.getUploadToken = ()->
			$http.get(erpSettings.apiHost+'/files/uploadToken/').success (data)->
				console.log data
				$scope.uptoken = data.uptoken
		$scope.upload = ()->
			console.log $scope.uptoken
			qiniuParam =
				'key':$scope.key
				#'uploadToken': $scope.uptoken
				'token':$scope.uptoken
				'fileName': $scope.fileToUpload.name
				'fops':encodeURIComponent($scope.process)
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

		$scope.encode = (input)->
			console.log input
			$scope.encodedUri = Base64.encodeURI(input)
			console.log $scope.encodedUri


]
