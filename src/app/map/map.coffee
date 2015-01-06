angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "map",
        url: "/map",
        templateUrl: "app/map/map.html",
        controller: "MapCtrl"
        resolve:
          geojson: ($http)->
            $http.get("assets/json/countries.geo.json")
