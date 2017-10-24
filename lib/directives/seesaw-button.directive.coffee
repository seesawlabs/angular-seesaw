'use strict'

do ->
  sslButtonDirective = ($compile)->
    # "camel" case to dash hyphen
    fixCase = (input)->
      # if it has underscores first convert to Camel Case
      if input.match(/_/g)
        input = input.replace /_(.)/g, (v, a)->a.toUpperCase()

      # If it's all capitalized, first make everything lowercase
      if input.match(/^[A-Z]+$/g)
        input = input.toLowerCase()

      result = input.replace(/([A-Z])/g, '-$1')
      result.toLowerCase()

    transclude: true
    replace: true
    link: (scope, element, attrs, ctrl, transclude)->
      attrsStr = ""
      attrs['type'] = attrs.type || 'button'
      angular.forEach Object.keys(attrs), (val, key)->
        attrsStr += "#{fixCase(val)}=\"#{attrs[val]}\" " if typeof attrs[val] is 'string'

      template = """
      <button #{attrsStr}>
        <placeholder></placeholder>
      </button>"""

      templateEl = angular.element(template)

      transclude scope, (clonedContent) ->
        templateEl.find("placeholder").replaceWith(clonedContent)

        $compile(templateEl) scope, (clonedTemplate) ->
          element.replaceWith(clonedTemplate)

  sslButtonDirective.$inject = ['$compile']

  angular.module 'ngSeesawLabs'
    .directive 'seesawButton', sslButtonDirective
