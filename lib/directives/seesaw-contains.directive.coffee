'use strict'

do ->
  sslContainsDirective = ()->
    link: (scope, element, attrs)->      
      #element.

  sslContainsDirective.$inject = []

  angular.module 'ngSeesawLabs'
    .directive 'seesawContains', sslContainsDirective
