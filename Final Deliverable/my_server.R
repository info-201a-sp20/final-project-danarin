library(shiny)
source("temperature_map.R")
source("CAT_chart.R")

#data processing for chart_3.R file
waste_data <- read.csv("../data/waste_generation_and_treatment(env_wasgt).csv",
                       header = TRUE, stringsAsFactors = FALSE)

waste_data <- waste_data %>%
  mutate(Country = GEO) %>%
  mutate(Waste = Value) %>%
  filter(HAZARD == "Hazardous and non-hazardous - Total") %>%
  select(TIME, Country, WST_OPER, Waste, UNIT)

#Calculate average recycling rate across 2004-2016
recycle <- waste_data %>%
  filter(WST_OPER == "Waste treatment" |
           WST_OPER == "Recovery - recycling and backfilling (R2-R11)" &
           Waste != ":") %>%
  spread(WST_OPER, Waste) %>%
  drop_na() %>%
  mutate(recycled_waste =
           as.numeric(gsub(",", "", as.character(
             `Recovery - recycling and backfilling (R2-R11)`)))) %>%
  mutate(total_waste =
           as.numeric(gsub(",", "",
                           as.character(`Waste treatment`)))) %>%
  group_by(Country) %>%
  summarise(
    avg_recycled = mean(recycled_waste),
    avg_waste = mean(total_waste)
  )

#Global warming indicator: average tempt change by country
temp_data <- read.csv("../data/temperautre.csv",
                      header = TRUE, stringsAsFactors = FALSE)

temp_data_round <- temp_data %>%
  mutate(temp_change = substr(temp_data$Warming.since.1960, 1,
                              nchar(temp_data$Warming.since.1960) - 7)) %>%
  mutate(Country = ï..Country) %>%
  select(-Warming.since.1960, -ï..Country)

#Combine datasets
df <- left_join(recycle, temp_data_round) %>%
  drop_na()


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
           yaxis = list(title = "Amount of waste (tonne)"))
  })
}


