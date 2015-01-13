angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "embed",
        url: "/embed",
        templateUrl: "app/embed/embed.html",
        controller: "EmbedCtrl"
        resolve:
          mapData: (MapData)-> MapData
