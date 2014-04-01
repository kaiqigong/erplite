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
