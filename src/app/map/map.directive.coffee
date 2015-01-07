angular.module "rsfIndex2015"
  .directive 'map', ->
    templateUrl: "app/map/map.html",
    controller: "MapCtrl"
    restrict: 'EA'
    scope:
      country: '='
      data: '='
