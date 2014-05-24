angular.module 'taskModule'
.controller 'TaskListCtrl', ['$scope', '$rootScope', '$http', '$log', 'Restangular', 'erplite.utils',
($scope, $rootScope, $http, $log, Restangular, utils)->
	$scope.title = "任务"
	$scope.backUrl = "#/home"
	$scope.addUrl = '#/task/new'
	$scope.isAdvanceSearchCollapsed = true
	$scope.toggleAdvanceSearch = ->
		if $scope.isAdvanceSearchCollapsed
			$scope.isAdvanceSearchCollapsed = false
			# init filters
		else
			$scope.isAdvanceSearchCollapsed = true
	# clear filter

	$scope.currentPage = 1

	$scope.calendarHeight = 220
	$scope.newTask = {}
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

	$scope.dayClick = (date, jsevent, cordinator)->
		console.log date
		$scope.newTask.due = date.day.format 'YYYY-MM-DD'
		$scope.newTaskDueStr = date.day.format 'YYYY-MM-DD'
		$scope.isCalOpen = false

	validate = (task)->
		return true

	$scope.confirmAdd = (newTask)->
		$scope.progressBar.start()
		newTask.createdBy = 'admin'
		newTask.modifiedBy = 'admin'
		newTask.owner = 'admin' unless newTask.owner
		if validate(newTask)
			$scope.tasks.post(newTask).then (data)->
				$scope.tasks.push data
			, (reason)->
				utils.HttpHandle(reason)
				$scope.progressBar.end()
			, ()->
			$scope.progressBar.end()

]