var erpFilters = angular.module('erpFilters', []);

erpFilters.filter('zero2display', function() {
  return function(input) {
    return (input==0) ? 'none' : 'visible';
  };});
 
erpFilters.filter('boolean2display', function() {
  return function(input) {
    return input ? 'visible' : 'none';
  };});
  
erpFilters.filter('type2class', function() {
  return function(input) {
  	var result = null;
    switch(input){
    	case "Supplier":
    	result = "glyphicon glyphicon-barcode";
    	break;
    	case "Task":
    	result = "glyphicon glyphicon-pushpin";
    	break;
    	default:
    	result = "glyphicon glyphicon-link";
    	break;    	
    	
    	}
    	return result;
  };});
