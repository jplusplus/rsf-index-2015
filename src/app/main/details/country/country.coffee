angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "main.details.country",
        controller: "MainDetailsCountryCtrl"
        url: "/:country"
        templateUrl: "app/main/details/country/country.html"
