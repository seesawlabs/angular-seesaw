'use strict'

do ->
  sslOneClickDirective = ->
    restrict: 'A'
    link: (scope, element, attrs)->
      # Bind to click event
      element.bind 'click', ->
        element.attr('disabled', 'disabled')


  sslOneClickDirective.$inject = []

  angular.module 'ngSeesawLabs'
    .directive 'seesawOneClick', sslOneClickDirective
