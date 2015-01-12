angular.module("rsfIndex2015").controller "MapCtrl", ($scope, $rootScope, $compile, $q, $state, $translate, leafletData)->

  countryPopup = null
  # Load marker template
  markerPopupHtml = '<div ng-include="\'app/map/map.popup.html\'"></div>'

  updateMapView = (country, zoom)->
    # Do not zoom pn empty value
    return unless country?
    # Retreive map instance
    leafletData.getMap($scope.mapId).then (map)->
      # Find the coordinate of the given country
      center = do $scope.data.country(country).center
      center = L.latLng(center.lat, center.lng)
      # Zoom to the current place
      map.setView L.latLng(center.lat, center.lng, zoom)
      # Open a popup attach to the given country
      openCountryPopup map, country, center
      # Highlight the country without paning
      $scope.highlightCountry country, no

  openCountryPopup = (map, country, center)->
    # Create a popup bellow the given marker
    countryPopup = L.popup().setLatLng(center).openOn(map)
    rank = $scope.data.country(country).rank()
    # Create a new scope for this popup
    scope = $scope.$new yes
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

  # Get the contrast color of the given hexadecimal color
  colorContrast = (hexcolor)->
    hexcolor = hexcolor.replace "#", ""
    r = parseInt(hexcolor.substr(0, 2), 16)
    g = parseInt(hexcolor.substr(2, 2), 16)
    b = parseInt(hexcolor.substr(4, 2), 16)
    yiq = ((r * 299) + (g * 587) + (b * 114)) / 1000
    (if (yiq >= 128) then "#333" else "#FFF")
  # Change the year in the parent scope
  $scope.selectYear = (year)-> angular.extend $scope, selectedYear: year
  # Return the country rank
  $scope.countryRank = (country)-> 1 * country['ranking_' + $scope.selectedYear]
  $scope.countryColor = (country)-> $scope.data.country(country).color $scope.selectedYear
  $scope.countryContrast = (country)-> colorContrast $scope.countryColor(country)
  # Watch change on the selected country to update the zoom
  $scope.$watch('country', ( (country)-> updateMapView(country, 4) ), yes)
  # Watch click on a geojson feature
  $scope.$on 'country:click', (ev, feature)-> updateMapView(feature.id)
  # Available year
  $scope.availableYears = ( y for y in [2013..2015] ).reverse()
