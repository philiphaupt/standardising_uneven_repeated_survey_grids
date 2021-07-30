# This script reads in teh grids from the cockle data

#libraries
library(tidyverse)
library(readxl)
#library(tidyselect)

# read_excel filesresurvey_dir <-
resurvey_dir <- "C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/cockles_data/July_2021_additional_survey"
resurvey_data <-
  readxl::read_xlsx(
    paste0(resurvey_dir, "/area 8 and 15  re-survey results.xlsx"),
    sheet = "Area 8 East Barrows-July",
    range = "A5:K68",
    col_names = FALSE
  ) %>% 
  dplyr::select(-(2:7)) %>%
    mutate(survey_name = "July",
           area_code = "8") %>%
  rename(
    sampling_site = 1,
    `0` = 2,
    `1` = 3,
    `2` = 4,
    `3+` = 5
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
  "C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/cockles_data/copy_of_data_from_server/2021"
orig_data <-
  readxl::read_xlsx(
    paste0(orig_dir, "/2021 Cockle Survey_20210721.xlsx"),
    sheet = "Area 8 East Barrows",
    range = "A5:K784",
    col_names = FALSE
  ) %>%
    select(-c(2:7)) %>% 
  mutate(survey_name = "April",
         area_code = "8") %>%
    rename(
    sampling_site = 1,
    `0` = 2,
    `1` = 3,
    `2` = 4,
    `3+` = 5
  ) %>% 
  filter(!is.na(sampling_site)) %>% 
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


# see what sites did not match?
sites_not_surveyd_april <- anti_join(resurvey_data, orig_data, by = "sampling_site")

# combine data
combined_data <- rbind(match_orig_data, resurvey_data)

# drop NA make abundance numeric
combined_cln_8 <- combined_data %>% 
  mutate(abundance = as.numeric(cockles_per_sample))
#
# write rds
write_rds(combined_cln_8, "~/data/combined_cln_area_8.rds")
