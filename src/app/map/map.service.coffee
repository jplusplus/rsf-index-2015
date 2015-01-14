angular.module('rsfIndex2015').factory 'MapData', ($q, $http, $translate, $filter)->
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
      # Pre-calculate 2015 colors
      country["score_2015_color"] = countryColor(country["score_2015"]).hex()
      # Save the country with it code as key
      result[country.country_code] = country
      result
    , {})
    # Convert name to titlecase
    namesTree = _.reduce( hash.names.data, (result, country)->
      for key of country
        # Only name attribute
        if key.indexOf('country_name_') is 0
          # Use the titlecase filter
          country[key] = $filter("titlecase")(country[key] or "")
      result[country.iso_3] = country
      result
    , {})
    # Returns an object
    coordinates: hash.coordinates.data
    topojson   : hash.topojson.data
    ranking    : hash.ranking.data
    names      : namesTree
    brewer     : countryColor
    # Help function to retreive country data
    country: (code)->
      code = if code.country_code? then code.country_code else code
      code = code.toUpperCase()
      # Get the center of the country
      center: -> _.findWhere hash.coordinates.data, code: code
      # Get the names of the country
      names: -> namesTree[code]
      # Get the name of the country in the given language
      name: (lang=$translate.use() or "en")->
        key = 'country_name_' + lang.toLowerCase()
        if namesTree[code]? then namesTree[code][key] else ""
      # Get the ranking of the given country
      rank: -> rankingTree[code]
      # Compute the color of the country
      color: (year=2015)->
        colorKey = "score_" + year + "_color"
        # Return null if no score for this country
        if rankingTree[code]?
          # Should we use a pre-calculated color?
          if rankingTree[code][colorKey]?
            # Yes we do!
            rankingTree[code][colorKey]
          else
            # Calculate the color now
            color = countryColor( rankingTree[code]["score_" + year] ).hex()
            # And save it
            rankingTree[code][colorKey] = color
        else
          null



