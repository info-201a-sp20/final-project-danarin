library(plotly)
library(readxl)

cat_df <- read_excel("data/CAT-Decarbonisation-Indicators.AllData.260919.xlsx",
  sheet = "RawData"
)

cat_df <- cat_df %>%
  select(Indicator, Country, Year, Value) %>%
  filter(Indicator == "Waste generation (per capita)")

bar_chart <- function(year) {
  select_year <- cat_df %>%
    filter(Year == year)

  b_plot <- ggplot(
    select_year,
    mapping = aes(
      fill = Country,
      x = Country,
      y = Value
    )
  )
  b_plot <- b_plot + geom_bar(
    position = "stack",
    stat = "identity"
  )
  b_plot <- b_plot + ggtitle(paste(
    "Average Waste Generation Within Countries in", year
  ))
  b_plot <- b_plot + ylab("Avg Waste Generation (Per Capita)")
  return(b_plot)
}
