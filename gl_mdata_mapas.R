
inicio_mdata_mapas <- Sys.time()

#leo el shp de provincias
#pcias  <- readOGR(dsn = "appSalud/www/shp/ign_provincia.shp", layer = "ign_provincia", encoding = "UTF-8")
pcias  <- st_read("www/shp/ign_provincia_s.shp")
#provincias <- read_csv("appSalud/www/csv/provincias.csv", col_types = cols(OBJECTID = col_character()))
provincias <- read_csv("www/csv/provincias.csv", col_types = cols(OBJECTID = col_character()))

pcias <- left_join(pcias, select(provincias, -jurisdiccion_residencia), by = c("OBJECTID"))


###############################################################################################################

# if(modo_de_pruebas){
#   vista_map_vacunados <- as.data.table(read_csv(paste("lote_de_prueba/", caso_de_prueba , "/entrada/vista_map_vacunados.csv", sep = ""), 
#                                                 col_types = cols(orden_dosis = col_character())))
#   vista_map_casos <- as.data.table(read_csv(paste("lote_de_prueba/", caso_de_prueba , "/entrada/vista_map_casos.csv", sep = ""), show_col_types = FALSE))
# }else{
#   vista_map_vacunados <- as.data.table(dbGetQuery(con, 'SELECT * FROM vista_map_vacunados;'))
#   vista_map_casos <- as.data.table(dbGetQuery(con, 'SELECT * FROM vista_map_contagios;'))
# }



################################################################################################################

#agrupo los datos que quiero mostrar en el mapa de calor
vista_map_vacunados_m <- vista_map_vacunados[, .(cantidad = sum(cantidad_aplicaciones)), by=list(jurisdiccion_residencia, orden_dosis)] %>%
  mutate(orden_dosis = paste("dosis_", orden_dosis, sep = "")) %>%
  dcast(jurisdiccion_residencia ~ orden_dosis, value.var = "cantidad") %>%
  left_join(provincias, by = c("jurisdiccion_residencia")) %>%
  mutate(rat_1er_dosis_pob = dosis_1 / poblacion) %>%
  mutate(rat_2da_dosis_pob = dosis_2 / poblacion)

#hago junta de la lt con los datos de los poligonos
pcias <- left_join(pcias, select(vista_map_vacunados_m, -poblacion), by = c("OBJECTID"))

cr <- colorRampPalette(colors = c("#c9e3ff", "#053f7d"), space = "Lab")(24)

pal_vacunados <- colorNumeric(palette = cr, domain = pcias$rat_1er_dosis_pob)

###########################################################
#PARA LOS CONTAGIOS POR COVID:

#paso a factor
vista_map_casos$residencia_provincia_nombre <- as.factor(vista_map_casos$residencia_provincia_nombre)
vista_map_casos$clasificacion_resumen <- as.factor(vista_map_casos$clasificacion_resumen)
#agrupo por jurisdiccion y tipo de caso
#tabla_casos_gr1 <- tabla_casos[, .(cantidad = sum(.N)), by= list(residencia_provincia_nombre, clasificacion_resumen)]

vista_map_casos_m <- dcast(vista_map_casos, residencia_provincia_nombre ~ clasificacion_resumen, value.var = "cantidad_contagios") %>%
  left_join(provincias, by = c("residencia_provincia_nombre" = "jurisdiccion_residencia")) %>%
  mutate(rat_confirmados_pob = Confirmado / poblacion) %>%
  mutate(rat_sospechoso_pob = Sospechoso / poblacion) %>%
  mutate(rat_descartado_pob = Descartado / poblacion)

pcias <- left_join(pcias, select(vista_map_casos_m, -poblacion), by = c("OBJECTID"))

cr1 <- colorRampPalette(colors = c("#ffc4b3", "#a32702"), space = "Lab")(24)

pal_casos <- colorNumeric(palette = cr1, domain = pcias$rat_confirmados_pob)

##################################################################################
rm(opcion_todo, provincias, selector_compuesto_o, selector_jurisdiccion)

fin_mdata_mapas <- Sys.time()
te_mdata_mapas <- fin_mdata_mapas - inicio_mdata_mapas 
cat("--- Fin creacion del modelo de datos para los mapas, tiempo: ", te_mdata_mapas, " segs. \n")






m <- mapview(pcias, zcol = "rat_1er_dosis_pob") 

















