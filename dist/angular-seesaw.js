'use strict';
(function(angular, window) {
  return angular.module('ngSeesawLabs', []);
})(angular, window);

'use strict';
(function(angular) {
  return null;
})(angular);

var BaseCtrl,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

BaseCtrl = (function() {
  function BaseCtrl() {
    this.clearError = bind(this.clearError, this);
    this.alertSuccess = bind(this.alertSuccess, this);
    this.alertError = bind(this.alertError, this);
  }

  BaseCtrl.prototype.alert = null;

  BaseCtrl.prototype.alertError = function(message) {
    if (message == null) {
      message = "Please contact system administrator - Unexpected error";
    }
    this.alert = {
      type: 'danger',
      message: message
    };
    if (this.toaster != null) {
      this.toaster.error(this.alert.message);
    }
  };

  BaseCtrl.prototype.alertSuccess = function(message) {
    this.alert = {
      type: 'success',
      message: message
    };
  };

  BaseCtrl.prototype.clearError = function() {
    return this.alert = null;
  };

  BaseCtrl.prototype.clone = function(obj) {
    var flags, key, newInstance;
    if ((obj == null) || typeof obj !== 'object') {
      return obj;
    }
    if (obj instanceof Date) {
      return new Date(obj.getTime());
    }
    if (obj instanceof RegExp) {
      flags = '';
      if (obj.global != null) {
        flags += 'g';
      }
      if (obj.ignoreCase != null) {
        flags += 'i';
      }
      if (obj.multiline != null) {
        flags += 'm';
      }
      if (obj.sticky != null) {
        flags += 'y';
      }
      return new RegExp(obj.source, flags);
    }
    newInstance = new obj.constructor();
    for (key in obj) {
      newInstance[key] = this.clone(obj[key]);
    }
    return newInstance;
  };

  return BaseCtrl;

})();

'use strict';
(function() {
  var sslBackHistoryDirective;
  sslBackHistoryDirective = function($window) {
    return {
      link: function(scope, element, attrs) {
        return element.bind('click', function() {
          return $window.history.back();
        });
      }
    };
  };
  sslBackHistoryDirective.$inject = ['$window'];
  return angular.module('ngSeesawLabs').directive('seesawBackHistory', sslBackHistoryDirective);
})();

'use strict';
(function() {
  var sslButtonDirective;
  sslButtonDirective = function() {
    return {
      templateUrl: 'modules/seesawlabs/views/directives/ssl-button.view.html',
      transclude: true,
      replace: true,
      link: {
        pre: function(scope, element, attrs) {
          var attributes;
          attributes = ['submit', 'button', 'reset'];
          if (!(attrs != null ? attrs.type : void 0)) {
            element.attr('type', 'button');
          }
          if (!attributes.includes(attrs.type)) {
            return attrs.type = 'button';
          }
        }
      }
    };
  };
  sslButtonDirective.$inject = [];
  return angular.module('ngSeesawLabs').directive('seesawButton', sslButtonDirective);
})();

'use strict';
(function() {
  var sslConfirmDirective;
  sslConfirmDirective = function($uibModal) {
    return {
      scope: {
        sslConfirm: '&',
        sslConfirmCancel: '&',
        sslConfirmMessage: '@',
        sslConfirmTemplate: '@'
      },
      link: function(scope, element, attrs) {
        var openConfirmationModal;
        openConfirmationModal = function(message, templateUrl) {
          var modalInstance;
          if ($uibModal != null) {
            return modalInstance = $uibModal.open({
              animation: true,
              templateUrl: templateUrl || 'modules/seesawlabs/views/directives/ssl-basic-confirmation-modal.view.html',
              controller: 'ConfirmationModalCtrl as modalCtrl',
              resolve: {
                confirmationMessage: (function(_this) {
                  return function() {
                    return message;
                  };
                })(this)
              }
            });
          }
        };
        return element.bind('click', function(e) {
          openConfirmationModal(scope.kConfirmMessage, scope.kConfirmTemplate).result.then((function(_this) {
            return function() {
              return scope.kConfirm();
            };
          })(this))["catch"]((function(_this) {
            return function() {
              if (scope.kConfirmCancel) {
                return scope.kConfirmCancel();
              }
            };
          })(this));
          return e.stopPropagation();
        });
      }
    };
  };
  sslConfirmDirective.$inject = ['$uibModal'];
  return angular.module('ngSeesawLabs').directive('seesawConfirm', sslConfirmDirective);
})();

