library(plotly)
source("../Midpoint Deliverable/CAT_data.R")

cat_df <- read_excel(paste0("../data/CAT-Decarbonisation-Indicators.",
                            "AllData.260919.xlsx"), sheet = "RawData")

cat_df <- cat_df %>%
  select(Indicator, Country, Year, Value) %>%
  filter(Indicator == "Waste generation (per capita)")

bar_chart <- function(year) {
  select_year <- cat_df %>%
    filter(Year == year)
  
  p <- ggplot(select_year, mapping = aes(fill = Country, x = Country,
                                        y = Value))
  p <- p + geom_text(aes(label = round(Value, digits = 2)),
                     vjust = -0.5, position = position_dodge(0.9), size = 2.75)
  p <- p +  geom_bar(position = "stack",
                     stat = "identity")
  p <- p + ggtitle(paste("Average Waste Generation Within Countries in", year))
  p <- p + ylab("Avg Waste Generation (Per Capita)")
  return(p)
}