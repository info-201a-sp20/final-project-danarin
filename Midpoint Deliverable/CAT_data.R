library(dplyr)
library(ggplot2)
library(readxl)
library(leaflet)



# This is the Climate Action Tracker (CAT) file

# I made it so you don't have to change your working directories to access the
# data, so you can stay in this file's directory when working in it.

# Get dataframe
cat_df <- read_excel("../data/CAT-Decarbonisation-Indicators.AllData.260919.xlsx",
                     sheet = "RawData")

# Create a new dataframe grouping by indicators
updated_df <- cat_df %>%
  group_by(Country) %>%
  summarize(
    Total_Value = mean(Value)
  )

# Making dataframe into a bar chart
plot <- barplot(updated_df$Total_Value, ylim = c(0, 5000),
                main = "Country vs. Climate Change Contribution",
                xlab = "Country Name",
                ylab = "CC Contribution"
               )
