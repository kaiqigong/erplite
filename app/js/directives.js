var erpDirectives = angular.module('erpDirectives', []);

/*
 * angular directive erp-icheck
 *
 * @description icheck is a plugin of jquery for beautifying checkbox &amp; radio, now I complied it with angular directive
 * @require jquery, icheck
 * @example <input type="radio" ng-model="paomian" value="kangshifu" erp-icheck>
 *          <input type="checkbox" class="icheckbox" name="mantou" ng-model="mantou" erp-icheck checked>
 */
erpDirectives.directive('erpIcheck', function ($document) {
    return {
        restrict: 'A',
        require: '?ngModel',
        link: function ($scope, $element, $attrs, $ngModel) {
            if (!$ngModel) {
                return;
            }
            //using iCheck
            $element.iCheck({
                labelHover: false,
                cursor: true,
                checkboxClass: 'icheckbox_flat-blue',
                radioClass: 'iradio_flat-blue'
            }).on('ifClicked', function (event) {
                if ($attrs.type == "checkbox") {
                    //checkbox, $ViewValue = true/false/undefined
                    $scope.$apply(function () {
                        $ngModel.$setViewValue(!($ngModel.$modelValue === undefined ? false : $ngModel.$modelValue));
                    });
                } else {
                    // radio, $ViewValue = $attrs.value
                    $scope.$apply(function () {
                        $ngModel.$setViewValue($attrs.value);
                    });
                }
            });
        }
    };
});

erpDirectives.directive('erpImgLoading', function ($document) {
    return {
        restrict: 'A',
        link: function ($scope, $element, $attrs) {
            $element.addClass("beforeLoaded");
            $element.on('load', function (event) {
                $element.removeClass("beforeLoaded");
                $element.addClass("afterLoaded");
            });
        }
    };
});