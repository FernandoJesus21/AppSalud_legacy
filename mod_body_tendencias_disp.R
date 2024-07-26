

module_body_tendencias_disp_UI <- function(id){
  
  ns <- NS(id)
  fluidPage(
    tabsetPanel(type = "tabs",
                tabPanel("densidad y puntos", plotOutput(ns("disp_densidad"))%>% withSpinner(color=loading_color, image = loading_image2)),
                tabPanel("tipo raster", plotOutput(ns("disp_raster"))%>% withSpinner(color=loading_color, image = loading_image2)),
                tabPanel("huella de calor", plotOutput(ns("disp_calor"))%>% withSpinner(color=loading_color, image = loading_image2)),
                tabPanel("dispersion", plotOutput(ns("disp_scatter")) %>% withSpinner(color=loading_color, image = loading_image2))
    )
      
  )
  
  
}



module_body_tendencias_disp_server <- function(id){
  
  moduleServer(
    id,
    function(input, output, session){
      

      
      output$disp_scatter <- renderPlot({
        
        ggplot(vista_tendencias_fdisp, aes(x = fecha_fallecimiento, y = edad)) +
          geom_point(size = 1.2, colour = "#c25400", alpha = 0.3) +
          scale_x_datetime(labels = date_format("%m-%Y"), date_breaks = "1 month") +
          scale_y_continuous(breaks = seq(0, 105, 5)) +
          theme_light() +
          theme(axis.text.x=element_text(angle=60, hjust=1, size = 14),
                axis.text.y=element_text(size =14)
          ) +
          labs(title = "Fallecimientos por Covid-19, segun edad",
               caption = "Fuente: https://data.buenosaires.gob.ar/dataset/casos-covid-19")
        }, height = 550)
      
      output$disp_densidad <- renderPlot({
        
        ggplot(vista_tendencias_fdisp, aes(x = fecha_fallecimiento, y = edad)) +
          stat_density_2d(aes(fill = stat(level)), geom = 'polygon') +
          scale_fill_viridis_c(name = "density") +
          geom_point(shape = '.') +
          scale_x_datetime(labels = date_format("%m-%Y"), date_breaks = "1 month") +
          scale_y_continuous(breaks = seq(0, 105, 5)) +
          theme_light() +
          theme(axis.text.x=element_text(angle=60, hjust=1, size = 14),
                axis.text.y=element_text(size =14),
          ) +
          labs(title = "Fallecimientos por Covid-19, segun edad",
               caption = "Fuente: https://data.buenosaires.gob.ar/dataset/casos-covid-19")
        }, height = 550)
      

      
      
      output$disp_calor <- renderPlot({
        
        ggplot(vista_tendencias_fdisp, aes(x = fecha_fallecimiento, y = edad)) +
          stat_density_2d(
            geom = "raster",
            aes(fill = after_stat(density)),
            contour = FALSE
          ) + 
          scale_fill_viridis_c() +
          scale_x_datetime(labels = date_format("%m-%Y"), date_breaks = "1 month") +
          scale_y_continuous(breaks = seq(0, 105, 5)) +
          theme_light() +
          theme(axis.text.x=element_text(angle=60, hjust=1, size = 14),
                axis.text.y=element_text(size =14),
                ) +
          labs(title = "Fallecimientos por Covid-19, segun edad",
               caption = "Fuente: https://data.buenosaires.gob.ar/dataset/casos-covid-19")
        }, height = 550)
      
      output$disp_raster <- renderPlot({
        
        ggplot(vista_tendencias_fdisp, aes(x = fecha_fallecimiento, y = edad)) +
          geom_bin2d(bins = 105) +
          scale_fill_continuous(type = "viridis") +
          scale_x_datetime(labels = date_format("%m-%Y"), date_breaks = "1 month") +
          scale_y_continuous(breaks = seq(0, 105, 5)) +
          theme_light() +
          theme(axis.text.x=element_text(angle=60, hjust=1, size = 14),
                axis.text.y=element_text(size =14),
          ) +
          labs(title = "Fallecimientos por Covid-19, segun edad",
               caption = "Fuente: https://data.buenosaires.gob.ar/dataset/casos-covid-19")
        }, height = 550)
      
      # output$tendencias <- renderDT(
      #   vista_tendencias_fdisp
      # )
      
      # sel_tend <- reactive({
      #   
      #   data <- tabla_casos %>%
      #     select(edad, edad_anios_meses, fecha_fallecimiento, clasificacion_resumen) %>%
      #     filter(!is.na(fecha_fallecimiento)) %>%
      #     filter(grepl('a', edad_anios_meses)) %>%
      #     filter(clasificacion_resumen == "Confirmado") %>%
      #     mutate(fecha_fallecimiento = fastPOSIXct(fecha_fallecimiento)) %>%
      #     mutate(edad = as.numeric(edad)) %>%
      #     select(-c("edad_anios_meses", "clasificacion_resumen")) %>%
      #     filter(edad < 108)
      #   
      # })
      
    }
    
  )
  
}



