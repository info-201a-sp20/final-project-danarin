library(dplyr)

# Summary Info
country_data <- read.csv("data/country_level_data_0.csv",
                         stringsAsFactors = FALSE)

# population total globe
world_pop <- country_data %>%
  summarize(total_pop = sum(population_population_number_of_people)) %>%
  pull(total_pop)

# industrial waste / total waste
industry_waste_percent <- country_data %>%
  summarize(ind_waste_per_total = (sum(special_waste_industrial_waste_tons_year,
                                       na.rm = TRUE) /
                                     sum(
                                       total_msw_total_msw_generated_tons_year,
                                         na.rm = TRUE))) %>%
  pull(ind_waste_per_total)

# agricultural waste average
num_countries <- nrow(country_data)
avg_agri_waste <- country_data %>%
  summarize(avg = (sum(special_waste_agricultural_waste_tons_year,
                       na.rm = TRUE) / num_countries)) %>%
  pull(avg)
# average total waste
avg_total_waste <- country_data %>%
  summarize(avg = (sum(total_msw_total_msw_generated_tons_year,
                       na.rm = TRUE) / num_countries)) %>%
  pull(avg)
# average total waste / person
avg_per_person <- country_data %>%
  summarize(avg = (sum(total_msw_total_msw_generated_tons_year,
                       na.rm = TRUE) / world_pop)) %>%
  pull(avg)
# average total waste / person in United States
avg_per_person_us <- country_data %>%
  filter(country_name == "United States") %>%
  summarize(avg = total_msw_total_msw_generated_tons_year /
              population_population_number_of_people) %>%
  pull(avg)
