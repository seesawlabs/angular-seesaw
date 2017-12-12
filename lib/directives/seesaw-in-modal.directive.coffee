'use strict'

do ->
  sslInModalDirective = ($uibModal)->
    scope:
      seesawInModal: '&'
    link: (scope, element, attrs)->
      openModal = ->
        modalInstance = $uibModal.open
          animation: true
          templateUrl: attrs.seesawInModalTemplateUrl
          controller: attrs.seesawInModalController
          size: attrs.seesawInModalSize || ''
          resolve:
            scope.resolve

      # Bind to click event
      element.bind 'click', (e)->
        openModal()
          .result.then =>
            scope.seesawInModal()
          #.catch =>
          #  scope.kConfirmCancel() if scope.kConfirmCancel
        e.stopPropagation();

  sslInModalDirective.$inject = ['$uibModal']

  angular.module 'ngSeesawLabs'
    .directive 'seesawInModal', sslInModalDirective
