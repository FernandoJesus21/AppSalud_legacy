
#menu del dashboard
sidebar <- dashboardSidebar(
  width = 150,
  #tags$style("@import url(https://use.fontawesome.com/releases/v5.7.2/css/all.css);"),
  sidebarMenu(
    id = "sbmenu",
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard", verify_fa = F)),
    menuItem("Mapas", icon = icon("map"),
             menuSubItem("Vacunados", tabName = "mapas_vacunados"),
             menuSubItem("Contagios", tabName = "mapas_casos")
             ),
    menuItem("Tendencias", icon = icon("globe-americas"),
            menuSubItem("La pandemia", tabName = "dispersion"),
            menuSubItem("Casos", tabName = "piramide")
    ),
    menuItem("Acerca de...", icon = icon("question-circle"), tabName = "about")
    
  )
)









