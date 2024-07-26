
library(shiny)


shinyServer(function(input, output, session) {
  
    output$jurisdiccion <- renderUI({
      
      selectInput(
        inputId = "jurisdiccion", 
        label = "jurisdiccion:",
        choices = as.character(unique(selector_compuesto$jurisdiccion_residencia)),
        selected = "Todo",
        selectize = T)
    })
    
    disponible <- reactive({
        disponible <- arrange(filter(selector_compuesto, selector_compuesto$jurisdiccion_residencia %in% input$jurisdiccion), depto_residencia)
    })
    
    output$depto <- renderUI({
      
      selectInput(
        inputId = "depto", 
        label = "Departamento:",
        choices = disponible()$depto_residencia,
        selected = "Todo"
      )
    })
    
    output$sexo <- renderUI({
      
      selectInput(
        inputId = "sexo", 
        label = "genero:",
        choices = c("Todo", "M", "F"),
        selected = "Todo",
        selectize = T)
      
    })
    
    
    #REACTIVO PARA KPI
    sel_kpi <- reactive({
      if(length(input$depto) > 0){
        if(input$jurisdiccion != "Todo"){
          if(input$depto != "Todo"){
            data <- filter(vista_dashboard_kpi, vista_dashboard_kpi$jurisdiccion_residencia %in% input$jurisdiccion &
                             vista_dashboard_kpi$depto_residencia %in% input$depto)
          }else{
            data <- filter(vista_dashboard_kpi, vista_dashboard_kpi$jurisdiccion_residencia %in% input$jurisdiccion)
          }
        }else{
          data <- vista_dashboard_kpi
        }
      }
    })
    
    #REACTIVO 1 PARA KPI
    sel_kpi1 <- reactive({
      if(length(input$sexo) != 0){
        if(input$sexo != "Todo"){
          data <- filter(sel_kpi(), sel_kpi()$sexo == input$sexo)
        }else{
          data <- sel_kpi()
        }
      }
    })
    
    
    #REACTIVO PARA ST
    sel_st <- reactive({
      if(length(input$depto) > 0){
        if(input$jurisdiccion != "Todo"){
          if(input$depto != "Todo"){
            data <- filter(vista_dashboard_st, vista_dashboard_st$jurisdiccion_residencia %in% input$jurisdiccion &
                             vista_dashboard_st$depto_residencia %in% input$depto)
          }else{
            data <- filter(vista_dashboard_st, vista_dashboard_st$jurisdiccion_residencia %in% input$jurisdiccion)
          }
        }else{
          data <- vista_dashboard_st
        }
      }
    })
    
    #REACTIVO 1 PARA ST
    sel_st1 <- reactive({
      if(length(input$sexo) != 0){
        if(input$sexo != "Todo"){
          data <- filter(sel_st(), sel_st()$sexo == input$sexo)
        }else{
          data <- sel_st()
        }
      }
    })
    
    ############################
    #modulos
    callModule(module_header_buttons_server, "header_buttons")
    module_body_dashboard_kpi_server("body_dashboard_kpi", sel_kpi1)
    module_body_dashboard_st_server("body_dashboard_st", sel_st1)
    
    module_body_mapas_vacunados_server("body_mapas_vacunados")
    module_body_mapas_casos_server("body_mapas_casos")
    
    module_body_tendencias_disp_server("body_tendencias_disp")
    module_body_tendencias_pir_server("body_tendencias_pir")
    
    module_about_server("body_about")
    
})






