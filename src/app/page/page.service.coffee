angular.module('rsfIndex2015').factory 'Page', ($http, $q, $translate)->
  class Page
    # Pass parameters directly to instance attributes
    constructor: (@domain, @list)->
      # Nothing to do (yet)
      # ...
    # Get page using its slug (or the filename as fallback)
    get: (slug, lang)->
      # Use current language as default language
      lang = $translate.use() unless lang?
      # Find the page
      page = _.findWhere @list, slug: slug, lang: lang
      # A page with this slug exists in the current language
      if page?
        # Return the page using its slug
        page
      # Try with the english version
      else if lang isnt 'en' then @get slug, 'en'
      # Last case, the page isn't available in englsih neither:
      # We take any page with this slug
      else _.findWhere @list, slug: slug
    # Get the list of every pages for the current language
    all: -> _.filter @list,  lang: $translate.use()

  (domain)->
    deferred = $q.defer()
    # Get the data for the domain
    $http.get("assets/json/#{domain}.json").then (res)->
      # Resolve the service promise with an instance of the Page class.
      # This class receives the whole dataset and the current domain name.
      deferred.resolve( new Page(domain, res.data) )
    deferred.promise