'use strict';
(function() {
  var sslDatepickerDirective;
  sslDatepickerDirective = function($compile, seesawCommon) {
    return {
      replace: true,
      require: ['ngModel'],
      link: {
        pre: function(scope, element, attrs) {
          var attrsStr, template, templateEl;
          attrsStr = "";
          angular.forEach(Object.keys(attrs), function(val, key) {
            if (typeof attrs[val] === 'string') {
              return attrsStr += (seesawCommon.camelToDashHyphen(val)) + "=\"" + attrs[val] + "\" ";
            }
          });
          template = "<div class=\"ssl-datepicker\" ng-class=\"{ 'fg-line': true, 'fg-toggled': " + attrs.name + "Flag == true }\">\n  <input ng-click=\"" + attrs.name + "Flag = true;\" is-open=\"" + attrs.name + "Flag\" uib-datepicker-popup=\"MMM dd, yyyy\" show-weeks=\"false\" type=\"text\" close-text=\"Close\" " + attrsStr + " />\n</div>";
          templateEl = angular.element(template);
          return $compile(templateEl)(scope, function(clonedTemplate) {
            return element.replaceWith(clonedTemplate);
          });
        },
        post: function(scope, element, attrs, ctrls) {
          var ngModel;
          ngModel = ctrls[0];
          return ngModel.$formatters.push(function(modelValue) {
            var dt;
            if (!modelValue) {
              return void 0;
            }
            dt = new Date(modelValue);
            dt.setMinutes(dt.getMinutes() + dt.getTimezoneOffset());
            dt.setMinutes((dt.getMinutes() + (dt.getHours() * 60)) * -1);
            ngModel.$setViewValue(dt);
            return dt;
          });
        }
      }
    };
  };
  sslDatepickerDirective.$inject = ['$compile', 'seesawCommon'];
  return angular.module('ngSeesawLabs').directive('seesawDatepicker', sslDatepickerDirective);
})();

'use strict';
(function(angular) {
  var sslEntityListDirective;
  sslEntityListDirective = function($compile, $filter, NgTableParams) {
    return {
      templateUrl: 'modules/seesawlabs/views/directives/ssl-entity-list.view.html',
      replace: true,
      scope: {
        headers: '=',
        permission: '@',
        clickEvent: '&',
        promise: '&',
        options: '=',
        showCollapse: '@',
        collapseTextProperty: '@',
        reference: '='
      },
      link: {
        pre: function(scope, element, attrs) {
          if (scope.showCollapse == null) {
            scope.showCollapse = false;
          }
          scope.details = {};
          scope.loading = false;
          scope.items = [];
          scope.tableOptions = {
            sorting: {
              id: "desc"
            },
            count: 100
          };
          scope.getItem = function(item, reference) {
            var res;
            if (reference == null) {
              return item;
            }
            res = {
              item: item,
              ref: reference
            };
            return res;
          };
          scope.onAction = function(option, item) {
            return option.action(item).then((function(_this) {
              return function(res) {
                if (option.refresh || option.name === 'delete') {
                  return scope.refresh();
                }
              };
            })(this));
          };
          scope.refresh = function() {
            if (scope.tableParams) {
              scope.tableParams.reload();
              return;
            }
            return scope.tableParams = new NgTableParams(scope.tableOptions, {
              counts: [],
              getData: function(params) {
                return scope.promise().then(function(response) {
                  var records;
                  scope.items = response;
                  scope.loading = false;
                  records = params.filter() ? $filter('filter')(response, params.filter(), false) : response;
                  records = params.sorting() ? $filter('orderBy')(records, params.orderBy()) : records;
                  return params.total(records.length);
                })["catch"](function(err) {
                  params.total(0);
                  return null;
                });
              }
            });
          };
          scope.getValue = function(item, name, filter) {
            var res;
            if (filter == null) {
              filter = null;
            }
            if ((item == null) || (name == null)) {
              return '';
            }
            try {
              res = eval("item." + name);
            } catch (error) {
              return '';
            }
            if (filter != null ? filter.name : void 0) {
              res = $filter(filter.name)(res, filter.expression, filter.comparator, filter.anyPropertyKey);
            }
            return res;
          };
          scope.doClick = function(item) {
            return scope.clickEvent(item);
          };
          return scope.refresh();
        }
      }
    };
  };
  sslEntityListDirective.$inject = ['$compile', '$filter', 'NgTableParams'];
  return angular.module('ngSeesawLabs').directive('seesawEntityList', sslEntityListDirective);
})(angular);

