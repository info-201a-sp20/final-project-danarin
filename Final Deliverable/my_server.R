library(shiny)
source("temperature_map.R")
source("CAT_chart.R")

server <- function(input, output, session) {
  # Temperature Change Map
  output$temperature_map <- renderPlotly(build_map(input$year))
  
  # Climate Action Tracker Map
  output$bar_chart <- renderPlot(bar_chart(input$year))
}

