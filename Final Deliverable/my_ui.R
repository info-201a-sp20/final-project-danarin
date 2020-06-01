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
  fluid = TRUE,
  sidebarLayout(
    sidebarPanel(
      h4("TEMPERATURE CHANGE BY YEAR"),
      p(""),
      sliderInput(
        inputId = "year",
        label = "Year",
        min = 1743,
        max = 2013,
        value = 1878
      ),
      h4("QUESTIONS"),
      p("- Which part of the world is being affected by global
        warming the most?"),
      h4("RESULTS"),
      p("")
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
