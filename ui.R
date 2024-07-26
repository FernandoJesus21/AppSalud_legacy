
#Archivo ui.R

#Este script junta todos los componentes de los script 'dashboard_header.R', 'dashboard_sidebar.R' y 'dashboard_body.R'
options(encoding = "UTF-8")
library(shinydashboard)
#modulos
source("mod_header_buttons.R")
source("mod_body_dashboard_kpi.R")
source("mod_body_dashboard_st.R")
source("mod_body_mapas_vacunados.R")
source("mod_body_mapas_casos.R")
source("mod_body_tendencias_disp.R")
source("mod_body_tendencias_pir.R")
source("mod_about.R")
source("dashboardthemes.R")
# 
#secciones dashboard
source("dashboard_header.R")
source("dashboard_sidebar.R")
source("dashboard_body.R")



#junto todo en una funcion
dashboardPage(
    header,
    sidebar,
    body,
    #tags$head(tags$style(HTML('* {font-family: "monospace"};')))
    tags$head(tags$style(HTML("@import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');
                              * {font-family: 'Roboto'};")))
    
)











