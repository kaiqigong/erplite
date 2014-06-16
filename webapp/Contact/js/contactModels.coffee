angular.module 'contactModule'
.factory 'ModelBase', ['$http', ($http) ->
	class ModelBase

		constructor: (modelBase,postUrl) ->
			if postUrl?
				this.postUrl = postUrl
			if modelBase?
				this.setData modelBase

		setData: (modelBase)->
			angular.extend this,modelBase

		fromId: (id,success,fail)->
			if this.postUrl?
				$http.get this.postUrl + id
				.success (modelBase)->
					if not modelBase.url?
						modelBase.url = this.postUrl + id;
					this.setData modelBase
					success modelBase
				.error fail
			else throw new Error "PostUrl not defined!"

		fromUrl: (success,fail)->
			$http.get this.url
			.success success
			.error fail

		create: (success,fail) ->
			$http.post this.postUrl, this
			.success success
			.error fail

		delete: (success,fail) ->
			$http.delete this.url
			.success success
			.error fail

		update: (success,fail) ->
			$http.put this.url, this
			.success success
			.error fail
]
.factory 'Contact', ['$rootScope','ModelBase', ($rootScope,ModelBase) ->
	class Contact extends ModelBase

		constructor: (contact) ->
			ModelBase.call this, contact, $rootScope.apimap.contact
]
.factory 'ContactData', ['$rootScope','ModelBase', ($rootScope,ModelBase) ->
	class ContactData extends ModelBase

		constructor: (contactData) ->
			ModelBase.call this, contactData, $rootScope.apimap.contactdata
]
.factory 'ContactLink', ['$rootScope','ModelBase', ($rootScope,ModelBase) ->
	class ContactLink extends ModelBase

		constructor: (contactLink) ->
			ModelBase.call this, contactLink, $rootScope.apimap.contactlink
]
.factory 'ContactTag', ['$rootScope','ModelBase', ($rootScope,ModelBase) ->
	class ContactTag extends ModelBase

		constructor: (contactTag) ->
			ModelBase.call this, contactTag, $rootScope.apimap.contacttag
]
.factory 'ContactComment', ['$rootScope','ModelBase', ($rootScope,ModelBase) ->
	class ContactComment extends ModelBase

		constructor: (contactComment) ->
			ModelBase.call this, contactComment, $rootScope.apimap.contactcomment
]
.factory 'ContactAttachment', ['$rootScope','ModelBase', ($rootScope,ModelBase) ->
	class ContactAttachment extends ModelBase

		constructor: (contactAttachment) ->
			ModelBase.call this, contactAttachment, $rootScope.apimap.contactattachment
]
.factory 'Contact.Models', ['Contact','ContactData','ContactLink', ()->
	Contact:Contact
	ContactData:ContactData
	ContactLink:ContactLink
]
