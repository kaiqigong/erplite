angular.module 'contactModule'
.controller 'ContactListCtrl', ['$scope', '$http', 'contactManager', '$log', 'ModelBase',($scope, $http, contactManager, $log, ModelBase) ->
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
	, (data, status)->
		$scope.progressBar.end()
		if status == "404"
			$rootScope.$broadcast 'errorHappened', status, $location.url()
		else if status == "401"
			$location.url "/login"
		else 
			$log.log("Error Code: " + status + ", Message: " + data)
	, null
]
.controller 'ContactDetailCtrl', ['$scope', '$http', '$q', '$routeParams', 'contactManager', '$location', '$log', 'ModelBase', ($scope, $http, $q, $routeParams, contactManager, $location, $log, ModelBase) ->
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
		updatedContactDataDeffered = $q.defer()
		promises.push updatedContactDataDeffered
		updatedContactData = contactManager.initContactData()
		updatedContactData.url = $scope.contact.data.url
		updatedContactData.contact = $scope.contact.data.contact
		updatedContactData.createdBy = $scope.contact.data.createdBy
		updatedContactData.modifiedBy = 'cage' # TODO hard code
		for contactData in $scope.contactDatas when contactData.key in ['surname', 'givenname', 'company', 'department', 'title', 'phone', 'mobile', 'fax', 'origin', 'email', 'address', 'birthday', 'region', 'website', 'qq', 'weibo', 'im' ]
			do (contactData) ->
				updatedContactData[contactData.key] = contactData.value

		updatedContactData.update (data) ->
			updatedContactDataDeffered.resolve data
		, (error) ->
			updatedContactDataDeffered.reject error

		# prepare description and updata contact
		newContact = new ModelBase()
		newContact.url = $scope.contact.url
		newContact.avator = $scope.contact.avator
		newContact.name = $scope.contact.name
		newContact.createdBy = $scope.contact.createdBy
		newContact.modifiedBy = 'cage'
		newContact.description = $scope.contact.description

		newContactDeffered = $q.defer()
		promises.push newContactDeffered
		newContact.update (data) ->
		    newContactDeffered.resolve data
		, (error) ->
			newContactDeffered.reject()

		# should reload after all the data updated.
		$q.all promises 
		.then $scope.reload

	$scope.reload = () ->
		promise = contactManager.loadContact $routeParams.id
		promise.then (contactData) ->
			$scope.contact = contactData
			$scope.contactDatas = []
			$scope.unsetFields = []
			dataFields = []
			for own propName, propValue of contactData.data when propName not in ["id","contactname","contact","url","createdDate","createdBy","modifiedDate","modifiedBy"]
				dataFields.push propName
				if propValue? and propValue isnt ""
					$scope.contactDatas.push {key:propName,value:propValue}
				else
					$scope.unsetFields.push propName
			$scope.title = contactData.name
			$scope.progressBar.end()
		, (error, status) ->
			$scope.progressBar.end()
			if status == "404"
				$rootScope.$broadcast 'errorHappened', status, $location.url()
			else if status == "401"
				$location.url "/login"
			else 
				$log.log "Error Code: " + status + ", Message: " + error
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

	$scope.reload()

]
.controller 'NewContactCtrl', ['$scope', '$http', '$log', ($scope, $http, $log) ->
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
	$scope.changeType = (type) ->
		$scope.newLink.type = type

	$scope.addLink = () ->
		$scope.newLink.modifiedDate = new Date()
		$scope.contact.links.push $scope.newLink
		# $http.post('/someUrl',$scope.newLink).success()
		$scope.newLink = 
			type: "Supplier"
			name: ""

	$scope.save = () ->
		# $scope.contact.create()
		$log.log $scope.contact
]