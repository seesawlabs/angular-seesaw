describe 'Seesaw Labs Directives', ->

  describe 'setup', ->
    $scope = $compile = null

    beforeEach module('ngSeesawLabs')

    # Load all templates
    beforeEach module('allviews')

    beforeEach inject (_$rootScope_, _$compile_, $injector)->
      $scope = _$rootScope_
      $compile = _$compile_

    compile = (markup)->
      el = $compile(angular.element(markup))($scope)
      $scope.$digest()
      el

    it 'button directive', ->
      html = "<div><seesaw-button>Cancel</seesaw-button></div>"
      el = compile html
      el = el.find 'button'

      # Confirm it has type attribute
      expect(el.attr('type')).toEqual('button')
      expect(el.hasClass('ssl-button')).toBe(true)

      # Test transclude
      el = compile el.html()
      expect(el.html()).toEqual('Cancel')

      # Confirm it has the right button type
      html = "<div><seesaw-button type='submit'>Cancel</seesaw-button></div>"
      el = compile html
      el = el.find 'button'

      expect(el.attr('type')).toEqual('submit')

      # Test with other types
      html = "<div><seesaw-button>Cancel</seesaw-button></div>"
      el = compile html
      el = el.find 'button'

      expect(el.attr('type')).toEqual('button')

#    xit 'input directive', ->
#      html = "<div><seesaw-input-item ref='myinput'><input name='myinput' type='text' required></seesaw-input-item></div>"
#      el = compile html
#      #console.log 11, el
#      #el = el[0].querySelectorAll('.ssl-input-item')
#      #console.log 22, $scope.parentForm
#      el.scope().$apply()
#
#      # Confirm it has type attribute
#      #expect(el.attr('type')).toEqual('button')
#      #expect(el.hasClass('ssl-button')).toBe(true)

    it 'form validations directive', ->
      html = """
      <div>
        <seesaw-form name='myform' ng-submit="mySubmit()">
          <seesaw-input-item ref='myinput'>
            <input name='myinput' type='text' required>
          </seesaw-input-item>
          <seesaw-button type='submit'>Save</seesaw-button>
        </seesaw-form>
      </div>"""
      el = compile html
      ref = $scope.$$childTail.$$childTail.$$prevSibling.ref
      expect(ref).toEqual('myinput')
      expect(el.html()).not.toContain('input-error')

      $scope.$$childTail.$$childTail.$$prevSibling.parentForm[ref] =
        $error:
          required: true

      $scope.$digest()
      expect(el.html()).toContain('input-error')






#
#    it 'suggestions directive', ->
#      html = "<div><seesaw-suggestions></seesaw-suggestions></div>"
#      el = compile html

#    it 'confirm directive', ->
#      html = "<div><seesaw-button seesaw-confirm=''>Ok</seesaw-button></div>"
#      el = compile html

#    it 'facets directive', ->
#
#    it 'back directive', ->
#      html = "<div><a seesaw-back-history>click me</a></div>"
#      el = compile html
