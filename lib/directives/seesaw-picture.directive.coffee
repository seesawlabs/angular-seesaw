'use strict'

do ->
  sslPictureDirective = ->
    templateUrl: 'modules/seesawlabs/views/directives/ssl-picture.view.html'
    replace: true
    scope:
      logoUrl: '='
      logoUuid: '='
      editMode: '='
      defaultUrl: '@'
    link:
      pre: (scope, element, attrs)->
        scope.editMode = false
        scope.removeLogo = ->
          scope.logoUrl = null
          scope.logoUuid = ''

  sslPictureDirective.$inject = []

  angular.module 'ngSeesawLabs'
    .directive 'seesawPicture', sslPictureDirective
