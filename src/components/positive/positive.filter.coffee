# Displays positive mark
angular.module("rsfIndex2015").filter "positive", ->
  (num)-> if num > 0 then "+" + num else num
