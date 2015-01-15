angular.module "rsfIndex2015"
  .controller "DetailsAllCtrl", ($scope, $filter, mapData) ->
    $scope.mapData = mapData
    # Function to filter by name
    countryFilter = (name, zone)->
      # The country match with the name zone
      isZone = (country)-> not zone or zone is '' or country.zone is zone
      # The country match with the name check
      isName = (country)->
        # Do not search
        return yes unless name and name isnt ''
        # Fuzzy recognition
        searchWords = name.split ' '
        # Name of the given country
        countryName = mapData.country(country).name().toLowerCase()
        # Every word must match
        _.every searchWords, (searchWord)-> countryName.search( searchWord.toLowerCase() ) isnt -1
      # Returns a function that tests both of the filters
      (country)-> isZone(country) and isName(country)
    # Return the country rank
    $scope.countryRank = (country)-> 1 * country['ranking_2015']
    $scope.countryColor = (country)-> $scope.mapData.country(country).color(2015)
    $scope.countryContrast = (country)-> $filter('contrast') $scope.countryColor(country)
    # List of the country, updated each time the user look for something
    $scope.ranking = mapData.ranking
    # Watch the filter
    $scope.$watchCollection '[selectedName, selectedZone]', (filters)->
      $scope.ranking = _.filter mapData.ranking, countryFilter.apply(@, filters)
