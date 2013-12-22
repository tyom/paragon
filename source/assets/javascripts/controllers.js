angular.module('controllers', [])

  .controller('Exemplars', function($scope) {
    $scope.parseRules = function(string, targetEl) {
      var groups = string.match(/\[(.*?)\]/g) || [];
      var singles = string;
      var modifiers = [];

      // Find and extract grouped and single instructions.
      groups = _.map(groups, function(group) {
        singles = singles.replace(group, '').replace(/,\s+,\s+/, ', ').replace(/,\s+?$/, '');
        return group.slice(1, -1);
      });

      // Singles
      _.each(singles.split(/,\s+/), function(rule) {
        if(!rule) return;
        modifiers.push(createOption(rule));
      });

      // Groups
      _.each(groups, function(rules, i) {
        var group = [];
        _.each(rules.split(/,\s+/), function(rule) {
          group.push(createOption(rule));
        });
        modifiers.push(group);
      });

      function createOption(rule) {
        var parts = rule.split(':');
        var keys = _.initial(parts);
        var mod   = _.last(parts);
        var key = keys[0];

        return {
          modifier: mod,
          label: keys.length ? key : rule
        };
      }

      return modifiers;
    };
  })
