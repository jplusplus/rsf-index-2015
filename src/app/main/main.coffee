angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "main",
        url: "/",
        templateUrl: "app/main/main.html",
        controller: "MainCtrl"
        resolve:
          mapData: (MapData)-> MapData
