angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "themes",
        url: "/themes"
        resolve:
          page: (Page)-> Page("themes")
