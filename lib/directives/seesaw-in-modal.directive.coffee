'use strict'

do ->
  sslInModalDirective = ($uibModal)->
    scope:
      seesawInModal: '='
      seesawInModalCallback: '&'
    link: (scope, element, attrs)->
      openModal = ->
        data = scope.seesawInModal
        modalInstance = $uibModal
          .open
            animation: true
            templateUrl: attrs.seesawInModalTemplateUrl
            controller: attrs.seesawInModalController
            size: attrs.seesawInModalSize || ''
            resolve:
              modaldata: => data
        modalInstance

      # Bind to click event
      element.bind 'click', (e)->
        openModal()
        .result.then (res)=>
          if scope.seesawInModalCallback?
            scope.seesawInModalCallback()

        e.stopPropagation();

  sslInModalDirective.$inject = ['$uibModal']

  angular.module 'ngSeesawLabs'
    .directive 'seesawInModal', sslInModalDirective
