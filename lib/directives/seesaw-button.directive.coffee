'use strict'

do ->
  sslButtonDirective = ($compile, seesawCommon)->
    templateUrl: 'modules/seesawlabs/views/directives/ssl-button.view.html'
    transclude: true
    replace: true
    priority: 100
    link:
      pre: (scope, element, attrs)->
        attributes = ['submit', 'button', 'reset']
        element.attr('type', 'button') if not attrs?.type
        attrs.type = 'button' if not attributes.includes(attrs.type)

  sslButtonDirective.$inject = ['$compile', 'seesawCommon']

  angular.module 'ngSeesawLabs'
    .directive 'seesawButton', sslButtonDirective
