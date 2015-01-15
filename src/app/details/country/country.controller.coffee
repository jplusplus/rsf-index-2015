angular.module("rsfIndex2015").controller "DetailsCountryCtrl", ($scope, $stateParams, $filter, mapData)->
  $scope.selectedCountry = $stateParams.country
  $scope.country         = mapData.country $stateParams.country
  $scope.rank            = $scope.country.rank()
  $scope.positionYears   = ( y for y in [2002..2014] ).reverse()
  $scope.mapData         = mapData
  $scope.decimal         = $filter 'decimal'
  $scope.countryRankData =
    country: $scope.country.name()
    rank   : $scope.rank["ranking_2015"]
    score  : $scope.decimal($scope.rank["score_2015"])
    year   : 2015

  $scope.countryIndicatorProgression = (indicator, year)->
    previousYear = year - 1
    if previousYear >= 2002
      diff = $scope.rank[indicator + "_" + year] - $scope.rank[indicator + "_" + previousYear]
      # Go up
      return 1 if diff > 0
      # Go down
      return -1 if diff < 0
    # Equal
    return 0

  $scope.countryIndicatorClass = (indicator, year)->
    switch $scope.countryIndicatorProgression(indicator, year)
      when -1 then 'success text-success'
      when  1 then 'danger text-danger'

  $scope.countryIndicatorLabel = (indicator, year)->
    switch $scope.countryIndicatorProgression(indicator, year)
      when -1 then 'label-success'
      when  1 then 'label-danger'
      when  0 then 'label-inverse'

  $scope.average = (subset, indicator)->
    # Only keep numbers
    subset = _.filter subset, (item)-> not isNaN(item[indicator])
    _.reduce(subset, (memo, rank)->
      return 1*memo + 1*rank[indicator]
    , 0) / Math.max(subset.length, 1)

  $scope.worldAverage = (indicator)->
    $scope.average mapData.ranking, indicator

  zoneRanking = _.filter mapData.ranking, zone: $scope.rank["zone"]
  $scope.zoneAverage = (indicator)->
    $scope.average zoneRanking, indicator
