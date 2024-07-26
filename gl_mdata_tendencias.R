


#CONTRUCCION DEL MODELO DE DATOS, para los graficos tipo dispersion/densidad


# if(modo_de_pruebas){
#   vista_tendencias_fdisp <- as.data.table(read_csv(paste("lote_de_prueba/", caso_de_prueba , "/entrada/vista_tendencias_fdisp.csv", sep = ""), 
#                                                    col_types = cols(edad = col_character(), 
#                                                                     fecha_fallecimiento = col_character())))
#   vista_tendencias_fpir <- as.data.table(read_csv(paste("lote_de_prueba/", caso_de_prueba , "/entrada/vista_tendencias_fpir.csv", sep = ""), 
#                                                   col_types = cols(sexo = col_character(), 
#                                                                    edad = col_character(), fecha_fallecimiento = col_character())))
# }else{
#   vista_tendencias_fdisp <- as.data.table(dbGetQuery(con, 'SELECT * FROM vista_tendencias_fdispersion;'))
#   vista_tendencias_fpir <- as.data.table(dbGetQuery(con, 'SELECT * FROM vista_tendencias_fpiramide;'))
# }


vista_tendencias_fdisp <- vista_tendencias_fdisp %>%
  mutate(fecha_fallecimiento = fastPOSIXct(fecha_fallecimiento)) %>%
  mutate(edad = as.numeric(edad)) %>%
  filter(edad < 108) %>%
  filter(edad > 0)



###################################################################################
#CONTRUCCION DEL MODELO DE DATOS, para los graficos tipo piramide

tabla_casos_ed2 <- vista_tendencias_fpir %>%
  select(edad, sexo, fecha_fallecimiento, clasificacion_resumen, cantidad_casos) %>%
  filter(!is.na(fecha_fallecimiento)) %>%
  #filter(grepl('a', `edad_anios_meses`)) %>%
  filter(clasificacion_resumen == "Confirmado") %>%
  mutate(fecha_fallecimiento = fastPOSIXct(fecha_fallecimiento)) %>%
  mutate(edad = as.numeric(edad)) %>%
  select(-c("clasificacion_resumen")) %>%
  filter(edad < 108) %>%
  filter(edad > 0) %>%
  mutate(edad = discretize(edad, breaks = c(0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110), method = "fixed")) %>%
  group_by(sexo, edad) %>%
    summarise(tipo = "fallecidos",
              cantidad = sum(cantidad_casos)) %>%
  #filter(!is.na(edad)) %>%
  #filter(sexo != "NR") %>%
  setnames(old = "edad", new = "rango_etario") %>%
  mutate(cantidad = as.numeric(cantidad))

tabla_casos_ed3 <- vista_tendencias_fpir %>%
  select(edad, sexo, fecha_fallecimiento, clasificacion_resumen, cantidad_casos) %>%
  filter(is.na(fecha_fallecimiento)) %>%
  #filter(grepl('a', `edad_anios_meses`)) %>%
  filter(clasificacion_resumen == "Confirmado") %>%
  #mutate(fecha_fallecimiento = fastPOSIXct(fecha_fallecimiento)) %>%
  mutate(edad = as.numeric(edad)) %>%
  select(-c("clasificacion_resumen")) %>%
  filter(edad < 108) %>%
  filter(edad > 0) %>%
  mutate(edad = discretize(edad, breaks = c(0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110), method = "fixed")) %>%
  group_by(sexo, edad) %>%
  summarise(tipo = "confirmados",
            cantidad = sum(cantidad_casos)) %>%
  filter(!is.na(edad)) %>%
  #filter(sexo != "NR") %>%
  setnames(old = "edad", new = "rango_etario")%>%
  mutate(cantidad = as.numeric(cantidad))


tabla_casos_g <- rbind(tabla_casos_ed2, tabla_casos_ed3)


tc_ratio_fall_vs_conf <- tabla_casos_ed2 %>%
          setnames(old = "cantidad", new = "cant_fallecidos") %>%
          select(-tipo) %>%
          left_join(select(tabla_casos_ed3, -tipo), by = c("sexo", "rango_etario")) %>%
          setnames(old = "cantidad", new = "cant_confirmados") %>%
          mutate(ratio = cant_fallecidos / (cant_confirmados + cant_fallecidos))

tabla_casos_ed2 %>%
  setnames(old = "cant_fallecidos", new = "cantidad")




