erpDirectives = angular.module 'erpDirectives', []

erpDirectives.directive 'erpImgLoading', ($document) ->
	restrict: 'A',
	link: ($scope, $element, $attrs) ->
		$element.addClass "beforeLoaded"
		$element.on 'load', (event) ->
			$element.removeClass "beforeLoaded"
			$element.addClass "afterLoaded"
