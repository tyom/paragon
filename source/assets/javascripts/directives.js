angular.module('directives', [])

  .directive('exemplar', function($compile, $http, $templateCache) {
    return {
      restrict: 'A',
      scope: true,
      // Menu controller
      controller: function($scope, $element, $attrs) {
        $scope.toggle = function(option, group) {
          if(!option.modifier) return;

          var component = $('[data-exemplar-id="' + $scope.$id + '"]');

          option.active = !option.active;

          if(option.active) {
            component.addClass(option.modifier);
          } else {
            component.removeClass(option.modifier);
          }

          // Only allow one toggle per group
          if(group) {
            var others = _.difference(group, [option]);

            _.each(others, function(item) {
              item.active = false;
              component.removeClass(item.modifier);
            });
          }
        };
      },
      // Add options menu to `<header>`
      compile: function($element) {
        var subdir = window.location.pathname.substr(0, window.location.pathname.indexOf('/exemplars'));
        var menu = $http.get(subdir + '/partials/exemplar-options-menu.html', { cache: $templateCache })
          .success(function(html) {
            return html;
          });
        var header = $element.find('header');

        if(header.length === 0) {
          throw 'Exemplars must have a <header> element to attach options menu to';
        }

        return function($scope, $element) {
          menu.then(function(res) {
            $element.find('header').append($compile(res.data)($scope));
          });
        };
      }
    };
  })

  .directive('modifiers', function() {
    return {
      restrict: 'A',
      controller: function($scope, $element, $attrs) {
        $scope.options = $scope.options || {};
        $scope.menuLabel = 'Modifiers';

        var elOptions = {};
        try {
          elOptions = $scope.$parent.parseRules($attrs.modifiers);
          $element.attr('data-exemplar-id', $scope.$id);
        } catch(e) {
          console.log(e);
          throw 'container must have `exemplar` attribute in order to use `modifiers` directive';
        }

        _.extend($scope.options, elOptions);
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
