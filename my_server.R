library(shiny)
source("scripts/temperature-chart.R")
source("scripts/temperature_map.R")
source("scripts/CAT_data.R")
source("scripts/CAT_chart.R")
source("scripts/recycle_tab_data.R")
source("scripts/chart_3.R")


# Server funcion
server <- function(input, output, session) {
  # Temperature Change Map
  output$temperature_map <- renderPlotly(build_map(input$year_choice))

  # Climate Action Tracker Map
  output$bar_chart <- renderPlotly(bar_chart(input$year))

  # Recycle page
  output$percent_recycle <- renderPlotly({
    filtered <- avg_recycle_waste[avg_recycle_waste$Country ==
      input$recycle_country, c(
      "avg_recycled",
      "avg_waste"
    )]
    filtered <- gather(filtered, "country", "value")
    plot_ly(
      data = filtered,
      x = ~country,
      y = ~value,
      type = "bar"
    ) %>%
      layout(
        title = "Recycled Waste vs Total Waste",
        xaxis = list(title = "Waste Category"),
        yaxis = list(title = "Amount of waste (tonne)"),
        margin = list(t = 75)
      )
  })

  # Summary page for temperature map
  output$map <- renderPlot(map)

  # Summary page for waste generation
  output$p <- renderPlotly(p)

  # Summary page for recycle page
  output$correlation_graph <- renderPlotly(correlation_plot)
}
