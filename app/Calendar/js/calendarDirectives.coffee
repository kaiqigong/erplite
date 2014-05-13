angular.module 'calendarModule'
.constant 'coolCalendarConfig', {
	useIsoweek: true
	height:360
	dayNames: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
	templateUrl : 'Calendar/views/calendarTpl.html'
}
.factory 'weeksOfMonth', ['coolCalendarConfig',(coolCalendarConfig) ->
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
.directive 'coolCalendar',['$log', 'coolCalendarConfig','weeksOfMonth',($log, coolCalendarConfig,weeksOfMonth)->
	restrict: 'EA'
	replace: true
	templateUrl: coolCalendarConfig.templateUrl
	scope: true
	link: ($scope, $element, $attrs)->
		#TODO: config useIsoweek and dayNames
		$scope.coolCalendarConfig = coolCalendarConfig
		if $scope.coolCalendarConfig.useIsoweek
			$scope.dayNames = angular.copy($scope.coolCalendarConfig.dayNames)
		else
			$scope.dayNames = angular.copy($scope.coolCalendarConfig.dayNames)
			sunday = $scope.dayNames.pop()
			$scope.dayNames.unshift(sunday)

		#TODO: watch height
		$scope.height = $scope.coolCalendarConfig.height;
		$scope.calendarStyle = {"height": $scope.height + "px"}
		$scope.rowStyle = {"height": ($scope.height - 60) / 5 + "px"}

		#TODO: watch selectedDay
		$scope.selectedDay = new Date()
		$scope.weeks = weeksOfMonth($scope.selectedDay)

		#TODO: bind event source


]