'use strict';
(function() {
  var sslFacetsDirective;
  sslFacetsDirective = function($stateParams, $state) {
    return {
      scope: {
        aggregations: '=',
        entity: '=',
        facets: '=',
        selected: '='
      },
      templateUrl: 'modules/seesawlabs/views/directives/ssl-facets.view.html',
      link: function(scope, element, attrs) {
        var checkFacets, getFacets;
        checkFacets = function() {
          var entity, facets;
          scope.selected[scope.entity.id] = {};
          if (scope.facets && scope.facets[scope.entity.id]) {
            entity = scope.facets[scope.entity.id];
            facets = entity.split(';');
            return angular.forEach(facets, function(facet, k) {
              var arr, facetKey, facetVals, valsArr;
              arr = facet.split(':');
              facetKey = arr[0];
              facetVals = arr[1];
              valsArr = facetVals.split(',');
              return angular.forEach(valsArr, function(val, k) {
                if (!scope.selected[scope.entity.id]) {
                  scope.selected[scope.entity.id] = {};
                }
                if (!scope.selected[scope.entity.id][facetKey]) {
                  scope.selected[scope.entity.id][facetKey] = {};
                }
                return scope.selected[scope.entity.id][facetKey][val] = true;
              });
            });
          }
        };
        getFacets = function() {
          var entities;
          entities = [];
          if (scope.selected) {
            angular.forEach(Object.keys(scope.selected), function(k, i) {
              var facets;
              facets = [];
              angular.forEach(Object.keys(scope.selected[k]), function(fK, fI) {
                var vals;
                vals = [];
                angular.forEach(Object.keys(scope.selected[k][fK]), function(vK, vI) {
                  if (scope.selected[k][fK][vK] && vK) {
                    return vals.push(vK);
                  }
                });
                if (vals.length > 0) {
                  return facets.push(fK + ":" + (vals.join(',')));
                }
              });
              if (facets.length > 0) {
                return entities.push(k + "::" + (facets.join(';')));
              }
            });
          }
          return entities.join(';;');
        };
        scope.getKeys = function(obj) {
          var res;
          res = [];
          if (obj) {
            res = Object.keys(obj);
          }
          return res;
        };
        scope.getName = function(str) {
          return str.replace(/_/, ' ');
        };
        scope.refresh = function() {
          var facets;
          facets = getFacets();
          return $state.go('search-results', {
            entity: $stateParams.entity,
            keywords: $stateParams.keywords,
            facets: facets,
            active: scope.entity.id
          });
        };
        return checkFacets();
      }
    };
  };
  sslFacetsDirective.$inject = ['$stateParams', '$state'];
  return angular.module('ngSeesawLabs').directive('sslFacets', sslFacetsDirective);
})();

'use strict';
(function() {
  var sslFormDirective;
  sslFormDirective = function() {
    return {
      templateUrl: 'modules/seesawlabs/views/directives/ssl-form.view.html',
      transclude: true,
      replace: true,
      link: {
        pre: function(scope, element, attrs) {
          scope.parentForm = attrs.name;
          return element.on('submit', function(e) {
            var firstInvalid;
            firstInvalid = element[0].querySelector('.ng-invalid');
            if (firstInvalid) {
              e.stopImmediatePropagation();
              e.preventDefault();
              firstInvalid.focus();
              element.addClass('submitted');
            }
          });
        }
      }
    };
  };
  sslFormDirective.$inject = [];
  return angular.module('ngSeesawLabs').directive('seesawForm', sslFormDirective);
})();

