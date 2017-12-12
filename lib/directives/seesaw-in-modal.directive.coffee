'use strict'

do ->
  sslInModalDirective = ($uibModal)->
    scope:
      seesawInModal: '='
      #seesawModel: '='
    link: (scope, element, attrs)->
      openModal = ->
        data = scope.seesawInModal
        modalInstance = $uibModal.open
          animation: true
          templateUrl: attrs.seesawInModalTemplateUrl
          controller: attrs.seesawInModalController
          size: attrs.seesawInModalSize || ''
          resolve:
            modaldata: => data

      # Bind to click event
      element.bind 'click', (e)->
        openModal()
          .result.then =>
            #console.log "then modal"
            # Confirm
            #scope.seesawInModal()
          #.catch =>
          #  scope.cancel() if scope.cancel
        e.stopPropagation();

  sslInModalDirective.$inject = ['$uibModal']

  angular.module 'ngSeesawLabs'
    .directive 'seesawInModal', sslInModalDirective
