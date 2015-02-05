#!/bin/sh
# To convert GEOJSON to TOPOJSON you need to install topojson binary:
# npm -g topojson

topojson --no-stitch-poles -o countries.topo.json countries.geo.json
