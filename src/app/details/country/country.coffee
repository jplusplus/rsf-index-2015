angular.module "rsfIndex2015"
  .config ($stateProvider) ->
    $stateProvider
      .state "details.country",
        controller: "DetailsCountryCtrl"
        url: "/details/:country"
        templateUrl: "app/details/country/country.html"
        resolve:
          timeout: ($timeout)-> $timeout angular.noop, 3000
          predators: ($http)->
            # Get the predators file and return the dataset
            $http.get("assets/json/countries.predators.json").then (res)-> res.data
