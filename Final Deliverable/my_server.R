library(shiny)
source("temperature_map.R")

server <- function(input, output, session) {
  # Temperature Change Map
  output$temperature_map <- renderPlotly(build_map(input$year))
}
