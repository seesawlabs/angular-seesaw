'use strict'

do (angular)->

  sslEntityListDirective = ($compile, $filter, NgTableParams) ->
    templateUrl: 'modules/seesawlabs/views/directives/ssl-entity-list.view.html'
    replace: true
    scope:
      headers: '='
      permission: '@'
      clickEvent: '&'
      promise: '&'
      options: '='
      showCollapse: '@'
      collapseTextProperty: '@'
      reference: '='
    link:
      pre: (scope, element, attrs)->
        scope.showCollapse = false if not scope.showCollapse?
        scope.details = {}
        scope.loading = false
        scope.tableOptions =
          sorting:
            id: "desc"
          count: 100

        scope.getItem = (item, reference)->
          return item if not reference?
          res =
            item: item
            ref: reference
          res

        scope.onAction = (option, item)->
          option.action(item)
            .then (res)=>
              if option.refresh or option.name is 'delete'
                scope.refresh()

        scope.refresh = ->
          if scope.tableParams
            scope.tableParams.reload()
            return

          scope.tableParams = new NgTableParams scope.tableOptions,
            counts: []
            getData: (params)->
              scope.promise()
                .then (response) ->
                  scope.loading = false
                  records = if params.filter() then $filter('filter')(response, params.filter(), false) else response
                  records = if params.sorting() then $filter('orderBy')(records, params.orderBy()) else records
                  params.total(records.length)
                  records.slice((params.page() - 1) * params.count(), params.page() * params.count())
                .catch (err)->
                  params.total(0)
                  null

        scope.getValue = (item, name, filter = null)->
          return '' if not item? or not name?
          try
            res = eval("item.#{name}")
          catch
            return ''

          res = $filter(filter.name)(res, filter.expression, filter.comparator, filter.anyPropertyKey) if filter?.name
          res

        scope.doClick = (item)->
          scope.clickEvent(item)

        # init
        scope.refresh()

  sslEntityListDirective.$inject = ['$compile', '$filter', 'NgTableParams']

  angular.module 'ngSeesawLabs'
    .directive 'seesawEntityList', sslEntityListDirective
