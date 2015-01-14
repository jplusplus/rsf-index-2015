angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "press",
        url: "/press"
        data:
          slug: 'press'
        controller: "PageSingleCtrl"
        templateUrl: "app/press/press.html"
        resolve:
          page: (Page)-> Page("commons")
