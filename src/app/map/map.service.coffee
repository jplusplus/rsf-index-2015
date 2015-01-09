angular.module('rsfIndex2015').factory 'MapData', ($q, $http)->
  $q.all(
    coordinates: $http.get("assets/json/countries.coordinates.json")
    topojson   : $http.get("assets/json/countries.topo.json")
  ).then (hash)->
    coordinates: hash.coordinates.data
    topojson   : hash.topojson.data

