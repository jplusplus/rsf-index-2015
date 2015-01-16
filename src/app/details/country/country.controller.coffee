angular.module("rsfIndex2015").controller "DetailsCountryCtrl", ($scope, $stateParams, $filter, $translate, mapData, predators)->
  $scope.selectedCountry = $stateParams.country.toUpperCase()
  $scope.selectedYear    = 2015
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

  $scope.$watch (-> $translate.use() ), (lang)->
    # Filter the list of the predator and putit to the scope
    $scope.predators = _.filter predators, (predator)->
      # Only predators of the current country
      predator.countries.toUpperCase().indexOf($scope.selectedCountry) isnt -1
    # Lang suffix
    suffix = "_" + lang
    # Simplify key (by remove language suffix)
    angular.forEach $scope.predators, (predator)->
      for own key, value of predator
        # Key end with lang code
        if key.indexOf(suffix) is (key.length - suffix.length)
          # Create a new key without the suffix
          newKey = key.substring(0, key.length - suffix.length)
          # And copy the value
          predator[newKey] = value

  lastYearWithData = (indicator, year)->
    previousYear = year - 1
    if $scope.rank[indicator + "_" + previousYear]
      return previousYear
    else if previousYear > 2002
      return lastYearWithData indicator, previousYear
    else
      return -1

  $scope.countryIndicatorProgression = (indicator, year)->
    previousYear = lastYearWithData indicator, year
    if previousYear >= 2002
      diff = $scope.rank[indicator + "_" + year] - $scope.rank[indicator + "_" + previousYear]
      # Go up
      return 1 if diff > 0
      # Go down
      return -1 if diff < 0
    # Equal
    return 0

  $scope.countryIndicatorClass = (indicator, year)->
    if $scope.rank[indicator + "_" + year]
      switch $scope.countryIndicatorProgression(indicator, year)
        when -1 then 'success text-success'
        when  1 then 'danger text-danger'
    else
      'text-muted'

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
