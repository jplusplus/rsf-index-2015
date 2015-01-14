angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "themes",
        url: "/themes"
        controller: "PageCtrl"
        templateUrl: "app/page/page.html"
        resolve:
          page: (Page)-> Page("themes")
