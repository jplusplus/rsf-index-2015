angular.module("rsfIndex2015").controller "PageSingleCtrl", ($scope, $stateParams, $translate, page)->
  $scope.$watch (-> do $translate.use ), (lang)->
    $scope.single = page.get $stateParams.slug
    $scope.lang   = lang
