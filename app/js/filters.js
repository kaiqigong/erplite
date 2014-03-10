angular.module('erpFilters', []).filter('messagedisplay', function() {
  return function(input) {
    return (input==0) ? 'none' : 'visible';
  };
});