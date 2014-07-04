erpDirectives = angular.module 'erpDirectives', []

erpDirectives.directive 'erpImgLoading', ($document) ->
	restrict: 'A',
	link: ($scope, $element, $attrs) ->
		$element.addClass "beforeLoaded"
		$element.on 'load', (event) ->
			$element.removeClass "beforeLoaded"
			$element.addClass "afterLoaded"

.directive 'avatarCrop', ['$q', ($q)->
	restrict: 'AE'
	templateUrl: 'views/avatarCropTpl.html'

	scope: { rawUrl: '@', imgCropped: '&'}
	link: ($scope, $element)->
		$scope.imgsrcStyle = {top: '0', left: '0'}
		originalSize = {}
		$scope.$watch 'rawUrl', (value)->
			if value
				deffer = $q.defer()
				$element.find('.imgsrc').on 'load', (event)->
					deffer.resolve event
				deffer.promise.then (event)->
					originalSize.width = event.target.naturalWidth
					originalSize.height = event.target.naturalHeight
					if event.target.naturalHeight > event.target.naturalWidth
						$scope.imgsrcStyle.width = '200px'
						ratio = 200.0 / event.target.naturalWidth
						$scope.imgsrcStyle.height = event.target.naturalHeight * ratio
						$scope.ratio = ratio
						$scope.ratioMin = ratio
						$scope.ratioMax = 10 * ratio
					else
						$scope.imgsrcStyle.height = '200px'
						ratio = 200.0 / event.target.naturalHeight
						$scope.imgsrcStyle.width = event.target.naturalWidth * ratio
						$scope.ratio = ratio
						$scope.ratioMin = ratio
						$scope.ratioMax = 10 * ratio

		currentY = 0
		currentX = 0
		canDrag = false
		$scope.mousedownOnOverlay = (e)->
			e.preventDefault()
			currentY = e.clientY
			currentX = e.clientX
			canDrag = true

		$scope.mousemoveOnOverlay = (e)->
			if canDrag
				if (e.clientY - currentY + parseInt($scope.imgsrcStyle.top,
					10)) <= 60 && (e.clientY - currentY + parseInt($scope.imgsrcStyle.top,
					10)) >= 260 - parseInt($scope.imgsrcStyle.height, 10)
					$scope.imgsrcStyle.top = (e.clientY - currentY + parseInt($scope.imgsrcStyle.top, 10)) + 'px'

				if (e.clientX - currentX + parseInt($scope.imgsrcStyle.left,
					10)) <= 60 && (e.clientX - currentX + parseInt($scope.imgsrcStyle.left,
					10)) >= 260 - parseInt($scope.imgsrcStyle.width, 10)
					$scope.imgsrcStyle.left = (e.clientX - currentX + parseInt($scope.imgsrcStyle.left, 10)) + 'px'

				currentY = e.clientY
				currentX = e.clientX
				return false
			else
				return false

		$scope.mouseupOnOverlay = ()->
			generateResult()
			canDrag = false

		$scope.$watch 'ratio', (value)->
			if value
				$scope.imgsrcStyle.height = originalSize.height * value + 'px'
				$scope.imgsrcStyle.width = originalSize.width * value + 'px'
				$scope.imgsrcStyle.top = -(parseInt($scope.imgsrcStyle.height, 10) - 320) / 2 + 'px'
				$scope.imgsrcStyle.left = -(parseInt($scope.imgsrcStyle.width, 10) - 320) / 2 + 'px'
				generateResult()

		generateResult = ()->
			$scope.imgCropped({cropInfo:
				originalSize: originalSize
				result:
					ratio: $scope.ratio
					offset:
						x: 60 - parseInt($scope.imgsrcStyle.left,10)
						y: 60 - parseInt($scope.imgsrcStyle.top,10)
					cropSize:
						width: 200
						height: 200
			})

]