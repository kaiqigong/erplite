angular.module 'calendarModule'
.controller 'CalendarCtrl', ['$scope', '$log', ($scope, $log)->
	$scope.title = "Calendar"
	events = [
		{title: "event1", start: moment()._d, end: new Date(), allDay: false}
		{title: "event1", start: moment().add("days", 3)._d, end: new Date(), allDay: false}
		{title: "event1", start: moment().add("days", -3)._d, end: new Date(), allDay: false}
		{title: "event1", start: moment().add("weeks", 1)._d, end: new Date(), allDay: false}
		{title: "event1", start: moment().add("weeks", -1)._d, end: new Date(), allDay: false}
	]
	$scope.eventSource = events
	$scope.dayClick = (date,jsEvent)->
		$log.log date


	$scope.dayHover = (date, dayEvents, jsEvent)->
		$scope.dayEvents = dayEvents
		$log.log jsEvent
		$log.log date

	$scope.selectedDay = new Date()
	$scope.calendarHeight = 350

	$scope.changeHeight = ()->
		$scope.calendarHeight = 800 - $scope.calendarHeight


	$scope.changeDate = ()->
		$scope.selectedDay = moment($scope.selectedDay).add('months', 1)._d

	$scope.removeEvent = (event)->
		if events.indexOf(event) > -1
			events.splice(events.indexOf(event), 1)

	$scope.addEvent = ()->
		events.push {title: "event1", start: moment().add("days", 5)._d, end: new Date(), allDay: false}
	# decided by start and end

]