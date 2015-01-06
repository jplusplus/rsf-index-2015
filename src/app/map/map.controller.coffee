angular.module("rsfIndex2015").controller "MapCtrl", ($scope, $http)->

  featureFillScale = chroma.scale(['#FFFFFF', '#F1FB8D', '#EA191E', '#9F042B', '#410E2E']).domain [0, 100]

  featureStyle = (feature)->
    fillColor: featureFillScale( Math.random() * 100 )
    weight: 1,
    opacity: 1,
    color: 'white',
    fillOpacity: 0.7

  $http.get("assets/json/countries.geo.json").then (geojson)->
    $scope.settings =
      center:
        lat: 40.095
        lng: -3.823
        zoom: 2
      defaults:
        scrollWheelZoom: no
      geojson:
        data: geojson.data
        style: featureStyle
