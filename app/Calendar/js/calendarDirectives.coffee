angular.module 'calendarModule'
.constant 'coolCalendarConfig', {
	useIsoweek: true
	height: 360
	dayNames: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
	templateUrl: 'Calendar/views/calendarTpl.html'
}
.factory 'weeksOfMonth', ['coolCalendarConfig', (coolCalendarConfig) ->
	return (date) ->
		selectedDay = moment(date)
		monthFirstDate = angular.copy(selectedDay).startOf('month')
		monthLastDate = angular.copy(selectedDay).endOf('month')
		if coolCalendarConfig.useIsoweek
			calendarMonthFirstDate = angular.copy(monthFirstDate).startOf('isoWeek')
			calendarMonthLastDate = angular.copy(monthLastDate).endOf('isoWeek')
		else
			calendarMonthFirstDate = angular.copy(monthFirstDate).startOf('week')
			calendarMonthLastDate = angular.copy(monthLastDate).endOf('week')

		calendarMonthDates = angular.copy(calendarMonthFirstDate).twix(calendarMonthLastDate).count("days")
		calendarMonthWeeks = calendarMonthDates / 7
		weeks = []
		dateIndex = angular.copy(calendarMonthFirstDate)
		for i in [0..(calendarMonthWeeks - 1)]
			week = []
			for j in [0..6]
				weekDay = {}
				day = angular.copy(dateIndex)
				dateIndex.add('days', 1)
				weekDay.day = day
				weekDay.isInCurrentMonth = if day.month() is selectedDay.month() then true else false
				weekDay.isToday = if day.isSame(moment(), 'day') then true else false
				week.push weekDay
			weeks.push week
		return weeks
]
.factory 'eventsOfDay', [()->
	return (currentMoment, eventSource)->
		events = []
		if eventSource?
			for event in eventSource
				if moment(event.start).isSame(currentMoment, 'day')
					events.push event
		return events
]
.factory 'bindEvents', ['eventsOfDay', (eventsOfDay)->
	return (eventSource, weeks)->
		for week in weeks
			for day in week
				day.events = eventsOfDay(day.day, eventSource)
				day.hasEvents = if day.events.length > 0 then true else false
]
.factory 'findDayInWeeks', [()->
	return (date, weeks)->
		for week in weeks
			for day in week
				if day.day.isSame(date)
					return day
]
.directive 'coolCalendar', ['$log', 'coolCalendarConfig', 'weeksOfMonth', 'eventsOfDay', 'bindEvents', 'findDayInWeeks',
	($log, coolCalendarConfig, weeksOfMonth, eventsOfDay, bindEvents, findDayInWeeks)->
		restrict: 'EA'
		replace: true
		templateUrl: coolCalendarConfig.templateUrl
		scope:
			'height': '=calendarHeight'
			'eventSource': '=eventSource'
			'selectedDay': '=selectedDay'
			'dayClickHandler': '=dayClick'
		link: ($scope,$element)->
			#config useIsoweek and dayNames, change this config in app.config
			$scope.coolCalendarConfig = coolCalendarConfig
			if $scope.coolCalendarConfig.useIsoweek
				$scope.dayNames = angular.copy($scope.coolCalendarConfig.dayNames)
			else
				$scope.dayNames = angular.copy($scope.coolCalendarConfig.dayNames)
				sunday = $scope.dayNames.pop()
				$scope.dayNames.unshift(sunday)

			# watch height
			$scope.height = $scope.coolCalendarConfig.height;
			$scope.calendarStyle = {"height": $scope.height + "px"}
			$scope.rowStyle = {"height": ($scope.height - 60) / 5 + "px"}

			$scope.$watch 'height', (newValue, oldValue)->
				if newValue? and newValue isnt oldValue
					$scope.calendarStyle = {"height": newValue + "px"}
					$scope.rowStyle = {"height": (newValue - 60) / 5 + "px"}

			handles = []

			# watch selectedDay, change weeks and re-bind events
			$scope.selectedDay = moment()._d
			$scope.weeks = weeksOfMonth($scope.selectedDay)

			$scope.$watch 'selectedDay', (newValue, oldValue)->
				if newValue? and newValue isnt oldValue
					$scope.weeks = weeksOfMonth(newValue)
					bindEvents($scope.eventSource, $scope.weeks)
					for handle in handles
						handle()
					handles = []

			# bind event source, and watch eventSource, when the eventSource changes, re-bind
			bindEvents($scope.eventSource, $scope.weeks)
			$scope.$watchCollection 'eventSource', (newValue, oldValue)->
				if newValue? and newValue isnt oldValue
					bindEvents($scope.eventSource, $scope.weeks)


			lastChosen = {}
			#day click event
			$scope.dayClick = (weekDay, $event)->
				if not weekDay.isInCurrentMonth
					$scope.selectedDay = moment($scope.selectedDay).year(weekDay.day.year()).month(weekDay.day.month())._d
					handles.push ()->
						weekDay = findDayInWeeks(weekDay.day, $scope.weeks)
						lastChosen.isChosen = false
						weekDay.isChosen = true
						lastChosen = weekDay
						if $scope.dayClickHandler?
							#calculate cordinate
							cordinate = {}
							y=0
							for week in $scope.weeks
								y++
								x = 0
								for day in week
									x++
									if day.day.isSame(weekDay.day)
										cordinate.x = x
										cordinate.y = y
										break;
							cordinate.cellHeight = ($scope.height - 60) / 5
							cordinate.cellWidth = $element.find(".weekday")[0].clientWidth
							$scope.dayClickHandler(weekDay, $event, cordinate)
					return
				lastChosen.isChosen = false
				weekDay.isChosen = true
				lastChosen = weekDay
				if $scope.dayClickHandler?
					#calculate cordinate
					cordinate = {}
					y=0
					for week in $scope.weeks
						y++
						x = 0
						for day in week
							x++
							if day.day.isSame(weekDay.day)
								cordinate.x = x
								cordinate.y = y
								break;

					cordinate.cellHeight = ($scope.height - 60) / 5
					cordinate.cellWidth = $element.find(".weekday")[0].clientWidth
					$scope.dayClickHandler(weekDay, $event, cordinate)

			#PREV click
			$scope.prevClick = ()->
				$scope.selectedDay = moment($scope.selectedDay).add('months', -1)._d


			#NEXT click
			$scope.nextClick = ()->
				$scope.selectedDay = moment($scope.selectedDay).add('months', 1)._d

]