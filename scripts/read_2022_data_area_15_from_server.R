# This script reads in teh grids from the cockle data

#libraries
library(tidyverse)
library(readxl)
library(data.table)

# read_excel files

# resurvey grid
resurvey_dir <-
  "S:/SC5&6 - Fisheries and Enviromental Managment/Shellfish - Cockles/Surveys/2022"
resurvey_data <-
  readxl::read_xlsx(
    paste0(resurvey_dir, "/2022 Cockle Survey.xlsx"),
    sheet = "Area 15 Margate Long Sands-July",
    range = "A5:K103",
    col_names = TRUE
  ) %>% 
  rename(
   sampling_site = `Sample no`
 ) %>% 
  mutate(survey_name = "July",
         area_code = "15",
         sampling_site = str_remove_all(sampling_site, ";")) %>%
  select(-c(area, date, X, Y, lat, long)) %>% 
  rename(
         `0` = `2022`,
         `1` = `2021`,
         `2` = `2020`,
         `3+` = `2019`) %>% 
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
  "S:/SC5&6 - Fisheries and Enviromental Managment/Shellfish - Cockles/Surveys/2022"
orig_data <-
  readxl::read_xlsx(
    paste0(orig_dir, "/2022 Cockle Survey.xlsx"),
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

# 2-resurvey grid (Oct)
resurvey2_dir <-
  "S:/SC5&6 - Fisheries and Enviromental Managment/Shellfish - Cockles/Surveys/2022"
resurvey2_data <-
  readxl::read_xlsx(
    paste0(resurvey_dir, "/2022 Cockle Survey.xlsx"),
    sheet = "Area 15 Margate Long Sands-Oct",
    range = "A5:K103",
    col_names = TRUE
  ) %>% 
  rename(
    sampling_site = `Sample no`
  ) %>% 
  mutate(survey_name = "October",
         area_code = "15",
         sampling_site = str_remove_all(sampling_site, ";")) %>%
  select(-c(area, date, X, Y, lat, long)) %>% 
  rename(
    `0` = `2022`,
    `1` = `2021`,
    `2` = `2020`,
    `3+` = `2019`) %>% 
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


