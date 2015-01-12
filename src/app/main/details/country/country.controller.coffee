angular.module("rsfIndex2015").controller "MainDetailsCountryCtrl", ($scope, $stateParams, mapData)->
  $scope.selectedCountry = $stateParams.country
  $scope.country = mapData.country $stateParams.country
  $scope.rank = $scope.country.rank()
  $scope.countryRankData =
    country: $scope.country.name()
    rank   : $scope.rank["ranking_2015"]
    score  : $scope.rank["score_2015"]
    year   : 2015
  $scope.rank
  $scope.positionYears = ( y for y in [2002..2014] ).reverse()
  $scope.mapData = mapData
