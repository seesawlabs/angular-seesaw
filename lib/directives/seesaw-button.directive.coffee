'use strict'

do ->
  sslButtonDirective = ->
    templateUrl: 'modules/seesawlabs/views/directives/ssl-button.view.html'
    transclude: true
    replace: true
    link:
      pre: (scope, element, attrs)->
        attributes = ['submit', 'button', 'reset']
        element.attr('type', 'button') if not attrs?.type
        attrs.type = 'button' if not attributes.includes(attrs.type)

  sslButtonDirective.$inject = []

  angular.module 'ngSeesawLabs'
    .directive 'seesawButton', sslButtonDirective
