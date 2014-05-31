// Generated by CoffeeScript 1.7.1
angular.module('messageModule').controller('MessageCtrl', [
  '$scope', '$rootScope', '$http', '$log', '$firebase', 'erplite.utils', function($scope, $rootScope, $http, $log, $firebase, utils) {
    var answerRef, questionRef;
    $scope.title = "消息";
    $scope.backUrl = "#/home";
    questionRef = new Firebase("https://resplendent-fire-2552.firebaseio.com/question");
    $scope.question = $firebase(questionRef);
    $scope.addQuestion = function() {
      $scope.question.$add({
        header: $scope.header,
        body: $scope.options
      });
      return console.log($scope.question);
    };
    $scope.options = [
      {
        option: 'A',
        content: ''
      }, {
        option: 'B',
        content: ''
      }, {
        option: 'C',
        content: ''
      }, {
        option: 'D',
        content: ''
      }
    ];
    $scope.A = 0;
    $scope.B = 0;
    $scope.C = 0;
    $scope.D = 0;
    $scope.deleteQuestion = function(key) {
      var itemRef;
      itemRef = new Firebase("https://resplendent-fire-2552.firebaseio.com/question" + '/' + key);
      return itemRef.remove();
    };
    $scope.addOption = function() {
      $scope.options.push($scope.newOption);
      return $scope.newOption = {};
    };
    answerRef = new Firebase("https://resplendent-fire-2552.firebaseio.com/answer");
    $scope.answer = $firebase(answerRef);
    $scope.answer.$on('child_added', function(childSnapshot, prevChildName) {
      if (childSnapshot) {
        switch (childSnapshot.snapshot.value.option) {
          case 'A':
            return $scope.A++;
          case 'B':
            return $scope.B++;
          case 'C':
            return $scope.C++;
          case 'D':
            return $scope.D++;
        }
      }
    });
    $scope.resetAnswers = function() {
      answerRef.remove();
      $scope.A = 0;
      $scope.B = 0;
      $scope.C = 0;
      return $scope.D = 0;
    };
    return $scope.addAnswer = function(option) {
      return $scope.answer.$add({
        option: option
      });
    };
  }
]);
