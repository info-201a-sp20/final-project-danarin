library(dplyr)
library(knitr)

# Create a data frame for the data to work with
temperature_df <- read.csv("../data/GlobalLandTemperaturesByCountry.csv",
                           stringsAsFactors = FALSE
)

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
  arrange(desc(change_in_temp)) %>%
  rename(region = Country, "Change in Temperature" = change_in_temp) %>%
  mutate(
    region = ifelse(region == "United States", "USA", region),
    region = ifelse(region == "Congo (Democratic Republic Of The)",
                    "Democratic Republic of the Congo", region)
  )

# Create a table of the analysis
temp_change_table <- knitr::kable(
  analysis,
  col.names = names(analysis),
  caption = "Change in Land Temperature in Every Country from 1700s to 2012"
)
