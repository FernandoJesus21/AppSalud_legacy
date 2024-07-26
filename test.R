# leaflet(pcias) %>%
#   addTiles() %>%
#   addPolygons(weight = 2
#               , stroke = T
#               , color = "white"
#               ,fillColor = ~pal_vacunados(pcias@data$rat_1er_dosis_pob) 
#               , fillOpacity = 1
#               , popup = popupTable(select(pcias@data, c("jurisdiccion_residencia", "rat_1er_dosis_pob", "rat_2da_dosis_pob", "poblacion")), feature.id = FALSE, row.numbers=FALSE)
#               , highlightOptions = highlightOptions(color = "#2c51e6"
#                                                     , weight = 0
#                                                     , fillOpacity = .9)) %>%
#   setView(lat = -35.038216, lng = -65.163000, zoom = 4) %>%
#   addProviderTiles("CartoDB.Positron")
# 
# 
library(rgeos)
library(rgdal)
library(sf)
library(dplyr)
library(simplevis)
library(dplyr)
library(mapview)
library(rmapshaper)
library(leaflet)

#pcias <- st_read("appSalud_review/www/shp/ign_provincia.shp")
pcias  <- readOGR(dsn = "appSalud_review/www/shp/ign_provincia_s.shp", layer = "ign_provincia_s", encoding = "UTF-8")

pcias2 <- rmapshaper::ms_simplify(pcias, keep = 0.05)

leaflet_sf_col(pcias, OBJECTID)

m <- mapview(pcias, zcol = "OBJECTID") 

m@map %>% setView(lat = -35.038216, lng = -65.163000, zoom = 4)


writeOGR(pcias2, ".", "ign_provincia_s", 
         driver = "ESRI Shapefile") 



