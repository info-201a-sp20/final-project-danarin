library(dplyr)
library(ggplot2)
library(maps)

# Create a data frame for the data to work with
temperature_df <- read.csv("../data/GlobalLandTemperaturesByCountry.csv",
                           stringsAsFactors = FALSE)

# Omit the NA values
temperature_df <- na.omit(temperature_df)

# Create a new data frame with the change in temperature analysis for
# each country
analysis <- temperature_df %>%
  group_by(Country) %>%
  filter(dt %in% range(dt, na.rm = TRUE)) %>%
  summarize(
    change_in_temp = AverageTemperature[2] - AverageTemperature[1]
  ) %>%
  select(Country, change_in_temp) %>%
  rename(region = Country, Change_in_Temperature = change_in_temp) %>%
  mutate(
    region = ifelse(region == "United States", "USA", region),
    region = ifelse(region == "Congo (Democratic Republic Of The)",
                    "Democratic Republic of the Congo", region)
  )

# Create a map to represent the change in temperature in each country
world_map <- map_data("world")

change_temp_map <- left_join(analysis, world_map, by = "region")

map <- ggplot(
  change_temp_map,
  aes(map_id = region, fill = Change_in_Temperature)) +
  geom_map(map = change_temp_map, color = "white") +
  expand_limits(x = change_temp_map$long, y = change_temp_map$lat) +
  scale_fill_viridis_c(option = "C")

# Adjust the labels for the map
map <- map + labs(
  title = "Change in Temperature in Countries",
  x = "",
  y = ""
)
