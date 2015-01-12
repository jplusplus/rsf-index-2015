# @src http://ng.malsup.com/#!/titlecase-filter
angular.module("rsfIndex2015").filter "titlecase", ->
  (s) ->
    s = (if (s is `undefined` or s is null) then "" else s)
    s.toString().toLowerCase().replace /\b([a-z])/g, (ch) ->
      ch.toUpperCase()
