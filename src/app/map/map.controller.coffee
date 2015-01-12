angular.module("rsfIndex2015").controller "MapCtrl", ($scope, $rootScope, $compile, $q, leafletData)->

  countryMarker = countryPopup = null
  # Load marker template
  markerPopupHtml = '<div ng-include="\'app/map/map.popup.html\'"></div>'

  updateMapView = (country, zoom)->
    # Do not zoom pn empty value
    return unless country?
    # Retreive map instance
    leafletData.getMap($scope.mapId).then (map)->
      # Find the coordinate of the given country
      center = _.findWhere $scope.data.coordinates, code: country
      center = L.latLng(center.lat, center.lng)
      # Zoom to the current place
      map.setView L.latLng(center.lat, center.lng, zoom)
      # Open a popup attach to the given country
      openCountryPopup map, country, center

  openCountryPopup = (map, country, center)=>
    # Create a popup bellow the given marker
    countryPopup = L.popup().setLatLng(center).openOn(map)
    # Create a new scope for this popup
    scope = $scope.$new yes
    scope.country = 'name': country, 'country-code': country
    # Get popup node
    content = angular.element countryPopup._contentNode
    content.html markerPopupHtml
    # Compile template with the new scope
    $compile(content)(scope)

  # Watch change on the selected country
  $scope.$watch('country', (country)->
    updateMapView country, 4
  , yes)
  # Watch click on a geojson feature
  $scope.$on 'country:click', (ev, feature)->
    # Retreive map instance
    updateMapView feature.id
