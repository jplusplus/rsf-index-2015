angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "details",
        url: "/details"
        controller: "DetailsCtrl"
        templateUrl: "app/details/details.html"
        resolve:
          mapData: (MapData)-> MapData
