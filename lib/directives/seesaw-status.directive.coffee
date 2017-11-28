'use strict'

do ->
  sslStatusDirective = ->
    templateUrl: 'modules/seesawlabs/views/directives/ssl-status.view.html'
    replace: true
    scope:
      status: '='
      label: '='
    link:
      pre: (scope, element, attrs)->
        scope.status = scope.status.toLowerCase() if scope.status?

  sslStatusDirective.$inject = []

  angular.module 'ngSeesawLabs'
    .directive 'seesawStatus', sslStatusDirective
