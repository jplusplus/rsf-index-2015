angular.module "rsfIndex2015"
  .directive 'map', (leafletData, $rootScope)->
    templateUrl: "app/map/map.html",
    controller: "MapCtrl"
    restrict: 'EA'
    scope:
      country: '='
      data: '='
      mapId: '@id'
    link: (scope, attrs)->
      # Color scale
      featureFillScale = chroma.scale(['#FFFFFF', '#F1FB8D', '#EA191E', '#9F042B', '#410E2E']).domain [0, 100]
      # Color every feature
      featureStyle = (feature)->
        fillColor: featureFillScale( ~~(Math.random() * 100) )
        weight: 1,
        opacity: 1,
        color: 'white',
        fillOpacity: 0.7
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
        layer = L.geoJson null, style: featureStyle, onEachFeature: bindClick
        # Add the layer to the map
        omnivore.topojson.parse(scope.data.topojson, null, layer).addTo map
