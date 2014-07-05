angular.module 'contactModule'
.controller 'ContactListCtrl', ['$scope', '$http', '$location', '$log', 'ModelBase', 'Restangular',
								'$rootScope',
	($scope, $http, $location, $log, ModelBase, Restangular, $rootScope) ->
		$scope.title = "联系人"
		$scope.icon = "./img/128px/layers_128px.png"
		$scope.backUrl = "#/home"
		$scope.addUrl = '#/contact/new'
		$scope.isAdvanceSearchCollapsed = true
		$scope.toggleAdvanceSearch = ->
			if $scope.isAdvanceSearchCollapsed
				$scope.isAdvanceSearchCollapsed = false
				# init filters
			else
				$scope.isAdvanceSearchCollapsed = true
		# clear filter

		$scope.currentPage = 1
		$scope.contactMatch = (query) ->
			(item) ->
				if not query?
					return true
				return item.name.indexOf(query) >= 0 or item.description.indexOf(query) >= 0

		$scope.progressBar.start()
		$scope.progressBar.set 50

		Restangular.all('contacts').getList()
		.then (data) ->
			$scope.items = data
			$scope.progressBar.end()
		, (reason)->
			if reason.status is 404
				$rootScope.$broadcast 'errorHappened', reason.status, $location.url()
			else if reason.status is 401 or reason.status is 403
				$location.url "/login?query=" + encodeURIComponent($location.url())
				$location.replace()
			else
				$log.log("Error Code: " + reason.status + ", Message: " + reason.data)
			$scope.progressBar.end()


]
.controller 'ContactDetailCtrl', ['$scope', '$http', '$q', '$routeParams', '$location', '$log',
								  'ModelBase', 'Restangular', '$upload', '$modal', '$rootScope',
	($scope, $http, $q, $routeParams, $location, $log, ModelBase, Restangular, $upload, $modal, $rootScope) ->
		$scope.progressBar.start()
		$scope.progressBar.set 50
		$scope.backUrl = "#/contact"
		$scope.contact = null
		$scope.showToolbar = true
		$scope.showRefresh = true
		$scope.newLink =
			type: "Supplier"
			name: ""

		$scope.changeType = (type) ->
			$scope.newLink.type = type

		$scope.addLink = () ->
			$scope.newLink.modifiedDate = new Date()
			$scope.contact.links.push angular.copy $scope.newLink
			# $http.post('/someUrl',$scope.newLink).success()
			$scope.newLink =
				type: "Supplier"
				name: ""

		$scope.addData = () ->
			newData = angular.copy $scope.newData
			$scope.newData.key = ""
			$scope.newData.value = ""
			$scope.contactDatas.push newData

		$scope.save = () ->
			$scope.progressBar.start()
			$scope.progressBar.set(20)
			$scope.contact.name = $scope.title
			# update data
			if not $scope.contactData.id?
				$scope.contactData.createdBy = 'Cage'
				$scope.contactData.modifiedBy = 'Cage' # Todo: auto generate in DB
				#post then put
				$scope.contactData.contact = $scope.contact.id
				Restangular.one('contacts', $scope.contact.id)
				.all('contactdata').post($scope.contactData)
				.then (contactdata)->
					console.log contactdata
					$scope.contact.put().then $scope.reload
			else
				#put then put
				$scope.contactData.put().then ()->
					$scope.contact.put().then $scope.reload

		$scope.reload = () ->
			Restangular.one('contacts', $routeParams.id).get().then (contact)->
				$scope.contact = contact
				$scope.title = contact.name
				$scope.progressBar.end()
			, (reason) ->
				$scope.progressBar.end()
				if reason.status is 404
					$rootScope.$broadcast 'errorHappened', reason.status, $location.url()
				else if reason.status is 401 or reason.status is 403
					$location.url "/login"
				else
					$log.log "Error Code: " + reason.status + ", Message: " + reason.data
			, null
			Restangular.one('contacts', $routeParams.id).all('contactdata').getList().then (contactData)->
				if contactData.length > 0
					$scope.contactData = contactData[0]

		# TODO: disable the button before data is retrieved.
		$scope.previousId = ->
			previousId = contactManager.getPreviousContact $scope.contact.id
			if previousId != $scope.contact.id and angular.isNumber previousId
				$location.url "/contact/" + previousId

		$scope.nextId = ->
			nextId = contactManager.getNextContact $scope.contact.id
			if nextId != $scope.contact.id and angular.isNumber nextId
				$location.url "/contact/" + nextId

		$scope.refreshLinks = ->
			$http.get '../mockData/links.json'
			.success (data, status) ->
				$scope.contact.links = data

		$scope.onAvatarClick = ->
			modalInstance = $modal.open({
				templateUrl: '../views/imageprocess.html',
				controller: "ImgProcessCtrl"})

			modalInstance.result.then (result) ->
				$scope.contact.avatar = result[0]
				$scope.contact.thumbnail = result[1]
			, () ->
				$log.info('Modal dismissed')

		$scope.reload()
]
.controller 'NewContactCtrl', ['$scope', '$http', '$log', 'Restangular', '$upload', '$modal', '$location', '$rootScope',
	($scope, $http, $log, Restangular, $upload, $modal, $location, $rootScope) ->
		$scope.backUrl = "#/contact"
		$scope.contact =
			info: {}
			avatar: "./img/default_avatar.png"
			links: []
			comments: []
		$scope.title = "新建联系人"
		$scope.showToolbar = false
		$scope.showRefresh = false
		$scope.newLink =
			type: "Supplier"
			name: ""


		$scope.changeType = (type) ->
			$scope.newLink.type = type

		$scope.addLink = () ->
			$scope.newLink.modifiedDate = new Date()
			$scope.contact.links.push $scope.newLink
			# $http.post('/someUrl',$scope.newLink).success()
			$scope.newLink =
				type: "Supplier"
				name: ""

		$scope.onAvatarClick = ->
			modalInstance = $modal.open({
				templateUrl: 'views/imageprocess.html',
				controller: "ImgProcessCtrl"})

			modalInstance.result.then (result) ->
				$scope.contact.avatar = result[0]
				$scope.contact.thumbnail = result[1]

			, () ->
				$log.info('Modal dismissed')

		$scope.save = () ->
			# $scope.contact.create()
			$scope.progressBar.start()
			$scope.progressBar.set(20)

			# update data
			$scope.contactData.createdBy = 'Cage'
			$scope.contactData.modifiedBy = 'Cage' # Todo: auto generate in DB
			# post
			$scope.contact.createdBy = 'Cage'
			$scope.contact.modifiedBy = 'Cage'
			$scope.contact.name = $scope.title
			Restangular.all('contacts').post($scope.contact).then (contact)->
				$scope.contactData.contact = contact.id
				Restangular.one('contacts', contact.id)
				.all('contactdata').post($scope.contactData).then (contactData)->
					console.log contactData
					$location.url("/contact/#{contact.id}")
					$scope.progressBar.end()


]
