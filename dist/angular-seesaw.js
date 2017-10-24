'use strict';
(function(angular, window) {
  return angular.module('ngSeesawLabs', []);
})(angular, window);

'use strict';
(function(angular) {
  return null;
})(angular);

'use strict';
(function() {
  var sslButtonDirective;
  sslButtonDirective = function($compile) {
    var fixCase;
    fixCase = function(input) {
      var result;
      if (input.match(/_/g)) {
        input = input.replace(/_(.)/g, function(v, a) {
          return a.toUpperCase();
        });
      }
      if (input.match(/^[A-Z]+$/g)) {
        input = input.toLowerCase();
      }
      result = input.replace(/([A-Z])/g, '-$1');
      return result.toLowerCase();
    };
    return {
      transclude: true,
      replace: true,
      link: function(scope, element, attrs, ctrl, transclude) {
        var attrsStr, template, templateEl;
        attrsStr = "";
        attrs['type'] = attrs.type || 'button';
        angular.forEach(Object.keys(attrs), function(val, key) {
          if (typeof attrs[val] === 'string') {
            return attrsStr += (fixCase(val)) + "=\"" + attrs[val] + "\" ";
          }
        });
        template = "<button " + attrsStr + ">\n  <placeholder></placeholder>\n</button>";
        templateEl = angular.element(template);
        return transclude(scope, function(clonedContent) {
          templateEl.find("placeholder").replaceWith(clonedContent);
          return $compile(templateEl)(scope, function(clonedTemplate) {
            return element.replaceWith(clonedTemplate);
          });
        });
      }
    };
  };
  sslButtonDirective.$inject = ['$compile'];
  return angular.module('ngSeesawLabs').directive('seesawButton', sslButtonDirective);
})();
