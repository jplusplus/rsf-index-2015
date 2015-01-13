# @src https://github.com/ianstormtaylor/to-title-case
angular.module("rsfIndex2015").filter "titlecase", ->
  (str='')-> titleCaps str.toLowerCase()
