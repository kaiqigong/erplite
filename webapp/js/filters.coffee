erpFilters = angular.module 'erpFilters', []

erpFilters.filter 'zero2display', () ->
	(input) ->
		if input == 0 then 'none' else 'visible'

erpFilters.filter 'boolean2display', () ->
	(input) ->
		if input then 'visible' else 'none'

erpFilters.filter 'type2class', () ->
	(input) ->
		result = null
		switch input
			when "Supplier"
				result = "glyphicon glyphicon-barcode"
			when "Task"
				result = "glyphicon glyphicon-pushpin"
			else
				result = "glyphicon glyphicon-link"
		result

.filter 'sign7nUrl',['$http','erpSettings',($http, erpSettings) ->
	data = null
	serviceInvoked = false
	(input) ->
		if data is null
			if !serviceInvoked
				serviceInvoked = true
				$http.get(erpSettings.apiHost + '/files/getSignedUrl/' + '?base_url=' + input)
				.success (signedUrl)->
					data = signedUrl
			return input
		else
			return data
]
