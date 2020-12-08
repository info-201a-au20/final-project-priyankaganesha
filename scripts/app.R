# This is the shiny app

# Load Libraries so they are available
library("shiny")
library("plotly")
library("ggplot2")

# Use source() to execute the app 'app_ui.R' and app_server.R

source("app_server.R")
source("app_ui.R")

# Create the shiny app

shinyApp(ui = ui, server = server)