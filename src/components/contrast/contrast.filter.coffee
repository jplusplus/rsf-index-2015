# Get the contrast color of the given hexadecimal color
angular.module("rsfIndex2015").filter "contrast", ->
  (hexcolor='')->
    hexcolor = hexcolor.replace "#", ""
    r = parseInt(hexcolor.substr(0, 2), 16)
    g = parseInt(hexcolor.substr(2, 2), 16)
    b = parseInt(hexcolor.substr(4, 2), 16)
    yiq = ((r * 299) + (g * 587) + (b * 114)) / 1000
    (if (yiq >= 128) then "#333" else "#FFF")
