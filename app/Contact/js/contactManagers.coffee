angular.module 'contactModule' 
.factory 'contactManager', ['$http', '$q', 'Contact','ContactData','erpSettings','$log','$rootScope', 
($http, $q, Contact, ContactData, erpSettings,$log,$rootScope) ->
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
			contact.url = $rootScope.apimap.contact + id
			contact.data = []
			contactDataUrls = data.data
			
			for contactDataUrl in contactDataUrls
				do (contactDataUrl)->
					$http.get contactDataUrl
					.success (contactData)->
						contactData.url = contactDataUrl
						contact.data.push new ContactData contactData 

			deferred.resolve contact

		.error (data,status) ->
			deferred.reject data,status
		return

	# Public Methods
	# Use this function in order to get a contact instance by it's id 
	loadContact : (id) ->
		deferred = $q.defer()
		this._load id, deferred
		return deferred.promise
	
	loadContactList: ->
		deferred = $q.defer()
		$http.get $rootScope.apimap.contact
		.success (data,status) ->
			deferred.resolve data
			this._contactList = data
			
		.error (data,status) ->
			deferred.reject data,status
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
			deferred.reject data,status
		
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