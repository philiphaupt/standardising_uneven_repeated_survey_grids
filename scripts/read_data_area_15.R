# This script reads in teh grids from the cockle data

#libraries
library(tidyverse)
library(readxl)

# read_excel files

# resurvey grid
resurvey_dir <-
  "C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/cockles_data/July_2021_additional_survey"
resurvey_data <-
  readxl::read_xlsx(
    paste0(resurvey_dir, "/area 8 and 15  re-survey results.xlsx"),
    sheet = "Area 15 Margate Long Sands-July",
    range = "A4:H87",
    col_names = TRUE
  ) %>%
  mutate(survey_name = "July",
         area_code = "15") %>%
  select(-c(Date, Clams, Comments)) %>% 
 rename(
   sampling_site = `Sampling site`
 ) %>% 
  pivot_longer(
    cols = c(
      `0`,
      `1`,
      `2`,
      `3+`
    ),
    names_to = "year_class_category",
    values_to = "cockles_per_sample"
  )


# read in original survey data
orig_dir <-
  "C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/cockles_data/my_copy"
orig_data <-
  readxl::read_xlsx(
    paste0(orig_dir, "/2021 Cockle Survey_20210106.xlsx"),
    sheet = "Area 15 Margate Long Sands",
    range = "A3:I75"
  ) %>%
  mutate(survey_name = "April",
         area_code = "15") %>%
  select(-c(Area, `...3`, Lat, Long)) %>%
  rename(sampling_site = `...1`, 
          `0` = `2021`,
          `1` = `2020`,
          `2` = `2019`,
          `3+` = `2018`) %>%
         
         pivot_longer(
           cols = c(
             `0`,
             `1`,
             `2`,
             `3+`
           ),
           names_to = "year_class_category",
           values_to = "cockles_per_sample"
         )

# remove non matchhing samples from original grid
match_orig_data <- orig_data %>% 
  filter(sampling_site %in% unique(resurvey_data$sampling_site))
         

# combine data
combined_data <- rbind(match_orig_data, resurvey_data)

# drop NA, make abundance numeric
combined_cln_15 <- combined_data %>% 
  filter(sampling_site != "4-14") %>% # only required for area 15
  mutate(abundance = as.numeric(cockles_per_sample))
# write to file
write_rds(combined_cln_15, "~/data/combined_cln_area_15.rds")