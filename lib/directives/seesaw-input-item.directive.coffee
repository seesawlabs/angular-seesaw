'use strict'

do ->
  sslInputItemDirective = ->
    templateUrl: 'modules/seesawlabs/views/directives/ssl-input-item.view.html'
    transclude: true
    replace: true
    scope:
      label: '@'
      ref: '@'
      requiredMessage: '@'
      patternMessage: '@'
      minMessage: '@'
      maxMessage: '@'
      maxlengthMessage: '@'
      minlengthMessage: '@'
      emailMessage: '@'
      dateMessage: '@'
      numberMessage: '@'
    link:
      pre: (scope, element, attrs)->
        if scope.$parent?.parentForm
          scope.parentForm = scope.$parent[scope.$parent.parentForm]

        scope.isEmpty = (obj)->
          (not obj || Object.keys(obj).length is 0)

  sslInputItemDirective.$inject = []

  angular.module 'ngSeesawLabs'
    .directive 'seesawInputItem', sslInputItemDirective
