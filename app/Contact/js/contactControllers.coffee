angular.module 'contactModule'
.controller 'ContactListCtrl', ['$scope', '$http', '$location', 'contactManager', '$log', 'ModelBase','Restangular','$rootScope',($scope, $http, $location, contactManager, $log, ModelBase,Restangular,$rootScope) ->
	$scope.title = "联系人"
	$scope.icon = "./img/128px/layers_128px.png"
	$scope.backUrl = "#/home"
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
			return item.name.indexOf(query)  >= 0 or item.description.indexOf(query) >= 0

	$scope.progressBar.start()
	$scope.progressBar.set 50
	promise = contactManager.loadContactList()

	promise.then (contacts) ->
		$scope.items = contacts
		$log.log(contacts)
		$scope.progressBar.end()
	, (reason)->
		$scope.progressBar.end()
		if reason.status is 404
			$rootScope.$broadcast 'errorHappened', reason.status, $location.url()
		else if reason.status is 401 or reason.status is 403
			$location.url "/login?query=" + encodeURIComponent($location.url())
			$location.replace()
		else
			$log.log("Error Code: " + reason.status + ", Message: " + reason.data)
	, null

]
.controller 'ContactDetailCtrl', ['$scope', '$http', '$q', '$routeParams', 'contactManager', '$location', '$log', 'ModelBase','Restangular', '$upload', '$modal','$rootScope', ($scope, $http, $q, $routeParams, contactManager, $location, $log, ModelBase,Restangular,$upload,$modal,$rootScope) ->
	$scope.progressBar.start()
	$scope.progressBar.set 50
	$scope.backUrl = "#/contact"
	$scope.contact = null
	$scope.showToolbar = true
	$scope.showRefresh = true
	$scope.newLink =
		type: "Supplier"
		name: ""
	# used to bind the data fields to view
	$scope.contactDatas=[]

	# vaild data fields
	dataFields=[]

	# unset data fields
	$scope.unsetFields=[]

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
		$log.log($scope.contact)
		promises = []
		$scope.progressBar.start()
		$scope.progressBar.set(20)

		# update data
		if not $scope.contact.data?
			$scope.contact.dataObj = {}
			$scope.contact.dataObj.createdBy = 'Cage'
			$scope.contact.dataObj.modifiedBy = 'Cage' # Todo: auto generate in DB
		for contactData in $scope.contactDatas when contactData.key in ['surname', 'givenname', 'company', 'department', 'title', 'phone', 'mobile', 'fax', 'origin', 'email', 'address', 'birthday', 'region', 'website', 'qq', 'weibo', 'im' ]
			do (contactData) ->
				$scope.contact.dataObj[contactData.key] = contactData.value
		if not $scope.contact.data?
			#post
			$scope.contact.dataObj.contact = $scope.contact.id
			promises.push (Restangular.all("ContactData").post($scope.contact.dataObj).then (contactdata)->
				console.log contactdata
			)
		else
			promises.push $scope.contact.dataObj.put()
			promises.push $scope.contact.put()

		# should reload after all the data updated.
		$q.all promises
		.then $scope.reload

	$scope.reload = () ->
		promise = contactManager.loadContact $routeParams.id
		promise.then (contact) ->
			$scope.contact = contact
			$scope.contactDatas = []
			$scope.unsetFields = []
			dataFields = []
			for own propName, propValue of contact.dataObj when propName in ['surname', 'givenname', 'company', 'department', 'title', 'phone', 'mobile', 'fax', 'origin', 'email', 'address', 'birthday', 'region', 'website', 'qq', 'weibo', 'im' ]
				dataFields.push propName
				if propValue? and propValue isnt ""
					$scope.contactDatas.push {key:propName,value:propValue}
				else
					$scope.unsetFields.push propName
			if not contact.dataObj
				$scope.unsetFields = ['surname', 'givenname', 'company', 'department', 'title', 'phone', 'mobile', 'fax', 'origin', 'email', 'address', 'birthday', 'region', 'website', 'qq', 'weibo', 'im' ]
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

	$scope.onAvatorClick = ->
		modalInstance = $modal.open({
			templateUrl: '../app/views/imageprocess.html',
			controller: "ImgProcessCtrl"})

		modalInstance.result.then (avatorUrl) ->
			$scope.contact.avator = avatorUrl
		, () ->
			$log.info('Modal dismissed')

	$scope.reload()
]
.controller 'NewContactCtrl', ['$scope', '$http', '$log', 'Restangular','$upload', '$modal', '$location','$rootScope', ($scope, $http, $log,Restangular,$upload,$modal, $location,$rootScope) ->
	$scope.backUrl = "#/contact"
	$scope.contact =
		info: {}
		avator: "./img/default_avatar.png"
		links: []
		comments: []
	$scope.title = "新建联系人"
	$scope.showToolbar = false
	$scope.showRefresh = false
	$scope.newLink =
		type: "Supplier"
		name: ""

	$scope.contactDatas=[]

	# vaild data fields
	dataFields=[]

	# unset data fields
	$scope.unsetFields = ['surname', 'givenname', 'company', 'department', 'title', 'phone', 'mobile', 'fax', 'origin', 'email', 'address', 'birthday', 'region', 'website', 'qq', 'weibo', 'im' ]

	$scope.changeType = (type) ->
		$scope.newLink.type = type

	$scope.addLink = () ->
		$scope.newLink.modifiedDate = new Date()
		$scope.contact.links.push $scope.newLink
		# $http.post('/someUrl',$scope.newLink).success()
		$scope.newLink =
			type: "Supplier"
			name: ""

	$scope.addData = () ->
		newData = angular.copy $scope.newData
		$scope.newData.key = ""
		$scope.newData.value = ""
		$scope.contactDatas.push newData

	$scope.onAvatorClick = ->
		modalInstance = $modal.open({
			templateUrl: '../app/views/imageprocess.html',
			controller: "ImgProcessCtrl"})

		modalInstance.result.then (avatorUrl) ->
			$scope.contact.avator = avatorUrl
		, () ->
			$log.info('Modal dismissed')

	$scope.save = () ->
		# $scope.contact.create()
		$log.log $scope.contact
		$scope.progressBar.start()
		$scope.progressBar.set(20)

		# update data
		$scope.contact.dataObj = {}
		$scope.contact.dataObj.createdBy = 'Cage'
		$scope.contact.dataObj.modifiedBy = 'Cage' # Todo: auto generate in DB
		for contactData in $scope.contactDatas when contactData.key in ['surname', 'givenname', 'company', 'department', 'title', 'phone', 'mobile', 'fax', 'origin', 'email', 'address', 'birthday', 'region', 'website', 'qq', 'weibo', 'im' ]
			do (contactData) ->
				$scope.contact.dataObj[contactData.key] = contactData.value
		# post
		$scope.contact.dataObj.contact = $scope.contact.id
		$scope.contact.createdBy = 'Cage'
		$scope.contact.modifiedBy = 'Cage'
		$scope.contact.name=$scope.title
		Restangular.all('contacts').post($scope.contact).then (contact)->
			$scope.contact.dataObj.contact = contact.id
			Restangular.one('contacts',contact.id).all('contactdata').post($scope.contact.dataObj).then (contactData)->
				console.log contactData
				$location.url("/contact/#{contact.id}")
				$scope.progressBar.end()


]
