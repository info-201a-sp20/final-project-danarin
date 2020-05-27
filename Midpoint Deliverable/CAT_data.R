library(dplyr)
library(ggplot2)
library(readxl)



# This is the Climate Action Tracker (CAT) file

# I made it so you don't have to change your working directories to access the
# data, so you can stay in this file's directory when working in it.

# Get dataframe
cat_df <- read_excel("../data/CAT-Decarbonisation-Indicators.AllData.260919.xlsx",
                     sheet = "RawData")

# Create a new dataframe grouping by indicators
updated_df <- cat_df %>%
  select(Indicator, Country, Value) %>% 
  filter(Indicator == "Waste generation (per capita)") %>%
  group_by(Country) %>%
  summarize(
    Average_Waste_Generation = mean(Value)
  )

# Making dataframe into a bar chart
p <- ggplot(updated_df, mapping = aes(fill = Country, x = Country, y = Average_Waste_Generation)) + geom_bar(position = "stack", stat = "identity")
p
