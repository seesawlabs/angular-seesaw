'use strict'

do (angular)->
  seesawCommon = ->
    camelToDashHyphen: (input)->
      # if it has underscores first convert to Camel Case
      if input.match(/_/g)
        input = input.replace /_(.)/g, (v, a)->a.toUpperCase()

      # If it's all capitalized, first make everything lowercase
      if input.match(/^[A-Z]+$/g)
        input = input.toLowerCase()

      result = input.replace(/([A-Z])/g, '-$1')
      result.toLowerCase()

  seesawCommon.$inject = []

  angular.module 'ngSeesawLabs'
    .factory 'seesawCommon', seesawCommon
