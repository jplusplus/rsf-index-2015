angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "details.country",
        controller: "DetailsCountryCtrl"
        url: "/:country"
        templateUrl: "app/details/country/country.html"
