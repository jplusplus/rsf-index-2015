angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "insights.single",
        url: "/:slug"
        controller: "PageSingleCtrl"
        templateUrl: "app/page/single/single.html"
