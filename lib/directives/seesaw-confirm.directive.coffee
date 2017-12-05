'use strict'

do ->
  sslConfirmDirective = ($uibModal)->
    scope:
      sslConfirm: '&'
      sslConfirmCancel: '&'
      sslConfirmMessage: '@'
      sslConfirmTemplate: '@'

    link: (scope, element, attrs)->

      openConfirmationModal = (message, templateUrl)->
        if $uibModal?
          modalInstance = $uibModal.open
            animation: true
            templateUrl: templateUrl || 'modules/seesawlabs/views/directives/ssl-basic-confirmation-modal.view.html'
            controller: 'ConfirmationModalCtrl as modalCtrl'
            resolve:
              confirmationMessage: =>
                message

      # Bind to click event
      element.bind 'click', (e)->
        openConfirmationModal(scope.kConfirmMessage, scope.kConfirmTemplate)
          .result.then =>
            scope.kConfirm()
          .catch =>
            scope.kConfirmCancel() if scope.kConfirmCancel
        e.stopPropagation();

  sslConfirmDirective.$inject = ['$uibModal']

  angular.module 'ngSeesawLabs'
    .directive 'seesawConfirm', sslConfirmDirective
