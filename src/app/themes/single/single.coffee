angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "themes.single",
        url: "/:slug"
        controller: "PageSingleCtrl"
        templateUrl: "app/page/single/single.html"
