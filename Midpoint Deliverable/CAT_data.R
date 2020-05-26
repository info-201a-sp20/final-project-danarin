library(dplyr)
library(lintr)
library(styler)
library(stringr)
library(ggplot2)
library(leaflet)
library(readxl)
library(xlsx)


# This is the Climate Action Tracker (CAT) file

# I made it so you don't have to change your working directories to access the
# data, so you can stay in this file's directory when working in it.

# Get dataframe
cat_df <- read_excel("../data/CAT-Decarbonisation-Indicators.AllData.260919.xlsx",
                     sheet = "RawData")

# omitting the na values, gets rid of all of my data for some reason
cat_df <- na.omit(cat_df)


