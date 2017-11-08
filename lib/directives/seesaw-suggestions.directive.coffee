'use strict'

do (angular)->

  class SuggestionsModalCtrl extends BaseCtrl
    @$inject: ['$uibModalInstance', 'data']
    constructor: (@$modal, @data)->

    cancel: ()->
      @$modal.dismiss('cancel')

  sslSuggestionsDirective = ($timeout, $compile, $uibModal)->
    transclude: true
    scope:
      text: "="
      search: "&"
      mode: "="
      selected: "="
      modalOptions: "="
      onItemSelect: "&"
      mouseLeaveDisable: "="

    link: (scope, element, attrs, ctrl, transclude)->
      scope.blur = false
      scope.placeholder = attrs.placeholder
      scope.addLabel = attrs.addLabel
      scope.items = []
      scope.mode = 1
      scope.loading = false

      template = "<div class='autocomplete' ng-mouseleave='onMouseLeave()'>\
                    <input name=#{attrs.name || 'suggestion'} type='text' ng-model='text' placeholder='#{attrs.placeholder || ''}' class='#{attrs.inputClass || ''}' ng-keyup='onKeyup(text)' autocomplete='off' #{attrs.required || ''}>\
                    <ul ng-show='((items.length > 0 && text.length > 0) || (text.length > 3 && addLabel)) && mode != 0'>\
                      <li ng-repeat='$item in items' ng-click='onSelect($item)'>\
                        <placeholder></placeholder>\
                      </li>\
                      <li class='addlabel text-center' ng-if='addLabel'>\
                        <a href='javascript:;' ng-bind='addLabel' ng-click='add()'></a>\
                      </li>\
                    </ul>\
                  </div>"
      templateEl = angular.element(template)

      transclude scope, (clonedContent) ->
        templateEl.find("placeholder").replaceWith(clonedContent)

        $compile(templateEl) scope, (clonedTemplate) ->
          element.append(clonedTemplate)

      scope.onKeyup = (typed)->
        scope.showSuggestions()
        if not scope.loading
          scope.loading = true
          scope.search()
            .then (res) =>
              scope.items = res
              scope.loading = false

      scope.onMouseLeave = ->
        if not scope.mouseLeaveDisable
          scope.hideSuggestions()

      scope.hideSuggestions = ->
        scope.mode = 0

      scope.showSuggestions = ->
        scope.mode = 1

      scope.onSelect = (obj)->
        if obj
          scope.selected = obj
        scope.hideSuggestions()
        if typeof scope.onItemSelect is 'function'
          $timeout =>
            scope.onItemSelect()

      scope.add = ->
        if scope.modalOptions
          $uibModal.open scope.modalOptions
          .result.then (res)=>
            # refresh if new sugestions were add
            scope.onKeyup(scope.text) if res?

  sslSuggestionsDirective.$inject = ['$timeout', '$compile', '$uibModal']

  angular.module 'ngSeesawLabs'
    .controller 'SuggestionsModalCtrl', SuggestionsModalCtrl
    .directive 'seesawSuggestions', sslSuggestionsDirective
