angular.module("rsfIndex2015").controller "MapCtrl", ($scope, $rootScope, $compile, $q, $state, $translate, $modal, $filter, leafletData)->

  countryPopup = null
  # Load marker template
  markerPopupHtml = '<div ng-include="\'app/map/map.popup.html\'"></div>'

  updateMapView = (country, zoom)->
    return if not country?
    data = $scope.data.country(country)
    rank = data.rank()
    # Do not zoom pn empty value
    return if not rank? or rank['ranking_' + $scope.selectedYear] is ""
    # Retreive map instance
    leafletData.getMap($scope.mapId).then (map)->
      # Find the coordinate of the given country
      center = do data.center
      center = L.latLng(center.lat, center.lng)
      # Zoom to the current place
      map.setView L.latLng(center.lat, center.lng), zoom
      # Open a popup attach to the given country
      openCountryPopup map, country, center
      # Highlight the country without paning
      $scope.highlightCountry country, no

  openCountryPopup = (map, country, center)->
    # Create a popup bellow the given marker
    countryPopup = L.popup().setLatLng(center).openOn(map)
    rank = $scope.data.country(country).rank()
    # Create a new scope for this popup
    scope = $scope.$new no
    scope.useLanguage = $translate.use
    scope.countryRankData =
      country: $scope.data.country(country).name()
      rank   : rank["ranking_" + $scope.selectedYear]
      score  : rank["score_" + $scope.selectedYear]
      year   : 2015
    scope.country =
      'name': $scope.data.country(country).name
      'country-code': country
    scope.shoudShowCountryLink = -> $scope.country isnt country
    # Get popup node
    content = angular.element countryPopup._contentNode
    content.html markerPopupHtml
    # Compile template with the new scope
    $compile(content)(scope)

  # Highlight the country
  $scope.highlightCountry = (country, pane=yes)->
    if $scope.highlightedCountry isnt country
      $scope.highlightedCountry = country
      $rootScope.$broadcast 'country:highlight', country
    # Pan to the country
    updateMapView country if pane

  $scope.openShareModal = ->
    modalInstance = $modal.open
      templateUrl: 'app/map/share/share.html'
      controller: 'MapShareCtrl'
      size: 'lg'

  # Change the year in the parent scope
  $scope.selectYear = (year)-> angular.extend $scope, selectedYear: year
  # Return the country rank
  $scope.countryRank = (country)-> 1 * country['ranking_' + $scope.selectedYear]
  $scope.countryColor = (country)-> $scope.data.country(country).color $scope.selectedYear
  $scope.countryContrast = (country)-> $filter('contrast') $scope.countryColor(country)
  $scope.withRank = (country)-> country['ranking_' + $scope.selectedYear] isnt ""
  # Return the target of the country link
  $scope.countryLinkTarget = if $state.is("embed") then "_blank" else "_parent"
  # Watch change on the selected country to update the zoom
  $scope.$watch('country', ( (country)-> updateMapView(country, 4) ), yes)
  # Watch click on a geojson feature
  $scope.$on 'country:click', (ev, feature)-> updateMapView(feature.id)
  # Available year
  $scope.availableYears = ( y for y in [2013..2015] ).reverse()
