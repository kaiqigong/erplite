angular.module 'messageModule'
.controller 'MessageCtrl', ['$scope', '$rootScope', '$http', '$log', '$firebase', 'erplite.utils',
($scope, $rootScope, $http, $log, $firebase, utils)->
	$scope.title = "消息"
	$scope.backUrl = "#/home"
	questionRef = new Firebase("https://resplendent-fire-2552.firebaseio.com/question")
	$scope.question = $firebase questionRef
	$scope.addQuestion = ()->
		$scope.question.$add
			header:$scope.header
			body:$scope.options
		console.log $scope.question
	$scope.options = [
		{option:'A',content:''}
		{option:'B',content:''}
		{option:'C',content:''}
		{option:'D',content:''}
	]
	$scope.A = 0
	$scope.B = 0
	$scope.C = 0
	$scope.D = 0
	$scope.deleteQuestion = (key)->
		itemRef = new Firebase("https://resplendent-fire-2552.firebaseio.com/question" + '/' + key)
		itemRef.remove();
	$scope.addOption = ()->
		$scope.options.push $scope.newOption
		$scope.newOption = {}
	answerRef = new Firebase("https://resplendent-fire-2552.firebaseio.com/answer")
	$scope.answer = $firebase answerRef
	$scope.answer.$on 'child_added', (childSnapshot, prevChildName)->
		if childSnapshot
			switch childSnapshot.snapshot.value.option
				when 'A' then $scope.A++
				when 'B' then $scope.B++
				when 'C' then $scope.C++
				when 'D' then $scope.D++
	$scope.resetAnswers= ()->
		answerRef.remove()
		$scope.A = 0
		$scope.B = 0
		$scope.C = 0
		$scope.D = 0
	$scope.addAnswer = (option)->
		$scope.answer.$add
			option:option
]
