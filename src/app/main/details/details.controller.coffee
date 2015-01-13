angular.module "rsfIndex2015"
  .controller "MainDetailsCtrl", ($scope, $filter, mapData) ->
    $scope.mapData = mapData
    # Return the country rank
    $scope.countryRank = (country)-> 1 * country['ranking_2015']
    $scope.countryColor = (country)-> $scope.mapData.country(country).color(2015)
    $scope.countryContrast = (country)-> $filter('contrast') $scope.countryColor(country)
    # Function to filter by name
    $scope.nameFilter = (token)->
      (country)->
        # Do not search
        return yes unless token
        # Fuzzy recognition
        searchWords = token.split ' '
        # Name of the given country
        name = mapData.country(country).name().toLowerCase()
        # Every word must match
        _.every searchWords, (searchWord)-> name.search( searchWord.toLowerCase() ) isnt -1
