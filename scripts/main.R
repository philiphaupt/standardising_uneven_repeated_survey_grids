# main

# read in data#
source("./scripts/read_2022_data_area_15_from_server.R")
# NOT RUN
# source("./scripts/read_data_area_15.R") #2021 laptop
# source("./scripts/read_data_area_8.R") # 2021 laptop
# clean filter and match data
source("./scripts/match_filter_clean_data.R")


# plots
source("./scripts/plot_overall_raw_comparison.R", echo = TRUE)
