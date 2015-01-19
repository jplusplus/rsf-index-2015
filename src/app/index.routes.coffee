angular.module "rsfIndex2015"
  .config ($urlRouterProvider, $locationProvider) ->
    $urlRouterProvider.otherwise '/'
    $locationProvider.hashPrefix '!'
    $locationProvider.html5Mode no
  .run  ($rootScope, Progress) ->
    $rootScope.$on "$stateChangeStart", ->
      # Go to the top of the window
      $("body").scrollTo 0, 400
      # Start progress indicator
      do Progress.start
    # Stop progress indicator
    $rootScope.$on "$stateChangeSuccess", Progress.complete
    # Stop progress indicator
    $rootScope.$on "$stateChangeError", Progress.complete
