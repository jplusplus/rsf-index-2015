angular.module "rsfIndex2015"
  .config ($urlRouterProvider, $locationProvider) ->
    $urlRouterProvider.otherwise '/'
    $locationProvider.hashPrefix '!'
    $locationProvider.html5Mode no
	.run  ($rootScope, Progress) ->
    $rootScope.$on "$stateChangeStart", Progress.start
    $rootScope.$on "$stateChangeSuccess", Progress.complete
    $rootScope.$on "$stateChangeError", Progress.complete