'use strict'

do ->
  sslButtonDirective = ($compile, seesawCommon)->
    transclude: true
    replace: true
    link: (scope, element, attrs, ctrl, transclude)->
      attributes = ['submit', 'button', 'reset']
      attrsStr = ""
      attrs['type'] = attrs.type || 'button'
      attrs['type'] = 'button' if not attributes.includes(attrs.type)
      angular.forEach Object.keys(attrs), (val, key)->
        attrsStr += "#{seesawCommon.camelToDashHyphen(val)}=\"#{attrs[val]}\" " if typeof attrs[val] is 'string'

      template = """
      <button #{attrsStr} class="ssl-button">
        <placeholder></placeholder>
      </button>"""

      templateEl = angular.element(template)

      transclude scope, (clonedContent) ->
        templateEl.find("placeholder").replaceWith(clonedContent)

        $compile(templateEl) scope, (clonedTemplate) ->
          element.replaceWith(clonedTemplate)

  sslButtonDirective.$inject = ['$compile', 'seesawCommon']

  angular.module 'ngSeesawLabs'
    .directive 'seesawButton', sslButtonDirective
