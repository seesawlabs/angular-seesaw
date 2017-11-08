'use strict'

do ->
  sslFacetsDirective = ($stateParams, $state)->
    scope:
      aggregations: '='
      entity: '='
      facets: '='
      selected: '='

    templateUrl: 'modules/seesawlabs/views/directives/ssl-facets.view.html'

    link: (scope, element, attrs)->

      checkFacets = ->
        scope.selected[scope.entity.id] = {}
        if scope.facets and scope.facets[scope.entity.id]
          entity = scope.facets[scope.entity.id]
          facets = entity.split(';')
          angular.forEach facets, (facet, k) ->
            arr = facet.split(':')
            facetKey = arr[0]
            facetVals = arr[1]
            valsArr = facetVals.split(',')

            angular.forEach valsArr, (val, k) ->
              scope.selected[scope.entity.id] = {} if not scope.selected[scope.entity.id]
              scope.selected[scope.entity.id][facetKey] = {} if not scope.selected[scope.entity.id][facetKey]
              scope.selected[scope.entity.id][facetKey][val] = true

      getFacets = ()->
        entities = []
        if scope.selected
          angular.forEach Object.keys(scope.selected), (k, i)->
            facets = []
            angular.forEach Object.keys(scope.selected[k]), (fK, fI)->
              vals = []
              angular.forEach Object.keys(scope.selected[k][fK]), (vK, vI)->
                vals.push vK if scope.selected[k][fK][vK] and vK
              facets.push "#{fK}:#{vals.join(',')}" if vals.length > 0
            entities.push "#{k}::#{facets.join(';')}" if facets.length > 0
        entities.join(';;')

      scope.getKeys = (obj)->
        res = []
        res = Object.keys(obj) if obj
        res

      scope.getName = (str)->
        str.replace(/_/, ' ')

      scope.refresh = ->
        facets = getFacets()
        $state.go 'search-results', { entity: $stateParams.entity, keywords: $stateParams.keywords, facets: facets, active: scope.entity.id }

      checkFacets()

  sslFacetsDirective.$inject = ['$stateParams', '$state']

  angular.module 'ngSeesawLabs'
    .directive 'sslFacets', sslFacetsDirective
