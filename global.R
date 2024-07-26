
#APP SALUD REVIEW
if(exists("con")){
  dbDisconnect(con)
}
rm(list = ls())


modo_de_pruebas <- T
caso_de_prueba <- "archivos_originales"

library(dashboardthemes)
library(lemon)
library(DT)
library(RPostgres)
library(RPostgreSQL)
library(dygraphs)
library(tableHTML)
library(dplyr)
library(leafpop)
library(shiny)
library(leaflet)
library(leafpop)
library(sf)
library(scales)
library(ggplot2)
library(plotly)
library(shinycssloaders)
library(data.table)
library(readr)
library(arules)
library(fasttime)
library(lubridate)
library(mapview)
#configuro los thread del CPU a usar
setDTthreads(threads = 7, restore_after_fork = T, throttle = 1024)
#verifico que los cambios esten correctos
#getDTthreads(verbose = getOption("datatable.verbose"))
cat("--- Modo de pruebas: ", modo_de_pruebas, "\n")
cat("--- Usando actualmente : [", getDTthreads(verbose = getOption("datatable.verbose")), "] threads de procesamiento para data.table \n")

loading_color <- "#0dc5c1"
type_loading <- 8
loading_image <- "Double Ring-1s-118px.gif"
loading_image2 <- "Blocks-0.8s-74px.gif"

###########################################################################

inicio_db_carga <- Sys.time()



##########################################################################

if(modo_de_pruebas){
  vista_dashboard_kpi <- as.data.table(read_csv(paste("lote_de_prueba/", caso_de_prueba , "/entrada/vista_dashboard_kpi.csv", sep = ""), 
                                                col_types = cols(sexo = col_character(), 
                                                                 jurisdiccion_residencia = col_character(), 
                                                                 orden_dosis = col_character())))
  
  vista_dashboard_st <- as.data.table(read_csv(paste("lote_de_prueba/", caso_de_prueba , "/entrada/vista_dashboard_st.csv", sep = ""), 
                                               col_types = cols(fecha_aplicacion = col_character(), 
                                                                sexo = col_character())))
  #############
  
  vista_map_vacunados <- as.data.table(read_csv(paste("lote_de_prueba/", caso_de_prueba , "/entrada/vista_map_vacunados.csv", sep = ""), 
                                                col_types = cols(orden_dosis = col_character())))
  vista_map_casos <- as.data.table(read_csv(paste("lote_de_prueba/", caso_de_prueba , "/entrada/vista_map_casos.csv", sep = ""), show_col_types = FALSE))
  #############
  vista_tendencias_fdisp <- as.data.table(read_csv(paste("lote_de_prueba/", caso_de_prueba , "/entrada/vista_tendencias_fdisp.csv", sep = ""), 
                                                   col_types = cols(edad = col_character(), 
                                                                    fecha_fallecimiento = col_character())))
  vista_tendencias_fpir <- as.data.table(read_csv(paste("lote_de_prueba/", caso_de_prueba , "/entrada/vista_tendencias_fpir.csv", sep = ""), 
                                                  col_types = cols(sexo = col_character(), 
                                                                   edad = col_character(), fecha_fallecimiento = col_character())))
}else{
  
  db <- 'covid19db'
  host_db <- '127.0.0.1'
  db_port <- '5432'
  db_user <- 'postgres'
  db_password <- 'admin'
  con <- dbConnect(RPostgres::Postgres(), dbname = db, host=host_db, port=db_port, user=db_user, password=db_password)
  dbListTables(con)
  
  vista_dashboard_kpi <- as.data.table(dbGetQuery(con, 'SELECT * FROM vista_kpi'))
  vista_dashboard_st <- as.data.table(dbGetQuery(con, 'SELECT * FROM vista_st'))
  ##############
  vista_map_vacunados <- as.data.table(dbGetQuery(con, 'SELECT * FROM vista_map_vacunados;'))
  vista_map_casos <- as.data.table(dbGetQuery(con, 'SELECT * FROM vista_map_contagios;'))
  ##############
  vista_tendencias_fdisp <- as.data.table(dbGetQuery(con, 'SELECT * FROM vista_tendencias_fdispersion;'))
  vista_tendencias_fpir <- as.data.table(dbGetQuery(con, 'SELECT * FROM vista_tendencias_fpiramide;'))
}



