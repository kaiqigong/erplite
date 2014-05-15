angular.module 'taskModule'
.controller 'TaskListCtrl', ['$scope', '$rootScope', '$http', '$log', 'Restangular', 'erplite.utils',
($scope, $rootScope, $http, $log, Restangular, utils)->
	$scope.title = "任务"
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

	$scope.progressBar.start()
	$scope.progressBar.set 50
	Restangular.all('tasks').getList().then (tasks)->
		$scope.tasks = tasks
		$scope.progressBar.end()
	, (reason)->
		utils.HttpHandle(reason)
		$scope.progressBar.end()
	, ()->
		$scope.progressBar.end()
]