

module_body_mapas_vacunados_UI <- function(id){
  
  ns <- NS(id)
  
  fluidPage(
    
    fluidRow(
      
      leafletOutput(ns("body_mapas_vacunados_heatmap"))%>% withSpinner(color=loading_color, image = loading_image)
    ),
    fluidRow(
      DTOutput(ns("body_mapas_vacunados"))
      
    )
    
  )

}


module_body_mapas_vacunados_server <- function(id){
  
  moduleServer(
    id,
    function(input, output, session){
      
      output$body_mapas_vacunados = renderDT(
        vista_map_vacunados, filter = 'top', rownames = F,
        extensions = 'Buttons',
        options = list(dom = 'Blfrtip',
                       buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                       lengthMenu = list(c(10,25,50,-1),
                                         c(10,25,50,"All"))),
        server = TRUE,
        class = "display nowrap compact"
      )
      
      output$body_mapas_vacunados_heatmap <- renderLeaflet({
        
        leaflet(pcias) %>%
          addTiles() %>%
          addPolygons(weight = 2
                      , stroke = T
                      , color = "white"
                      ,fillColor = ~pal_vacunados(pcias$rat_1er_dosis_pob)
                      , fillOpacity = 1
                      , popup = popupTable(select(pcias, c("jurisdiccion_residencia", "rat_1er_dosis_pob", "rat_2da_dosis_pob", "poblacion")), feature.id = FALSE, row.numbers=FALSE)
                      , highlightOptions = highlightOptions(color = "#2c51e6"
                                                            , weight = 0
                                                            , fillOpacity = .9)) %>%
          setView(lat = -35.038216, lng = -65.163000, zoom = 4) %>%
          addProviderTiles("CartoDB.Positron")
        
        
        #m@map %>% setView(lat = -35.038216, lng = -65.163000, zoom = 4)
        
        
      })
      
    }
    
  )
  
}




