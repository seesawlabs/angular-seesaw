'use strict'

do ->
  sslInputItemDirective = ->
    templateUrl: 'modules/seesawlabs/views/directives/ssl-input-item.view.html'
    transclude: true
    replace: true
    scope:
      label: '@'
      ref: '@'
    link:
      pre: (scope, element, attrs)->
        scope.parentForm = scope.$parent[scope.$parent.parentForm]

  sslInputItemDirective.$inject = []

  angular.module 'ngSeesawLabs'
    .directive 'seesawInputItem', sslInputItemDirective
