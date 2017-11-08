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
