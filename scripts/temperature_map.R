library(plotly)
library(dplyr)

temperature_df <- read.csv("data/GlobalLandTemperaturesByCountry.csv",
  stringsAsFactors = FALSE
)

# Omit the NA values
temperature_df <- na.omit(temperature_df)

geography_df <- read.csv(
  paste0(
    "https://raw.githubusercontent.com/plotly",
    "/datasets/master",
    "/2014_world_gdp_with_codes.csv"
  ),
  stringsAsFactors = FALSE
)

geography_df <- geography_df[-2]

temperature_df <- temperature_df[-3]

temperature_df <- temperature_df %>%
  mutate(year = format(as.Date(dt), "%Y"))

build_map <- function(year_choice) {
  select_year <- temperature_df %>%
    filter(year == year_choice)

  calculation <- select_year %>%
    group_by(Country) %>%
    filter(dt %in% range(dt, na.rm = TRUE)) %>%
    summarize(
      change_in_temp = AverageTemperature[2] - AverageTemperature[1]
    ) %>%
    select(Country, change_in_temp) %>%
    rename(region = Country, Change_in_Temperature = change_in_temp) %>%
    mutate(
      region = ifelse(region == "USA", "United States", region),
      region = ifelse(region == "Democratic Republic of the Congo",
        "Congo (Democratic Republic of the)", region
      )
    )

  rename_df <- geography_df %>%
    rename(region = COUNTRY)

  joined_df <- left_join(calculation, rename_df, by = "region")

  temperature_map <- plot_ly(
    joined_df,
    type = "choropleth",
    locations = joined_df$CODE,
    z = joined_df$Change_in_Temperature,
    text = joined_df$region,
    colorscale = "BLUES"
  ) %>%
    colorbar(
      title = "Change in Temperature (Celsius)"
    )

  return(temperature_map)
}
