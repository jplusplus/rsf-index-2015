angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "help-us",
        url: "/help-us"
        data:
          slug: 'help-us'
        controller: "PageSingleCtrl"
        templateUrl: "app/page/single/single.html"
        resolve:
          page: (Page)-> Page("commons")
