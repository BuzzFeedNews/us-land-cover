# US Land Cover

Interactive display of 2016 US National Land Cover database, from the [Multi-Resolution Land Characteristics](https://www.mrlc.gov) consortium.

The land cover layer divides the lower 48 states into a high-resolution grid and assigns a land cover type, [based on satellite data](https://www.sciencedirect.com/science/article/abs/pii/S092427161830251X), to each grid cell. If you zoom in on somewhere you know well, you'll get a sense of how accurate it is.

View the map [here](https://buzzfeednews.github.io/us-land-cover). You can zoom to a desired location using the OpenStreetMap geocoder search box at top left. The land cover layer can be toggled on and off, and you can choose between OpenStreetMap and satellite imagery basemaps.

### Code

The code to make the map, calling in the 2016 NCLD as [WMS tiles](https://www.mrlc.gov/geoserver/mrlc_display/NLCD_2016_Land_Cover_L48/wms?service=WMS&request=GetCapabilities), is in the file `landcover.R`. The file `nlcd_legend.csv` contains the labels and Hex color values for the legend.


### Questions/Feedback
Email the author Peter Aldhous at peter.aldhous@buzzfeed.com.