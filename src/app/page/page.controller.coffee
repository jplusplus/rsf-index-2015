angular.module("rsfIndex2015").controller "PageCtrl", ($scope, $state, page)->
  $scope.page = page
  $scope.link = (single)->
    # Guess the current state dynamicly
    $state.href "#{$state.current.name}.single", single
