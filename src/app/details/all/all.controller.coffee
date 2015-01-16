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
    $scope.countryColor = (country)-> $scope.mapData.country(country).color(2015)
    $scope.countryContrast = (country)-> $filter('contrast') $scope.countryColor(country)
    $scope.countryName = (country)-> $scope.mapData.country(country).name()
    # Prepare data
    angular.forEach mapData.ranking, (rank)->
      # Convert every sortable key to numbers
      for key of rank
        # A sortable key ends by '_2015'
        if key.indexOf("_2015") is ( key.length - 5)
          rank[key] = 1 * rank[key]
    # List of the country, updated each time the user look for something
    $scope.ranking = mapData.ranking
    # Watch the filter
    $scope.$watchCollection '[selectedName, selectedZone]', (filters)->
      $scope.ranking = _.filter mapData.ranking, countryFilter.apply(@, filters)
