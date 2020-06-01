library(shiny)

ui <- fluidPage(
  titlePanel(""),
  tabsetPanel(
    # Intro tab
    temperature_tab
    # chart 2 tab
    # chart 3 tab
    # summary tab
  )
)

temperature_tab <- tabPanel(
  "Temperature Change Map",
  sidebarLayout(
    sidebarPanel(
      h3("TEMPERATURE CHANGE BY YEAR"),
      h4("QUESTION"),
      p("- Which part of the world is being affected by global
        warming the most?"),
      sliderInput(
        inputId = "year",
        label = "Year",
        min = 1743,
        max = 2013,
        value = 1878
      ),
      p("This map is used to see which country in the world is being
        affected by global warming the most. Select a year to view how each
        country's average temperature changed throughout the year (in
        celsius). Hover over a country on the map to see the exact change
        in temperature.")
    ),
    
    mainPanel(
      plotlyOutput(
        outputId = "temperature_map",
        height = 600,
        width = 900
      )
    )
  )
)