fin_db_carga <- Sys.time()
te_db_carga <- fin_db_carga - inicio_db_carga 
cat("--- Fin de carga de tablas desde DB, tiempo: ", te_db_carga, " segs. \n")

#########################################################################

inicio_tvac_trans <- Sys.time()

#conversion a factor
vista_dashboard_kpi$jurisdiccion_residencia <- as.factor(vista_dashboard_kpi$jurisdiccion_residencia)
vista_dashboard_st$jurisdiccion_residencia <- as.factor(vista_dashboard_st$jurisdiccion_residencia)

vista_dashboard_st$vacuna <- as.factor(vista_dashboard_st$vacuna)

vista_dashboard_st$fecha_aplicacion <- fastPOSIXct(fast_strptime(vista_dashboard_st$fecha_aplicacion, format = "%Y-%m-%d"))
vista_dashboard_st$value <- 1
vista_dashboard_st$dia <- lubridate::day(vista_dashboard_st$fecha_aplicacion)
vista_dashboard_st$mes <- lubridate::month(vista_dashboard_st$fecha_aplicacion)
vista_dashboard_st$a_o <- lubridate::year(vista_dashboard_st$fecha_aplicacion)


#selecciono las jurisdicciones y creo una entrada adicional para cada una: "Todo"
selector_jurisdiccion <- unique(select(vista_dashboard_kpi, jurisdiccion_residencia))
selector_jurisdiccion$depto_residencia <- "Todo"
#creo el selector compuesto con cada depto de cada jurisdiccion, a continuacion le agrego las entradas adicionales creadas
selector_compuesto_o <- unique(select(vista_dashboard_kpi, jurisdiccion_residencia, depto_residencia))
selector_compuesto <- rbind(selector_compuesto_o, selector_jurisdiccion)
opcion_todo <- data.frame("jurisdiccion_residencia" = "Todo", "depto_residencia" = "Todo")
selector_compuesto <- arrange(rbind(selector_compuesto, opcion_todo), jurisdiccion_residencia)


fin_tvac_trans <- Sys.time()
te_tvac_trans <- fin_tvac_trans - inicio_tvac_trans 
cat("--- Fin de procesamiento de datos (Tabla vacunados), tiempo: ", te_tvac_trans, " segs. \n")

########################################################################
#ARCHIVO anexo a mod_body_mapas.R

#responsable de cargar los elementos necesarios y conformar el modelo de datos
# a utilizar para graficar los mapas de calor y las tablas de la seccion "mapas"
gl_mdata_mapas_i <- Sys.time()
source("gl_mdata_mapas.R", local = TRUE)
gl_mdata_mapas_f <- Sys.time()
gl_mdata_mapas_R <- gl_mdata_mapas_f - gl_mdata_mapas_f
cat("--- Fin de procesamiento de modulo |gl_mdata_mapas|, tiempo: ", gl_mdata_mapas_R, " segs. \n")

gl_mdata_tendencias_i <- Sys.time()
source("gl_mdata_tendencias.R", local = TRUE)
gl_mdata_tendencias_f <- Sys.time()
gl_mdata_tendencias_R <- gl_mdata_tendencias_f - gl_mdata_tendencias_i
cat("--- Fin de procesamiento de modulo |gl_mdata_tendencias|, tiempo: ", gl_mdata_tendencias_R, " segs. \n")


gl_mdata_about_i <- Sys.time()
source("gl_mdata_about.R", local = TRUE)
gl_mdata_about_f <- Sys.time()
gl_mdata_about_R <- gl_mdata_about_f - gl_mdata_about_i
cat("--- Fin de procesamiento de modulo |gl_mdata_about.R|, tiempo: ", gl_mdata_about_R, " segs. \n")


########################################################################



