# Displays positive mark
angular.module("rsfIndex2015").filter "positive", ->
  (num)-> if num+"" isnt "0" and (num+"").indexOf('-') is -1 then  "+" + num else num
