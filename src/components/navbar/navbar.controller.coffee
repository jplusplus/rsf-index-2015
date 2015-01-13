angular.module("rsfIndex2015").controller "NavbarCtrl", ($scope, $translate, $state)->
  $scope.useLanguage = $translate.use
  $scope.shoudShowNavbar = -> not $state.is 'embed'
