# @src http://stackoverflow.com/questions/196972/convert-string-to-title-case-with-javascript
angular.module("rsfIndex2015").filter "titlecase", ->
  (str='') ->
    if str.replace?
      str.replace /\w\S*/g, (txt) ->
        txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
