
module_about_UI <- function(id){
  
  ns <- NS(id)
  
  
  fluidPage(

    tabsetPanel(type = "tabs",
                tabPanel("about", 
                         h2("Acerca de la aplicacion"),
                         box( width = 12,
                              img(style = "margin-left:10px;margin-right:10px;margin-bottom:10px;",
                                  src='logo.png', width="351", height="184", align = 'right'),
                              sidebarPanel( position = "right", width = 7,
                                paste0("======================================"),
                                br(),
                                "Editor: Fernando J. Heredia",
                                br(),
                                "Version: 0.9 beta",
                                br(),
                                paste0("Fecha de compilacion: ", Sys.time()),
                                br(),
                                paste0("Fecha de actualizacion de datos: ", "2021-11-06"),
                                br(),
                                paste0("======================================"),
                                style = "color:black",
                                br(),
                                "Origen de los datos utilizados:",
                                br(),
                                tableHTML(data.frame("Descripción" = c("casos covid19", "aplicaciones de vacunas covid19"),
                                                     "Fuente" = c("Ministerio de salud de la nación", "Ministerio de salud de la nación - NOMIVAC"),
                                                     "Enlaces" = c( "<a href='http://datos.salud.gob.ar/dataset/covid-19-casos-registrados-en-la-republica-argentina/archivo/fd657d02-a33a-498b-a91b-2ef1a68b8d16 'target='_blank' >Acceder</a>",
                                                                    "<a href='http://datos.salud.gob.ar/dataset/vacunas-contra-covid19-dosis-aplicadas-en-la-republica-argentina/archivo/e4515c25-e1fd-4f02-b1c1-5453c36eada6 'target='_blank' >Acceder</a>")
                                ), escape = F)
                              ),
                         ),#fin box
                         box( width = 12,
                              sidebarPanel( position = "right", width = 12,
                                  
                                  "App Salud es una herramienta que permite observar el avance de la pandemia del covid19 en la Argentina. Proporciona diversas visualizaciones acerca del estado de situación por jurisdicción, según las vacunaciones hechas o los casos registrados hasta la fecha."

                              )
                         ),
                         img(style = "margin-left:30px;margin-right:10px;margin-bottom:10px;",
                             src='Rlogo.png', width="80", height="80", align = 'left'),
                         img(style = "margin-left:10px;margin-right:10px;margin-bottom:10px;",
                             src='shiny_logo.png', width="80", height="90", align = 'left'),
                         img(style = "margin-left:10px;margin-right:0px;margin-bottom:10px;",
                             src='posgresql_logo.png', width="160", height="80", align = 'left'),
                         img(style = "margin-left:10px;margin-right:0px;margin-bottom:10px;",
                             src='leaflet-1-logo.png', width="160", height="100", align = 'left'),
                         img(style = "margin-left:10px;margin-right:10px;margin-bottom:10px;",
                             src='dygraphs_logo.png', width="160", height="80", align = 'left'),
                         img(style = "margin-left:10px;margin-right:10px;margin-bottom:10px;",
                             src='ggplot2_logo.png', width="80", height="90", align = 'left'),
                         img(style = "margin-left:10px;margin-right:10px;margin-bottom:10px;",
                             src='1200px-Plotly-logo-01-square.png', width="200", height="80", align = 'left'),
                         box(width = 12)
                         
                ),
                tabPanel("detalles", 
                         div(DTOutput(ns("body_about")), style = "font-size:80%")
                )
                
    )
    
  )
  
}



module_about_server <- function(id){
  
  moduleServer(
    id,
    function(input, output, session){
      
      output$body_about = renderDT(
        about, filter = 'none', rownames = F,
        options = list(
                       #dom = 'Blfrtip',
                       autoWidth = TRUE,
                       scrollX = TRUE,
                       pageLength = 25,
                       lengthChange = FALSE,
                       searching = FALSE
                       ),
        escape = FALSE,
        selection = "none",
        class = "display nowrap compact"
      )
    
      
    }
    
  )
  
}






