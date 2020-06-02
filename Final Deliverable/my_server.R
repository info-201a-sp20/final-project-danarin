library(shiny)
source("temperature_map.R")
source("CAT_chart.R")
source("recycle_tab_data.R")


#Server funcion
server <- function(input, output, session) {
  # Temperature Change Map
  output$temperature_map <- renderPlotly(build_map(input$year))
  
  # Climate Action Tracker Map
  output$bar_chart <- renderPlot(bar_chart(input$year))
  
  #Recycle page 
  output$percent_recycle <- renderPlotly({
    filtered = df[df$Country == input$recycle_country, c("avg_recycled",
                                                         "avg_waste")]
    filtered <- gather(filtered, "country", "value")
    plot_ly(data = filtered,
            x = ~country,
            y = ~value,
            type = "bar") %>% 
    layout(title = "Recycled Waste vs Total Waste",
           xaxis = list(title = "Waste Category"),
           yaxis = list(title = "Amount of waste (tonne)"),
           margin = list(t = 75))
  })
}


