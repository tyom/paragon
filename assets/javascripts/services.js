angular.module('services', [])

  .service('exemplarSource', function($sce) {
    return {
      getCode: function(component, isHighlighted) {
        var code = component.clone().removeAttr('modifiers').wrap('<div>').parent().html();

        if(hljs && isHighlighted) {
          return $sce.trustAsHtml(hljs.highlight('xml', code).value);
        }

        return code;
      }
    }
  });
