angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "highlights",
        url: "/highlights"
        controller: "PageCtrl"
        templateUrl: "app/page/page.html"
        resolve:
          page: (Page)-> Page("highlights")
