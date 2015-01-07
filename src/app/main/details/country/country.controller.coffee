angular.module("rsfIndex2015").controller "MainDetailsCountryCtrl", ($scope, $stateParams, mapData)->
  $scope.selectedCountry = $stateParams.country
  $scope.mapData = mapData
