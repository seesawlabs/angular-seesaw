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
    link:
      pre: (scope, element, attrs)->
        scope.showCollapse = false if not scope.showCollapse?
        scope.details = {}
        scope.loading = false
        scope.items = []
        scope.tableOptions =
          sorting:
            id: "desc"
          count: 100

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
                  scope.items = response
                  scope.loading = false
                  records = if params.filter() then $filter('filter')(response, params.filter(), false) else response
                  records = if params.sorting() then $filter('orderBy')(records, params.orderBy()) else records
                  params.total(records.length)
                .catch (err)->
                  params.total(0)
                  null

        scope.getValue = (item, name, filter = null)->
          return '' if not name
          res = eval("item.#{name}")
          if filter?.name
            res = $filter(filter.name)(res, filter.expression, filter.comparator, filter.anyPropertyKey)
          res

        scope.doClick = (item)->
          scope.clickEvent(item)

        # init
        scope.refresh()

  sslEntityListDirective.$inject = ['$compile', '$filter', 'NgTableParams']

  angular.module 'ngSeesawLabs'
    .directive 'seesawEntityList', sslEntityListDirective
