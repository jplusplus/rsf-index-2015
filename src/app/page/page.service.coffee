angular.module('rsfIndex2015').factory 'Page', ($http, $q)->
  class Page
    constructor: (@domain, @list)->
      console.log @domain, @list
  (domain)->
    deferred = $q.defer()
    # Get the data for the domain
    $http.get("assets/json/#{domain}.json").then (res)->
      # Resolve the service promise with an instance of the Page class.
      # This class receives the whole dataset and the current domain name.
      deferred.resolve new Page(domain, res.data)
    deferred.promise