'use strict';
(function() {
  var sslInModalDirective;
  sslInModalDirective = function($uibModal) {
    return {
      scope: {
        seesawInModal: '=',
        seesawInModalCallback: '&'
      },
      link: function(scope, element, attrs) {
        var openModal;
        openModal = function() {
          var data, modalInstance;
          data = scope.seesawInModal;
          modalInstance = $uibModal.open({
            animation: true,
            templateUrl: attrs.seesawInModalTemplateUrl,
            controller: attrs.seesawInModalController,
            size: attrs.seesawInModalSize || '',
            resolve: {
              modaldata: (function(_this) {
                return function() {
                  return data;
                };
              })(this)
            }
          });
          return modalInstance;
        };
        return element.bind('click', function(e) {
          openModal().result.then((function(_this) {
            return function(res) {
              if (scope.seesawInModalCallback != null) {
                return scope.seesawInModalCallback();
              }
            };
          })(this));
          return e.stopPropagation();
        });
      }
    };
  };
  sslInModalDirective.$inject = ['$uibModal'];
  return angular.module('ngSeesawLabs').directive('seesawInModal', sslInModalDirective);
})();

'use strict';
(function() {
  var sslInputItemDirective;
  sslInputItemDirective = function() {
    return {
      templateUrl: 'modules/seesawlabs/views/directives/ssl-input-item.view.html',
      transclude: true,
      replace: true,
      scope: {
        label: '@',
        ref: '@',
        requiredMessage: '@',
        patternMessage: '@',
        minMessage: '@',
        maxMessage: '@',
        maxlengthMessage: '@',
        minlengthMessage: '@',
        emailMessage: '@',
        dateMessage: '@',
        numberMessage: '@'
      },
      link: {
        pre: function(scope, element, attrs) {
          scope.parentForm = scope.$parent[scope.$parent.parentForm];
          return scope.isEmpty = function(obj) {
            return !obj || Object.keys(obj).length === 0;
          };
        }
      }
    };
  };
  sslInputItemDirective.$inject = [];
  return angular.module('ngSeesawLabs').directive('seesawInputItem', sslInputItemDirective);
})();

'use strict';
(function() {
  var sslPictureDirective;
  sslPictureDirective = function() {
    return {
      templateUrl: 'modules/seesawlabs/views/directives/ssl-picture.view.html',
      replace: true,
      scope: {
        logoUrl: '=',
        logoUuid: '=',
        editMode: '@',
        defaultUrl: '@'
      },
      link: {
        pre: function(scope, element, attrs) {
          if (scope.editMode == null) {
            scope.editMode = false;
          }
          return scope.removeLogo = function() {
            scope.logoUrl = null;
            return scope.logoUuid = '';
          };
        }
      }
    };
  };
  sslPictureDirective.$inject = [];
  return angular.module('ngSeesawLabs').directive('seesawPicture', sslPictureDirective);
})();

'use strict';
(function() {
  var sslStatusDirective;
  sslStatusDirective = function() {
    return {
      templateUrl: 'modules/seesawlabs/views/directives/ssl-status.view.html',
      replace: true,
      scope: {
        status: '=',
        label: '='
      },
      link: {
        pre: function(scope, element, attrs) {
          if (scope.status != null) {
            return scope.status = scope.status.toLowerCase();
          }
        }
      }
    };
  };
  sslStatusDirective.$inject = [];
  return angular.module('ngSeesawLabs').directive('seesawStatus', sslStatusDirective);
})();

'use strict';
(function(angular) {
  var sslSuggestionsItemDirective;
  sslSuggestionsItemDirective = function() {
    return {
      templateUrl: 'modules/seesawlabs/views/directives/ssl-suggestions-item.view.html',
      replace: true,
      link: function(scope, element, attrs) {}
    };
  };
  sslSuggestionsItemDirective.$inject = [];
  return angular.module('ngSeesawLabs').directive('seesawSuggestionsItem', sslSuggestionsItemDirective);
})(angular);

'use strict';
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

