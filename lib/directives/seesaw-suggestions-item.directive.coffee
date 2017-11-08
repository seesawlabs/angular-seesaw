'use strict'

do (angular)->
  sslSuggestionsItemDirective = ()->
    templateUrl: 'modules/seesawlabs/views/directives/ssl-suggestions-item.view.html'
    replace: true

    link: (scope, element, attrs)->

  sslSuggestionsItemDirective.$inject = []

  angular.module 'ngSeesawLabs'
    .directive 'seesawSuggestionsItem', sslSuggestionsItemDirective
