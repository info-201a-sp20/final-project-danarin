library(dplyr)
library(ggplot2)
library(readxl)

# This is the Climate Action Tracker (CAT) file
# Used to calculate average waste generation per capita

# Question of interest: Which country has generated the most waste, 
# contributing the most to climate change in terms of waste generation?

# Get dataframe
cat_df <- read_excel("../data/CAT-Decarbonisation-Indicators.AllData.260919.xlsx",
                     sheet = "RawData")

# Create a new data frame grouping by country, filtering by waste, and 
# taking average of generated waste per country
updated_df <- cat_df %>%
  select(Indicator, Country, Value) %>%
  filter(Indicator == "Waste generation (per capita)") %>%
  group_by(Country) %>%
  summarize(
    Average_Waste_Generation = mean(Value)
  )

# Create bar chart to show waste generation by country
p <- ggplot(updated_df, mapping = aes(fill = Country, x = Country,
                                      y = Average_Waste_Generation))
p <- p + geom_text(aes(label = round(Average_Waste_Generation, digits = 2)),
                  vjust = -0.5, position = position_dodge(0.9), size = 2.75)
p <- p +  geom_bar(position = "stack",
                   stat = "identity")
p <- p + ggtitle("Average Waste Generation Within Countries")
p <- p + ylab("Avg Waste Generation (Per Capita)")