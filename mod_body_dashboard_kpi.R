
##########################################################
#
# Modulo: body_dashboard_kpi
# Se encarga de contruir y actualizar los indicadores de:
# - cantidad de vacunados 1er dosis
# - cantidad de vacunados 2da dosis
# - cantidad de aplicaciones
#
# Version 1.0
##########################################################

colorInfoBoxes <- "blue"

module_body_dashboard_kpi_UI <- function(id){
  
  ns <- NS(id)
  tagList(
    valueBoxOutput(ns("body_dashboard_kpi_1erDosis")),
    valueBoxOutput(ns("body_dashboard_kpi_2daDosis")),
    valueBoxOutput(ns("body_dashboard_kpi_totalAplicaciones"))
  )
  
}

module_body_dashboard_kpi_server <- function(id, dataF){
  
  moduleServer(
    id,
    function(input, output, session){
      
      #render del indicador de cant. vacunados 1er dosis
      output$body_dashboard_kpi_1erDosis <- renderValueBox({
        infoBox(
          "Vacunados 1er dosis",
          sel_body_dashboard_kpi_vac1erDosis(),
          color = colorInfoBoxes, fill = F, icon = icon("angle-right")
        )
      })
      
      #modelo de datos que consume el indicador de cant vacuandos 1er dosis
      sel_body_dashboard_kpi_vac1erDosis <- reactive({
        if(!is.null(dataF())){
          if(nrow(dataF()) != 0){
            #data <- format(as.double(dataF()[, .(cantidad = sum(cantidad_aplicaciones)), by=list(orden_dosis)]$cantidad[1]), big.mark=".", decimal.mark = ",")
            data <- dataF()[, .(cantidad = sum(cantidad_aplicaciones)), by=list(orden_dosis)] %>% 
              filter(orden_dosis == "1")
            if(nrow(data) == 0){
              data <- 0
            }else{
              data <- format(as.double(data$cantidad), big.mark=".", decimal.mark = ",")
            }
            #data <- ifelse(nrow(data) == 0, 0, data$cantidad)
          }else{
            data <- 0
          }
        }else{
          data <- "cargando..."
        }
      })
      
      #render del indicador de cant. vacunados 2da dosis
      output$body_dashboard_kpi_2daDosis <- renderValueBox({
        infoBox(
          "Vacunados 2da dosis",
          sel_body_dashboard_kpi_vac2daDosis(),
          color = colorInfoBoxes, fill = F, icon = icon("angle-double-right")
        )
      })
      
      #modelo de datos que consume el indicador de cant vacuandos 2da dosis
      sel_body_dashboard_kpi_vac2daDosis <- reactive({
        if(!is.null(dataF())){
          if(nrow(dataF()) != 0){
            #data <- format(as.double(dataF()[, .(cantidad = sum(cantidad_aplicaciones)), by=list(orden_dosis)]$cantidad[2]), big.mark=".", decimal.mark = ",")
            data <- dataF()[, .(cantidad = sum(cantidad_aplicaciones)), by=list(orden_dosis)] %>% 
              filter(orden_dosis == "2")
            if(nrow(data) == 0){
              data <- 0
            }else{
              data <- format(as.double(data$cantidad), big.mark=".", decimal.mark = ",")
            }
            #data <- ifelse(nrow(data) == 0, 0, data$cantidad)
          }else{
            data <- 0
          }
        }else{
          data <- "cargando..."
        }
      })
      
      
      #render del indicador de cant. aplicaciones
      output$body_dashboard_kpi_totalAplicaciones <- renderValueBox({
        infoBox(
          "Total aplicaciones", 
          sel_body_dashboard_kpi_totalAplicaciones(),
          color = colorInfoBoxes, fill = F, icon = icon("briefcase-medical")
        )
      })
      
      #modelo de datos que consume el indicador de cant de aplicaciones
      sel_body_dashboard_kpi_totalAplicaciones <- reactive({
        if(!is.null(dataF())){
          data <- format(as.double(dataF()[, .(cantidad = sum(cantidad_aplicaciones)), by=list()]$cantidad[1]), big.mark=".", decimal.mark = ",")
        }else{
          data <- "cargando..."
        }
      })
      
      
    }
    
  )
  
}


