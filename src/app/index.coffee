angular.module "rsfIndex2015", ['ngAnimate', 'ngTouch', 'ngSanitize', 'ui.router', 'ui.bootstrap']
  .config ($urlRouterProvider) ->
    $urlRouterProvider.otherwise '/'

