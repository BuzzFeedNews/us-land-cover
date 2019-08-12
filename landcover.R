# load required packages
library(leaflet)
library(leaflet.extras)
library(readr)
library(dplyr)

# load legend data and edit
legend <- read_csv("nlcd_legend.csv") %>%
  mutate(shapes = "square",
         sizes = 10,
         borders = colors)

# function to add a custom legend (adapted from https://stackoverflow.com/questions/52812238/custom-legend-with-r-leaflet-circles-and-squares-in-same-plot-legends)
addLegendCustom <- function(map, colors, labels, sizes, shapes, borders, opacity = 1){
  make_shapes <- function(colors, sizes, borders, shapes) {
    paste0(colors, "; width:", sizes, "px; height:", sizes, "px; border:3px solid ", borders, "; border-radius:", shapes)
  }
  make_labels <- function(sizes, labels) {
    paste0("<div style='display: inline-block;height: ", 
           sizes, "px;margin-top: 4px;line-height: ", 
           sizes, "px;'>", labels, "</div>")
  }
  legend_colors <- make_shapes(colors, sizes, borders, shapes)
  legend_labels <- make_labels(sizes, labels)
  return(addLegend(map, colors = legend_colors, labels = legend_labels, opacity = opacity, position = "bottomright"))
}

# make leaflet map, bringing in National Land Cover Database from WMS
leaflet() %>% 
  addProviderTiles(providers$Esri.WorldImagery, group="Satellite") %>%
  addTiles(group="OpenStreetMap") %>%
  setView(-93.65, 42.0285, zoom = 4) %>%
  addResetMapButton() %>%
  # add address/location search
  addSearchOSM(options = searchFeaturesOptions(
    zoom=15,
    autoCollapse = FALSE, 
    hideMarkerOnCollapse = TRUE)) %>%
  # add land cover layer
  addWMSTiles(
    "https://www.mrlc.gov/geoserver/mrlc_display/NLCD_2016_Land_Cover_L48/ows?SERVICE=WMS&",
    layers = "NLCD_2016_Land_Cover_L48",
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "National Land Cover Database 2016",
    group = "Land cover"
  ) %>%
  addLayersControl(
    baseGroups = c("Satellite","OpenStreetMap"),
    overlayGroups = "Land cover",
    options = layersControlOptions(collapsed = FALSE)
  ) %>%
  addLegendCustom(legend$colors, legend$labels, legend$sizes, legend$shapes, legend$borders)





  