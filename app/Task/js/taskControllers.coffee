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
				$scope.newTask = {}
				$scope.progressBar.end()
			, (reason)->
				utils.HttpHandle(reason)
				$scope.progressBar.end()
			, null

	$scope.beginEditing = (task)->
		$scope.isNewTaskPanelShow = false
		if $scope.currentEditingTask?
			$scope.currentEditingTask.editing  = false
		$scope.currentEditingTask = task
		$scope.currentEditingTask.editing = true
		if task.due?
			task.dueDate = moment(task.due)._d
	$scope.open = ($event, task) ->
		$event.preventDefault()
		$event.stopPropagation()
		task.opened = true

	$scope.dateOptions =
		formatYear: 'yy'
		startingDay: 1

	$scope.openMore = ($event,task)->
		$event.preventDefault()
		$event.stopPropagation()

	$scope.confirmEdit = (task)->
		task.editing = false
		if task.dueDate?
			task.due = moment(task.dueDate).format 'YYYY-MM-DD'
		task.put()
	$scope.cancelEdit = (task)->
		task.get().then (oldTask)->
			angular.extend task, oldTask
	$scope.changeStatus = ($event, task)->
		task.status = if task.status is 'closed' then 'open' else 'closed'
		task.put()
		$event.preventDefault()
		$event.stopPropagation()
]