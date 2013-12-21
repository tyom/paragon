angular.module('exemplar', ['directives']);


angular.module('directives', [])
  .directive('exemplar', function($compile, $http, $templateCache) {
    return {
      restrict: 'A',
      scope: true,
      controller: function($scope, $element, $attrs) {
        $scope.toggle = function(option) {
          $scope.selectedOption = option;
        }
      }
    }
  })
  .directive('reactTo', function() {
    return {
      restrict: 'A',
      controller: function($scope, $element, $attrs) {
        $scope.options = $attrs.reactTo.split(/,\s+?/);
        $scope.selectedOption = 'default';
      }
    };
  })
  .directive('source', function() {
    return {
      restrict: 'A',
      controller: function($scope, $element, $attrs) {
        $scope.expanded = false;
      }
    };
  });
