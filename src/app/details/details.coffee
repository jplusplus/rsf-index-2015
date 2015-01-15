angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "details",
        templateUrl: "app/details/details.html"
        resolve:
          mapData: (MapData)-> MapData
