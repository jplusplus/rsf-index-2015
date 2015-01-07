angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "main.details",
        url: "details"
        templateUrl: "app/main/details/details.html"
