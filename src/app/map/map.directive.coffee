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
    link: (scope, element, attrs)->
      countryLayer = null
      # Color every feature
      featureStyle = (feature)->
        country = scope.data.country(feature.id)
        if country.rank()?
          # Returns the style object
          fillColor: country.color scope.selectedYear
          weight: if feature.id is scope.country then 3 else 1,
          opacity: 1
          color: 'white',
          fillOpacity: if feature.id is scope.country then 1 else 0.7
        else
          opacity: 0
          fillOpacity: 0
      # Update every feature
      updateMapFeatures = (year, oldYear)->
        # Only when year changes
        if year isnt oldYear
          # Retreive map instance
          countryLayer.setStyle(featureStyle)
      # Map settings
      scope.settings =
        maxbounds:
          southWest: L.latLng(90, 180)
          northEast: L.latLng(-90, -180)
        center:
          zoom: if scope.country then 4 else 2
        defaults:
          zoomControl: no
          scrollWheelZoom: no
      # The map may be already centered on a country
      if scope.country
        angular.extend scope.settings.center, scope.data.country(scope.country).center()
      else
        angular.extend scope.settings.center, { lat: 40.095, lng: -3.823 }
      # Scroll to the country within list
      scope.$on 'country:highlight', (ev, country)->
        # Target selector
        target = "[data-country='#{country}']"
        # Scroll to the element in 700ms
        $(".map__ranking .scroller", element).scrollTo target, 1200, offset: -100
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
