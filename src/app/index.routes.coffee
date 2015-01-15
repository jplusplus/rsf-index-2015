angular.module "rsfIndex2015"
  .config ($urlRouterProvider, $locationProvider) ->
    $urlRouterProvider.otherwise '/'
    $locationProvider.hashPrefix '!'
    $locationProvider.html5Mode no

