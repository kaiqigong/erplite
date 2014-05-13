angular.module 'calendarModule'
.controller 'CalendarCtrl', ['$scope', '$log', ($scope, $log)->
	$scope.title = "Calendar"

	events = [
		{title: "event1", start: new Date(), end: new Date(), allDay: false}
		{title: "event1", start: new Date(), end: new Date(), allDay: false}
		{title: "event1", start: new Date(), end: new Date(), allDay: false}
		{title: "event1", start: new Date(), end: new Date(), allDay: false}
		{title: "event1", start: new Date(), end: new Date(), allDay: false}
	]
	$scope.eventSource = [events]
	$scope.dayClick = (date, dayEvents, jsEvent)->
		$scope.dayEvents = dayEvents
		$log.log jsEvent
		$log.log date
	$scope.dayHover = (date, dayEvents, jsEvent)->
		$scope.dayEvents = dayEvents
		$log.log jsEvent
		$log.log date

	$scope.removeEvent = (event)->
		if events.indexOf(event) > -1
			events.slice(events.indexOf(event), 0)

	$scope.addEvent = (title, start, end)->
		events.push
			start: start
			end: end
			title: title
			allDay: false # decided by start and end

]