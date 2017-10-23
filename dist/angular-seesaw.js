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
  sslButtonDirective = function() {
    return {
      restrict: 'A',
      scope: {
        type: '@'
      },
      link: function(scope, element, attrs) {}
    };
  };
  sslButtonDirective.$inject = [];
  return angular.module('ngSeesawLabs').directive('seesawButton', sslButtonDirective);
})();
