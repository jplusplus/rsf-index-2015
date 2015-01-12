angular.module "rsfIndex2015"
  .directive 'map', (leafletData, $rootScope)->
    templateUrl: "app/map/map.html",
    controller: "MapCtrl"
    restrict: 'EA'
    scope:
      country     : '='
      data        : '='
      mapId       : '@id'
      selectedYear: '=year'
    link: (scope, attrs)->
      countryLayer = null
      # Color every feature
      featureStyle = (feature)->
        color = scope.data.country(feature.id).color scope.selectedYear
        # Returns the style object
        fillColor: if color? then color.hex() else null
        weight: 1,
        opacity: if color? then 1 else 0,
        color: 'white',
        fillOpacity: if feature.id is scope.country then 1 else 0.7
      # Update every feature
      updateMapFeatures = (year, oldYear)->
        # Only when year changes
        if year isnt oldYear
          # Retreive map instance
          countryLayer.setStyle(featureStyle)
      # Map settings
      scope.settings =
        center:
          lat: 40.095
          lng: -3.823
          zoom: 2
        defaults:
          scrollWheelZoom: no
      # Retreive map instance
      leafletData.getMap(scope.mapId).then (map)->
        bindClick = (feature, layer)->
          # Create an event on click
          layer.on 'click', (ev)->
            # Trigger a scope digest
            scope.$apply ->
              # Broadcast this event
              $rootScope.$broadcast 'country:click', ev.target.feature
        # Create a layer to host topojson
        countryLayer = L.geoJson null, style: featureStyle, onEachFeature: bindClick
        # Add the layer to the map
        omnivore.topojson.parse(scope.data.topojson, null, countryLayer).addTo map
        # Watch change on the selectd year to update the color
        scope.$watch 'selectedYear', updateMapFeatures, yes

