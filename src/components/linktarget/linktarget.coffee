angular.module('rsfIndex2015').directive "href", ->
  compile: (element) ->
    hostname = "" + element[0].hostname
    if hostname? and hostname isnt "" + window.location.hostname
      element.attr "target", "_blank"
