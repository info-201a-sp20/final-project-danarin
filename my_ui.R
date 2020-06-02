library(shiny)
library(plotly)
library(shinythemes)

# Introduction tab
introduction <- tabPanel(
  "Introduction",
  h1("Climate Change", align = "center"),
  h4("As defined by NASA,", strong("climate change"), "is 'any long-term
         change in Earth's climate, or in the climate of a region or city."),
  img(src = paste0("https://static01.nyt.com/images/2019/12/02/climate/",
                   "00CLI-ACCELERATE6/00CLI-ACCELERATE6-jumbo.jpg?quality=90&auto=webp")),
  p("Climate change affects everyone because it affects the world we live in.
        Climate change is caused by human activities, such as the emissions of
        greenhouse gases like carbon dioxide, deforestation, and land-use
        change. It disrupts all aspects of society including human health,
        agriculture, transportation, energy, ecosystems, etc."),
  img(src = paste0("https://media.greenmatters.com/brand-img/",
                   "ZochFRvBX/1280x671/causes-of-global-warming-1579628524578.jpg")),
  p("Right now global climate change
        has caused the loss of sea ice, leading to a rise in sea level,
        and more intense heat waves across the globe. The Intergovernmental
        Panel on Climate Change, or the IPCC, release reports explaining the
        extent of climate change effects on various regions across the globe.
        The trend in increased global temperature is seen with a very high
        certainty to be caused by human forcing, the main aspect being carbon
        dioxide emissions. While other natural factors are analyzed, these
        trends are too small to explain the trend in global temperature. Without
        a change, the Earth will continue to warm increasing global
        effects caused by climate change, such as more frequent wildfires,
        longer periods of droughts, increased duration and intensity of
        tropical storms, etc."),
  img(src = paste0("https://static01.nyt.com/images/2019/12/02/",
                   "climate/00CLI-ACCELERATE1/merlin_165073290_2cc529a8-3a3e-",
                   "42e1-ac9d-15f122d71082-jumbo.jpg?quality=90&auto=webp")),
  h3("Major Questions We Are Trying to Answer"),
  p("1. Which part of the world is being affected by global warming the most?"),
  p("2. Which country has contributed most to climate change through waste
        generation (per capita) in a given year?"),
  p("3. What is the correlation between recycled waste and total waste in
        different countries?"),
  h3("Datasets Used"),
  p(a("Climate Action Tracker",
      href = "https://climateactiontracker.org/data-portal/"
  )),
  p(a("Global Land Temp by Country",
      href = paste0(
        "https://www.kaggle.com/berkeleyearth/",
        "climate-change-earth-surface-temperature-data"
      )
  )),
  p(a("Country Level Data",
      href = paste0(
        "https://datacatalog.worldbank.org/dataset/",
        "what-waste-global-database"
      )
  )),
  p(a("Waste Generation and Treatment",
      href = "https://sensoneo.com/sensoneo-global-waste-index-2019/"
  ))
)

# Temperature change map tab
temperature_map <- tabPanel(
  "Temperature Change Map",
  sidebarLayout(
    sidebarPanel(
      h3("TEMPERATURE CHANGE BY YEAR"),
      h4("QUESTION"),
      p("- Which part of the world is being affected by global
        warming the most?"),
      sliderInput(
        inputId = "year_choice",
        label = "Year",
        min = 1750,
        max = 2013,
        value = 1880
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

# Global waste tab
global_waste <- tabPanel(
  "Global Waste Generation",
  sidebarLayout(
    sidebarPanel(
      h3("GLOBAL WASTE GENERATION BY YEAR"),
      h4("QUESTION"),
      p("- Which country has contributed most to climate
      change through waste generation (per capita)?"),
      p("Select a year to find out which country has contributed the
        most waste."),
      selectInput("year",
        label = ("Select a year"),
        c(1990:2030),
        selected = "Average of all years"
      ),
      p("Each bar represents the average amount of waste a person
        generates within a country. As you will see, some countries aren't
        listed because there wasn't any data for that corresponding year. In
        some cases, not all countries will be listed because the average values
        of waste generation are combined with others within the same region,
        like Europe, for instance."),

    ),
    mainPanel(
      plotOutput("bar_chart")
    )
  )
)

# Recycle waste vs total tab
recycle_chart <- tabPanel(
  "Recycle Waste vs Total waste",
  sidebarLayout(
    sidebarPanel(
      h3("RECYCLED WASTE vs TOTAL WASTE"),
      h4("QUESTION"),
      p("- What is the recycled waste versus total waste
        in different countries? By looking at the comparison,
        it is clear that only how much waste has been recycled
        in different country. Please refer to the map to see
        the effect global warming in the selected country"),
      select_country <- selectInput(
        "recycle_country",
        label = "Choose a country",
        choices = unique(recycle$Country),
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

# Summary tab
summary_page <- tabPanel(
  "Summary",
  sidebarLayout(
    sidebarPanel(
      h3("CONCLUSIONS"),
      p("")
    ),

    # feel free to change the image here lol
    mainPanel(
      img(
        src = paste0(
          "https://img.favpng.com/4/25/8/global-warming-royalty-free-climate",
          "-change-illustration-png-favpng-Y9NHT4QsJU2J2KXYqPLa9RAny.jpg"
        ),
        width = "95%", height = "95%"
      )
    )
  )
)

# Sources tab
sources_tab <- tabPanel(
  "Sources",
  h2("Information", align = "center"),
  p(a("\"The Effects of Climate Change\" - NASA",
      href = "https://climate.nasa.gov/effects/")),
  p(a("\"Understand Climate Change\" - GlobalChange.gov",
      href = "https://www.globalchange.gov/climate-change")),
  p(a("\"What Are Climate and Climate Change?\" - NASA",
      href = paste0("https://www.nasa.gov/audience/forstudents/5-8/",
                    "features/nasa-knows/what-is-climate-change-58.html"))),
  p(a("\"Climate Change 2013: The Physical Science Basis\" - IPCC",
      href = "https://www.ipcc.ch/report/ar5/wg1/")),
  h2("Photos", align = "center"),
  p(a("\"Cave Fire in Santa Barbara, Calif\" - David Mcnew/Reuters", 
      href = paste0("https://static01.nyt.com/images/2019/12/02/",
                    "climate/00CLI-ACCELERATE1/merlin_165073290_2cc529a8-3a3e-",
                    "42e1-ac9d-15f122d71082-jumbo.jpg?quality=90&auto=webp"))),
  p(a("\"Flooding in Mogadishu, Somalia, in October\" - Feisal Omar/Reuters", 
      href = paste0("https://static01.nyt.com/images/2019/12/02/climate/",
                    "00CLI-ACCELERATE6/00CLI-ACCELERATE6-jumbo.jpg?quality=90&auto=webp"))),
  p(a("\"Polar Bear and Iceberg Photo\" - Istock", 
      href = paste0("https://media.greenmatters.com/brand-img/ZochFRvBX/",
                    "1024x537/causes-of-global-warming-1579628524578.jpg")))
)

# About Us tab
about_tab <- tabPanel(
  "About Us",
  h1("Group Members", align = "center"),
  h3("Dana Rin"),
  h3("Jenny Dao"),
  h3("Stephanie"),
  h3("Janet Pan")
)

# UI
ui <- fluidPage(
  tags$div(class = "header"),

  navbarPage(
    theme = shinytheme("flatly"), collapsible = TRUE,
    "Climate Change and Global Warming",

    introduction,
    temperature_map,
    global_waste,
    recycle_chart,
    summary_page,
    sources_tab,
    about_tab
  )
)
