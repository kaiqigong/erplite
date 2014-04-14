angular.module 'contactModule' 
.factory 'contactManager', ['$http', '$q', 'Contact','ContactData','erpSettings','$log','$rootScope', 'Restangular',
($http, $q, Contact, ContactData, erpSettings,$log,$rootScope,Restangular) ->
	_pool: {}
	_syncTimeDict:{}
	_contactList:[]
	_retrieveInstance: (id, data) ->
		instance = this._pool[id]
		if instance?
			instance.setData(data)
		else
			instance = new Contact data
			this._pool[id] = instance
			this._syncTimeDict[id] = new Date()
		return instance
	_search: (id) ->
		return this._pool[id]
	_load: (id, deferred) ->
		scope = this
		$http.get $rootScope.apimap.contact + id 
		.success (data) ->
			contact = new Contact data
			# better resolve url in contactdetail
			contact.url = $rootScope.apimap.contact + id
			if contact.data?
				contactDataUrl = contact.data
				$http.get contactDataUrl
					.success (contactData)->
						contact.data = contactData
						contact.data.url = contactDataUrl
						deferred.resolve contact
					.error (data,status) ->
						deferred.reject {"data":data,"status":status}
			else 
				deferred.resolve contact
		.error (data,status) ->
			deferred.reject {"data":data,"status":status}
		return

	# Public Methods
	# Use this function in order to get a contact instance by it's id 
	loadContact : (id) ->
		deferred = $q.defer()
		this._load id, deferred
		return deferred.promise
	
	loadContactList: ->
		deferred = $q.defer()
		Restangular.all('contacts').getList()
		.then (data) ->
			deferred.resolve data
			this._contactList = data
		, (response)->
			console.log response
			deferred.reject response
		return deferred.promise
	
	getPreviousContact : (id)->
		if _contactList?
			for index in [0.._contactList.length-1]
				if _contactList[index].id == id
					if index==0
						# should not happen, if happens, just tell the controller that no more previous item. by event?
						return id
					else
						return _contactList[index-1].id
					break
		# should not go to here.
		return id

	getNextContact : (id) ->
		if _contactList?
			for index in [0.._contactList.length-1]
				if _contactList[index].id == id
					if index==_contactList.length-1
						return id
					else
						return _contactList[index+1].id
					break
		# should not go to here.
		return id

	getContact: (id) ->
		deferred = $q.defer()
		contact = this._search id
		if contact?
			deferred.resolve contact
		else 
			this._load id, deferred
		return deferred.promise

	initContactData: (contactData) ->
		new ContactData contactData

	# Use this function in order to get instances of all the contacts
	loadAllContact: () ->
		deferred = $q.defer()
		scope = this
		$http.get $rootScope.apimap.contact
		.success (contactsArray) ->
			contacts = []
			contactsArray.forEach (contactData) ->
				# todo: remove this code
				if contactData.id?
				else
					contactData.id =contacts.length+1
					contact = scope._retrieveInstance contactData.id, contactData
					contacts.push contact
			deferred.resolve contacts

		.error (data,status) ->
			deferred.reject {"data":data,"status":status}
		
		return deferred.promise

	# This function is useful when we got somehow the contact data and we wish to store it or update the pool and get a contact instance in return
	setContact: (contactData) ->
		scope = this
		contact = this._search contactData.id
		if contact?
			contact.setData contactData
		else
			contact = scope._retrieveInstance contactData
		return contact
]