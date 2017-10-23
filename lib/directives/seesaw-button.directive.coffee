'use strict'

do ->
  sslButtonDirective = ->
    restrict: 'A'
    scope:
      type: '@'
    link: (scope, element, attrs)->


  sslButtonDirective.$inject = []

  angular.module 'ngSeesawLabs'
    .directive 'seesawButton', sslButtonDirective
