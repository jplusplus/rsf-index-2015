angular.module('rsfIndex2015').factory 'MapData', ($q, $http, $translate)->
  $q.all(
    coordinates: $http.get("assets/json/countries.coordinates.json")
    topojson   : $http.get("assets/json/countries.topo.json")
    names      : $http.get("assets/json/countries.names.json")
    ranking    : $http.get("assets/json/countries.ranking.json")
  ).then (hash)->
    coordinates: hash.coordinates.data
    topojson   : hash.topojson.data
    names      : hash.names.data
    ranking    : hash.ranking.data
    # Help function to retreive country data
    country: (code)->
      code = if code.country_code? then code.country_code else code
      code = code.toUpperCase()
      # Get the center of the country
      center: -> _.findWhere hash.coordinates.data, code: code
      # Get the names of the country
      names: -> _.findWhere hash.names.data, iso_3: code
      # Get the name of the country in the given language
      name: (lang=$translate.use())->
        key = 'country_name_' + lang.toLowerCase()
        country = _.findWhere(hash.names.data, iso_3: code)
        if country? then country[key] else null
      # Get the ranking of the given country
      rank: -> _.findWhere hash.ranking.data, country_code: code



