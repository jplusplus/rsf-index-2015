angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "highlights.single",
        url: "/:slug"
        controller: "PageSingleCtrl"
        templateUrl: "app/page/single/single.html"
