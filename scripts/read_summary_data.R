#libraries
library(tidyverse)
library(readxl)

# read sumamry data of weights and numbers

# resurvey grid
resurvey_dir <-
        "C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/cockles_data/July_2021_additional_survey"

resurvey_summary_15 <- readxl::read_xlsx(paste0(resurvey_dir, "/area 8 and 15  re-survey results.xlsx"), range = "A116:G121", col_names = TRUE) %>%
  mutate(survey_name = "July")


# read in original survey data
orig_dir <- "C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/cockles_data/my_copy"
orig_summary_area_15 <- readxl::read_xlsx(paste0(orig_dir, "/2021 Cockle Survey_20210106.xlsx"), sheet = "Area 15 Margate Long Sands", range = "A80:J86") %>%
  mutate(survey_name = "April")


#Area 8
# resurvey grid
resurvey_dir <- "C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/cockles_data/July_2021_additional_survey"
resurvey_data <-
        readxl::read_xlsx(
                paste0(resurvey_dir, "/area 8 and 15  re-survey results.xlsx"),
                sheet = "Area 8 East Barrows-July",
                range = "A5:K68",
                col_names = FALSE
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
        )
