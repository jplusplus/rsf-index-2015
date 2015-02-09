angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "insights",
        url: "/insights"
        controller: "PageCtrl"
        templateUrl: "app/page/page.html"
        resolve:
          page: (Page)-> Page("insights")
