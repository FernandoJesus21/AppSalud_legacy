
options(scipen = 6)

#cuerpo del dashboard
body <- dashboardBody(
  
  grey_light_modified,
  
  tabItems(
    tabItem(tabName = "dashboard",
            fluidPage(
              fluidRow(
                module_body_dashboard_kpi_UI("body_dashboard_kpi"),
                column(4, htmlOutput("jurisdiccion")),
                column(4, htmlOutput("depto")),
                column(4, htmlOutput("sexo")),
              ),
              fluidRow(
                module_body_dashboard_st_UI("body_dashboard_st")
              )

            )
 
    ),
    tabItem(tabName = "mapas_vacunados",
            module_body_mapas_vacunados_UI("body_mapas_vacunados")
    ),
    
    tabItem(tabName = "mapas_casos",
            module_body_mapas_casos_UI("body_mapas_casos")
    ),
    tabItem(tabName = "dispersion",
            module_body_tendencias_disp_UI("body_tendencias_disp")
    ),
    tabItem(tabName = "piramide",
            module_body_tendencias_pir_UI("body_tendencias_pir")
    ),
    tabItem(tabName = "about",
            
            module_about_UI("body_about")
    )
  ),
  

    

)










