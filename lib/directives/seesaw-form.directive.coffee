'use strict'

do ->
  sslFormDirective = ->
    templateUrl: 'modules/seesawlabs/views/directives/ssl-form.view.html'
    transclude: true
    replace: true
    link:
      pre: (scope, element, attrs)->
        scope.parentForm = attrs.name

  sslFormDirective.$inject = []

  angular.module 'ngSeesawLabs'
    .directive 'seesawForm', sslFormDirective
