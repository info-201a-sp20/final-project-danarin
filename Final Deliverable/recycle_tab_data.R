#data processing for chart_3.R file
waste_data <- read.csv("../data/waste_generation_and_treatment(env_wasgt).csv",
                       header = TRUE, stringsAsFactors = FALSE)

waste_data <- waste_data %>%
  mutate(Country = GEO) %>%
  mutate(Waste = Value) %>%
  filter(HAZARD == "Hazardous and non-hazardous - Total") %>%
  select(TIME, Country, WST_OPER, Waste, UNIT)

#Calculate average recycling rate across 2004-2016
recycle <- waste_data %>%
  filter(WST_OPER == "Waste treatment" |
           WST_OPER == "Recovery - recycling and backfilling (R2-R11)" &
           Waste != ":") %>%
  spread(WST_OPER, Waste) %>%
  drop_na() %>%
  mutate(recycled_waste =
           as.numeric(gsub(",", "", as.character(
             `Recovery - recycling and backfilling (R2-R11)`)))) %>%
  mutate(total_waste =
           as.numeric(gsub(",", "",
                           as.character(`Waste treatment`)))) %>%
  group_by(Country) %>%
  summarise(
    avg_recycled = mean(recycled_waste),
    avg_waste = mean(total_waste)
  )
