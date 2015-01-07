angular.module('rsfIndex2015').factory 'MapData', ($q, $http)->
  $q.all(
    coordinates: $http.get("assets/json/countries.coordinates.json")
    geojson: $http.get("assets/json/countries.geo.json")
  ).then (hash)->
    coordinates: hash.coordinates.data
    geojson    : hash.geojson.data

