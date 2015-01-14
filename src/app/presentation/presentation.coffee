angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "presentation",
        url: "/presentation"
        data:
          slug: 'presentation'
        controller: "PageSingleCtrl"
        templateUrl: "app/page/single/single.html"
        resolve:
          page: (Page)-> Page("commons")
