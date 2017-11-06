'use strict'

do ->
  sslFormDirective = ($compile)->
    templateUrl: 'modules/seesawlabs/views/directives/ssl-form.view.html'
    transclude: true
    replace: true
    link:
      pre: (scope, element, attrs)->
        scope.parentForm = attrs.name
        # set up event handler on the form element
        element.on 'submit', (e)->
          # find the first invalid element
          firstInvalid = element[0].querySelector('.ng-invalid')
          # if we find one, set focus
          if (firstInvalid)
            e.stopImmediatePropagation();
            e.preventDefault();
            firstInvalid.focus()
            element.addClass('submitted')
            return


  sslFormDirective.$inject = ['$compile']

  angular.module 'ngSeesawLabs'
    .directive 'seesawForm', sslFormDirective
