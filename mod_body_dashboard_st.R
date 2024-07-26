

module_body_dashboard_st_UI <- function(id){
  
  ns <- NS(id)
  tagList(
    #h2("Esto viene del modulo st"),
    # tags$style(type="text/css",
    #            ".shiny-output-error { visibility: hidden; }",
    #            ".shiny-output-error:before { visibility: hidden; }"
    # ),
    dygraphOutput(ns("body_dashboard_st"))
  )
  
}

module_body_dashboard_st_server <- function(id, dataF){
  
  moduleServer(
    id,
    function(input, output, session){

      output$body_dashboard_st <- renderDygraph({
          dygraph(sel_body_dashboard_st(), main = "Aplicaciones de vacunas") %>%
            dyHighlight(highlightSeriesOpts = list(strokeWidth = 3)) %>% 
            dyRangeSelector()
      })
      
      sel_body_dashboard_st <- reactive({
        if(!is.null(dataF())){
          if(nrow(dataF()) != 0){
            data <- dataF()[, .(cantidad=sum(cantidad_aplicaciones)), by=list(a_o, mes, dia, vacuna)] %>%
              mutate(date = as.Date(paste(a_o, "-", mes, "-", dia, sep = ""), format = "%Y-%m-%d")) %>%
              mutate_at(vars(-date), as.character) %>%
              dcast(date ~ vacuna, value.var = "cantidad") %>%
              replace(is.na(.), 0) %>%
              mutate_at(vars(-date), as.numeric)
          }else{
            data <- data.table("data" = as.Date("2021-09-01"), "cantidad" = 0)
          }
        }else{
          data <- data.table("data" = as.Date("2021-09-01"), "cantidad" = 0)
        }
      })
      
      return(sel_body_dashboard_st)
      
    }
    
  )
  
}


