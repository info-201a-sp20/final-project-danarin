library(shiny)
library(plotly)
library(ggplot2)

ui <- fluidPage(
  titlePanel(""),
  tabsetPanel(
    intro_tab,
    temperature_tab,
    cat_chart,
    # chart 3 tab,
    summary_tab,
    recycle_page
  )
)

intro_tab <- tabPanel(
  "Introduction"
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
        in temperature. Some years do not have recorded temperatures, thus
        some years will not have data to view.")
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

cat_chart <- tabPanel(
  "Climate Action Tracker",
  sidebarPanel(
    h3("GLOBAL WASTE GENERATION BY YEAR"),
    h4("QUESTION"),
    p("Which country has contributed most to climate 
      change through waste generation (per capita)?"),
    selectInput("year", label = h3("Select a year"),
                c(1990:2050)),
    p("Select a year to see the average global waste generation per capita..."),
  ),
  mainPanel(
    plotOutput("bar_chart")
  )
)

summary_tab <- tabPanel(
  "Summary",
  sidebarLayout(
    sidebarPanel(
      h3("CONCLUSIONS"),
      p("")
    ),
    
    # feel free to change the image here lol
    mainPanel(
      img(src = paste0(
        "https://img.favpng.com/4/25/8/global-warming-royalty-free-climate",
        "-change-illustration-png-favpng-Y9NHT4QsJU2J2KXYqPLa9RAny.jpg"),
          width = "95%", height = "95%")
    )
  )
)


#Recycle page 
recycle_page <- tabPanel(
  "Recycle waste vs Total waste",
  titlePanel(
    "Recycle Rate vs Total waste in Different Countries"
  ),
  p("This is an interactive bar graph that can show the average total
    waste and average total recycled waste throughout the years 
    in different countries. Please select a country of interest."),
  sidebarLayout(
    sidebarPanel(
      h3("Recycled Waste vs Total Waste"),
      h4("QUESTION"),
      p("What is the recycled waste versus total waste 
        in different countries? By looking at the comparison,
        it is clear that only how much waste has been recycled
        in different country. Please refer to the map to see
        the effect global warming in the selected country"),
      select_country <- selectInput(
        "recycle_country",
        label = "Choose a country",
        choices = unique(df$Country),
        selected = "Austria"
      ),
      p("Please select a country to see the comparison 
        between recycled waste and the total waste")
    ),
    mainPanel(
      plotlyOutput("percent_recycle")
    )
  )
)


