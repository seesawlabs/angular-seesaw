'use strict'

do ->
  sslDatepickerDirective = ($compile, seesawCommon)->
    replace: true
    require: ['ngModel']
    link:
      pre:(scope, element, attrs)->
        attrsStr = ""
        angular.forEach Object.keys(attrs), (val, key)->
          attrsStr += "#{seesawCommon.camelToDashHyphen(val)}=\"#{attrs[val]}\" " if typeof attrs[val] is 'string'

        template = """
          <div class="ssl-datepicker" ng-class="{ 'fg-line': true, 'fg-toggled': #{attrs.name}Flag == true }">
            <input ng-click="#{attrs.name}Flag = true;" is-open="#{attrs.name}Flag" uib-datepicker-popup="MMM dd, yyyy" show-weeks="false" type="text" close-text="Close" #{attrsStr} />
          </div>"""

        templateEl = angular.element(template)

        $compile(templateEl) scope, (clonedTemplate) ->
          element.replaceWith clonedTemplate

      post:(scope, element, attrs, ctrls)->
        ngModel = ctrls[0]

        ngModel.$formatters.push (modelValue)->
          return undefined if !modelValue
          dt = new Date(modelValue)
          dt.setMinutes dt.getMinutes() + dt.getTimezoneOffset()
          dt.setMinutes ((dt.getMinutes() + (dt.getHours() * 60)) * -1)
          ngModel.$setViewValue(dt)
          dt

  sslDatepickerDirective.$inject = ['$compile', 'seesawCommon']

  angular.module 'ngSeesawLabs'
    .directive 'seesawDatepicker', sslDatepickerDirective
