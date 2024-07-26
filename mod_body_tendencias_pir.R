

module_body_tendencias_pir_UI <- function(id){
  
  ns <- NS(id)
  fluidPage(
    tabsetPanel(type = "tabs",
                tabPanel("decesos", plotlyOutput(ns("pir_decesos"))%>% withSpinner(color=loading_color, image = loading_image2)),
                tabPanel("confirmados y decesos", plotlyOutput(ns("pir_confirmados"))%>% withSpinner(color=loading_color, image = loading_image2)),
                tabPanel("ratio decesos/confirmados", plotlyOutput(ns("pir_ratio"))%>% withSpinner(color=loading_color, image = loading_image2))
                
    )
      
  )
  
  
}



module_body_tendencias_pir_server <- function(id){
  
  moduleServer(
    id,
    function(input, output, session){
      
      output$pir_confirmados <- renderPlotly({
        pos_annotate_Y <- length(unique(tabla_casos_g$rango_etario))
        max_X <- max(tabla_casos_g$cantidad)
        breaks_X <- round(max_X, -(nchar(as.character(max_X))-1))
        ggplotly(ggplot(data = tabla_casos_g, 
                        mapping = aes(x = ifelse(test = sexo == "M", yes = -cantidad, no = cantidad), 
                                      y = rango_etario, fill = tipo)) +
                   geom_col( color = "black", position="stack") +
                   scale_x_symmetric(labels = abs, breaks = seq(-breaks_X, breaks_X, breaks_X/10)) +
                   scale_fill_manual(values=c("#ffba66", "#ff6a3d")) +
                   theme_light() +
                   labs(x = "casos")+
                   labs(title = "Covid19 | Cantidad de fallecidos respecto a casos confirmados",
                        subtitle = "Segregado por grupo etario, por sexo",
                        caption = "Fuente: https://data.buenosaires.gob.ar/dataset/casos-covid-19") +
                   annotate("text", x = breaks_X/2, y = pos_annotate_Y, label = "Mujeres") +
                   annotate("text", x = -breaks_X/2, y = pos_annotate_Y, label = "Hombres"), tooltip = c("none"), height = 550)

        })
      
      output$pir_ratio <- renderPlotly({
        pos_annotate_Y <- length(unique(tc_ratio_fall_vs_conf$rango_etario))
        ggplotly(ggplot(data = tc_ratio_fall_vs_conf, 
                        mapping = aes(x = ifelse(test = sexo == "M", yes = -ratio, no = ratio), 
                                      y = rango_etario)) +
                   geom_col(fill = "#ff82a1", color = "black", position="stack") +
                   scale_x_symmetric(labels = abs, breaks = seq(-1, 1, .1), limits = c(-1, 1)) +
                   #scale_fill_manual(values=c("#ff6a3d")) +
                   theme_light() +
                   labs(x = "ratio: cantidad fallecidos / cantidad de confirmados")+
                   labs(title = "Covid19 | Ratio entre fallecidos y confirmados",
                        subtitle = "Segregado por grupo etario, por sexo",
                        caption = "Fuente: https://data.buenosaires.gob.ar/dataset/casos-covid-19") +
                   annotate("text", x = .2, y = pos_annotate_Y*.1, label = "Mujeres") +
                   annotate("text", x = -.2, y = pos_annotate_Y*.1, label = "Hombres"), tooltip = c("none"), height = 550)
        
      })
      
      output$pir_decesos <- renderPlotly({
        pos_annotate_Y <- length(unique(tabla_casos_ed2$rango_etario))
        max_X <- max(tabla_casos_ed2$cantidad)
        breaks_X <- round(max_X, -(nchar(as.character(max_X))-1))
        ggplotly(ggplot(data = tabla_casos_ed2, 
                        mapping = aes(x = ifelse(test = sexo == "M", yes = -cantidad, no = cantidad), 
                                      y = rango_etario, fill = tipo)) +
                   geom_col( color = "black", position="stack") +
                   scale_x_symmetric(labels = abs, breaks = seq(-breaks_X, breaks_X, breaks_X/10)) +
                   scale_fill_manual(values=c("#ff6a3d")) +
                   theme_light() +
                   labs(x = "casos")+
                   labs(title = "Covid19 | Cantidad de fallecidos",
                        subtitle = "Segregado por grupo etario, por sexo",
                        caption = "Fuente: https://data.buenosaires.gob.ar/dataset/casos-covid-19") +
                   annotate("text", x = breaks_X/2, y = pos_annotate_Y, label = "Mujeres") +
                   annotate("text", x = -breaks_X/2, y = pos_annotate_Y, label = "Hombres"), tooltip = c("none"), height = 550)
        
      })
      
    }
    
  )
  
}



