angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "details.country",
        controller: "DetailsCountryCtrl"
        url: "/:country"
        templateUrl: "app/details/country/country.html"
        resolve:
          predators: ($http)->
            # Get the predators file and return the dataset
            $http.get("assets/json/countries.predators.json").then (res)-> res.data
