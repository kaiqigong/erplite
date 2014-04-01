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
			return item.name.indexOf query  >= 0 or item.description.indexOf(query) >= 0
	
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
		$scope.newData.createdBy = "cage"
		$scope.newData.modifiedBy = "cage"
		$scope.newData.contact = $scope.contact.id
		newData = contactManager.initContactData $scope.newData
		$scope.contact.data.push newData

	$scope.save = () ->
		$log.log($scope.contact)
		promises = []
		$scope.progressBar.start()
		$scope.progressBar.set(20)
		# update data
		$scope.contact.data.forEach (contactData) ->
			deffered = $q.defer()
			promises.push deffered
			if not contactData.url?
				if not contactData.valuePair?
					# will not create, maybe the user decides not to add this field.
				else
					contactData.create (data) ->
						deffered.resolve data
					, (error) ->
						deffered.reject()
			else if not contactData.valuePair?
				# delete
				contactData.delete (data) ->
					deffered.resolve data
				, (error) ->
					deffered.reject()
			else
				contactData.update (data) ->
					deffered.resolve data
				, (error) ->
					deffered.reject()

		# prepare description and updata contact
		newContact = new ModelBase()
		newContact.url = $scope.contact.url
		newContact.avator = $scope.contact.avator
		newContact.name = $scope.contact.name
		newContact.createdBy = $scope.contact.createdBy
		newContact.modifiedBy = 'cage'
		newContact.description = ""
		$scope.contact.data.forEach (contactData) ->
		    # any description generation logic.
		    if contactData.keyPair == 'description' or contactData.keyPair == '描述'
		        newContact.description = contactData.valuePair

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