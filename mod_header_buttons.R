

module_header_buttons_UI <- function(id){
  ns <- NS(id)
  
  tags$li(class = "dropdown",
          
          tags$li(class = "dropdown",
                  actionLink(inputId = ns("show"),
                             label = "Documentacion"
                  )
                  
          )
          
  )#fin tags$li principal
}

module_header_buttons_server <- function(input, output, session){
  
  observeEvent(input$show, {
    showModal(modalDialog(
      title = "Documentacion de usuario",
      size = "l",
      tags$iframe(style="height:500px; width:100%; scrolling=yes", src="manual_de_usuario.pdf"),
      footer = modalButton("Volver", icon = icon("reply")),
      easyClose = T,
      fade = T)
    )
  })
  
  
}









