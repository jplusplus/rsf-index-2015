angular.module('rsfIndex2015').factory 'MapData', ($q, $http, $translate)->
  $q.all(
    coordinates: $http.get("assets/json/countries.coordinates.json")
    topojson   : $http.get("assets/json/countries.topo.json")
    names      : $http.get("assets/json/countries.names.json")
    ranking    : $http.get("assets/json/countries.ranking.json")
  ).then (hash)->
    # Color scale
    countryColor = chroma.scale(['#410E2E', '#9F042B', '#EA191E', '#F1FB8D', '#FFFFFF']).domain [100, 0]
    # Create an object with every country to allow fast country lookup
    rankingTree  = _.reduce(hash.ranking.data, (result, country)->
      result[country.country_code] = country
      result
    , {})
    # Returns an object
    coordinates: hash.coordinates.data
    topojson   : hash.topojson.data
    names      : hash.names.data
    ranking    : hash.ranking.data
    brewer     : countryColor
    # Help function to retreive country data
    country: (code)->
      code = if code.country_code? then code.country_code else code
      code = code.toUpperCase()
      # Get the center of the country
      center: -> _.findWhere hash.coordinates.data, code: code
      # Get the names of the country
      names: -> _.findWhere hash.names.data, iso_3: code
      # Get the name of the country in the given language
      name: (lang=$translate.use() or "en")->
        key = 'country_name_' + lang.toLowerCase()
        country = _.findWhere(hash.names.data, iso_3: code)
        country[key]
      # Get the ranking of the given country
      rank: -> rankingTree[code]
      # Compute the color of the country
      color: (year=2015)->
        # Return null if no score for this country
        if rankingTree[code]? then countryColor(rankingTree[code]["score_" + year]).hex() else null



