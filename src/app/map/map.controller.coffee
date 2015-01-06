angular.module("rsfIndex2015").controller "MapCtrl", ($scope, geojson)->

  featureFillScale = chroma.scale(['white', '#410E2E']).domain [0, 100]

  featureStyle = (feature)->
    fillColor: featureFillScale( Math.random() * 100 )
    weight: 1,
    opacity: 1,
    color: 'white',
    fillOpacity: 0.7

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
