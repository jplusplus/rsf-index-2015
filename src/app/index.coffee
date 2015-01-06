angular.module "rsfIndex2015", ['ngAnimate', 'ngTouch', 'ngSanitize', 'ui.router', 'ui.bootstrap', 'leaflet-directive']
  .config ($urlRouterProvider) ->
    $urlRouterProvider.otherwise '/'

