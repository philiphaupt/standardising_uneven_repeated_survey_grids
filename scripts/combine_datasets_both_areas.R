# join both data sets
# - bind them
# combined_cln_8 <- read_rds("")
# combined_cln_15 <- read_rds("")

combined_cln <- rbind(combined_cln_8, combined_cln_15)
write_rds(combined_cln, "C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/standardising_resurvey_grids/standardising_uneven_repeated_survey_grids/report/data/combined_cln.rds")