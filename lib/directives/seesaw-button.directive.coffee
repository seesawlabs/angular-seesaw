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

      if attrs['type'] is 'submit'
        attrs['ngClick'] = "onSubmit()"

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

      scope.onSubmit = ->
        scope.$parent[scope.$parent.parentForm].$submitted = true

  sslButtonDirective.$inject = ['$compile', 'seesawCommon']

  angular.module 'ngSeesawLabs'
    .directive 'seesawButton', sslButtonDirective
