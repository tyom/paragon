angular.module('directives', [])

  .directive('exemplar', function($compile, $http, $templateCache, exemplarSource) {
    return {
      restrict: 'C',
      scope: true,
      // Menu controller
      controller: function($scope, $element, $attrs) {
        $scope.toggle = function(option, group) {
          if(!option.modifier) return;

          $scope.component.toggleClass(option.modifier, option.active = !option.active);
          $scope.source = exemplarSource.getCode($scope.component, true);

          // Only allow one toggle per group
          if(group) {
            var others = _.difference(group, [option]);

            _.each(others, function(item) {
              item.active = false;
              $scope.component.removeClass(item.modifier);
            });
          }
        };
      },
      // Adds options menu to `<header>` element
      compile: function($element) {
        var subdir = window.location.pathname.substr(0, window.location.pathname.indexOf('/exemplars'));
        var menu = $http.get(subdir + '/partials/exemplar-options-menu.html', { cache: $templateCache })
          .success(function(html) {
            return html;
          });
        var stage = $element.find('> ._stage');

        if(stage.length === 0) {
          throw 'Exemplars must have `_stage` section';
        }

        return function($scope) {
          menu.then(function(res) {
            stage.before($compile(res.data)($scope));
          });
        };
      }
    };
  })

  .directive('component', function() {
    return {
      restrict: 'C',
      link: function($scope, $element) {
        $scope.component = $scope.component || $element.children();
      }
    };
  })

  .directive('modifiers', function() {
    return {
      restrict: 'A',
      link: function($scope, $element, $attrs) {
        $scope.options = $scope.options || {};
        $scope.menuLabel = 'Modifiers';
        $scope.component = $element;

        var elOptions = {};
        try {
          elOptions = $scope.$parent.parseRules($attrs.modifiers);
        } catch(e) {
          throw 'Exemplar container must have `exemplar` class name';
        }

        _.extend($scope.options, elOptions);
      }
    };
  })

  .directive('source', function(exemplarSource) {
    return {
      restrict: 'C',
      controller: function($scope, $element, $attrs) {
        $scope.expanded = false;  // Default HTML Source state
        $scope.source = exemplarSource.getCode($scope.component, true);
      }
    };
  });
