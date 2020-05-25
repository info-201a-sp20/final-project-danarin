library(dplyr)
library(lintr)
library(styler)
library(stringr)
library(ggplot2)
library(leaflet)
library(readxl)
library(xlsx)


# This is the Climate Action Tracker (CAT) file

# For getting accessing the dataframe, choose the final-project folder as the 
# working directory!

# Get dataframe
cat_df <- read_excel("data/CAT-Decarbonisation-Indicators.AllData.260919.xlsx",
                     sheet = "RawData")

# currently working to remove the na values from the dataframe, but am 
# having trouble.
