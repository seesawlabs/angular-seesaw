'use strict'

do ->
  sslBackHistoryDirective = ($window)->
    link: (scope, element, attrs)->
      # Bind to click event
      element.bind 'click', ->
        $window.history.back()

  sslBackHistoryDirective.$inject = ['$window']

  angular.module 'ngSeesawLabs'
    .directive 'seesawBackHistory', sslBackHistoryDirective
