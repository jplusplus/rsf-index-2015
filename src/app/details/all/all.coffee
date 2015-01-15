angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "details.all",
        url: "/details"
        controller: "DetailsAllCtrl"
        templateUrl: "app/details/all/all.html"
