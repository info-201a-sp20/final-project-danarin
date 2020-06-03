#Packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)
library(plotly)


#Total waste production in from 2004-2016
waste_data <- read.csv("data/waste_generation_and_treatment(env_wasgt).csv",
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
  ) %>%
  mutate(avg_percent_recycled = avg_recycled / avg_waste) %>%
  select(Country, avg_percent_recycled)

#Global warming indicator: average tempt change by country
temp_data <- read.csv("data/temperautre.csv",
                      header = TRUE, stringsAsFactors = FALSE)

temp_data_round <- temp_data %>%
  mutate(temp_change = substr(temp_data$Warming.since.1960, 1,
                              nchar(temp_data$Warming.since.1960) - 7)) %>%
  select(-Warming.since.1960)

#Combine datasets
df <- left_join(recycle, temp_data_round) %>%
  drop_na()


#Plot
plot_ly(data = df, x = ~avg_percent_recycled, y = ~temp_change,
        type = "scatter", mode = "markers")

fit <- lm(temp_change ~ avg_percent_recycled, data = df)

correlation_plot <- plot_ly(data = df, x = ~avg_percent_recycled) %>%
  add_markers(y = ~temp_change, text = ~Country, name = "Country") %>%
  add_trace(y = fitted(fit),
            mode = "lines",
            type = "scatter",
            name = "Regression Line") %>%
  layout(title = paste("Average Percent Recycled Waste <br> v.s",
                       "Average Land Temperature Change"),
         xaxis = list(title = "Average Percent Recycled Waste <br> (%)"),
         yaxis = list(title = "Average Land Temperature Change <br> (Celsius)"),
         margin = list(t = 75))
