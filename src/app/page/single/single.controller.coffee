angular.module("rsfIndex2015").controller "PageSingleCtrl", ($scope, $state, $stateParams, $translate, page)->
  slug = $stateParams.slug or $state.current.data.slug
  $scope.$watch (-> do $translate.use ), (lang)->
    $scope.single = page.get slug
    $scope.lang   = lang