(function(angular) {
  var SuggestionsModalCtrl, sslSuggestionsDirective;
  SuggestionsModalCtrl = (function(superClass) {
    extend(SuggestionsModalCtrl, superClass);

    SuggestionsModalCtrl.$inject = ['$uibModalInstance', 'data'];

    function SuggestionsModalCtrl($modal, data) {
      this.$modal = $modal;
      this.data = data;
    }

    SuggestionsModalCtrl.prototype.cancel = function() {
      return this.$modal.dismiss('cancel');
    };

    return SuggestionsModalCtrl;

  })(BaseCtrl);
  sslSuggestionsDirective = function($timeout, $compile, $uibModal) {
    return {
      transclude: true,
      scope: {
        text: "=",
        search: "&",
        mode: "=",
        selected: "=",
        modalOptions: "=",
        onItemSelect: "&",
        mouseLeaveDisable: "="
      },
      link: function(scope, element, attrs, ctrl, transclude) {
        var template, templateEl;
        scope.blur = false;
        scope.placeholder = attrs.placeholder;
        scope.addLabel = attrs.addLabel;
        scope.items = [];
        scope.mode = 1;
        scope.loading = false;
        template = "<div class='autocomplete' ng-mouseleave='onMouseLeave()'><input name=" + (attrs.name || 'suggestion') + " type='text' ng-model='text' placeholder='" + (attrs.placeholder || '') + "' class='" + (attrs.inputClass || '') + "' ng-keyup='onKeyup(text)' autocomplete='off' " + (attrs.required || '') + "><ul ng-show='((items.length > 0 && text.length > 0) || (text.length > 3 && addLabel)) && mode != 0'><li ng-repeat='$item in items' ng-click='onSelect($item)'><placeholder></placeholder></li><li class='addlabel text-center' ng-if='addLabel'><a href='javascript:;' ng-bind='addLabel' ng-click='add()'></a></li></ul></div>";
        templateEl = angular.element(template);
        transclude(scope, function(clonedContent) {
          templateEl.find("placeholder").replaceWith(clonedContent);
          return $compile(templateEl)(scope, function(clonedTemplate) {
            return element.append(clonedTemplate);
          });
        });
        scope.onKeyup = function(typed) {
          scope.showSuggestions();
          if (!scope.loading) {
            scope.loading = true;
            return scope.search().then((function(_this) {
              return function(res) {
                scope.items = res;
                return scope.loading = false;
              };
            })(this));
          }
        };
        scope.onMouseLeave = function() {
          if (!scope.mouseLeaveDisable) {
            return scope.hideSuggestions();
          }
        };
        scope.hideSuggestions = function() {
          return scope.mode = 0;
        };
        scope.showSuggestions = function() {
          return scope.mode = 1;
        };
        scope.onSelect = function(obj) {
          if (obj) {
            scope.selected = obj;
          }
          scope.hideSuggestions();
          if (typeof scope.onItemSelect === 'function') {
            return $timeout((function(_this) {
              return function() {
                return scope.onItemSelect();
              };
            })(this));
          }
        };
        return scope.add = function() {
          if (scope.modalOptions) {
            return $uibModal.open(scope.modalOptions).result.then((function(_this) {
              return function(res) {
                if (res != null) {
                  return scope.onKeyup(scope.text);
                }
              };
            })(this));
          }
        };
      }
    };
  };
  sslSuggestionsDirective.$inject = ['$timeout', '$compile', '$uibModal'];
  return angular.module('ngSeesawLabs').controller('SuggestionsModalCtrl', SuggestionsModalCtrl).directive('seesawSuggestions', sslSuggestionsDirective);
})(angular);

'use strict';
(function(angular) {
  var seesawCommon;
  seesawCommon = function() {
    return {
      camelToDashHyphen: function(input) {
        var result;
        if (input.match(/_/g)) {
          input = input.replace(/_(.)/g, function(v, a) {
            return a.toUpperCase();
          });
        }
        if (input.match(/^[A-Z]+$/g)) {
          input = input.toLowerCase();
        }
        result = input.replace(/([A-Z])/g, '-$1');
        return result.toLowerCase();
      }
    };
  };
  seesawCommon.$inject = [];
  return angular.module('ngSeesawLabs').factory('seesawCommon', seesawCommon);
})(angular);
