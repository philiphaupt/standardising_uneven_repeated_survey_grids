# match_and_filter to clean data

# # remove non-matching samples from original grid - based on all three sites
# match_orig_data <- orig_data %>% 
#   filter(sampling_site %in% unique(resurvey_data$sampling_site))

# sampling site unique_per_group
april_sites <- orig_data %>% distinct(sampling_site)
july_sites <- resurvey_data %>% distinct(sampling_site)
oct_sites <- resurvey2_data %>% distinct(sampling_site)

tmp <- inner_join(april_sites, july_sites, by = "sampling_site")
sites_in_all_surveys <- inner_join(tmp, oct_sites, by = "sampling_site")
rm(tmp)

# combine data
#combined_data <- rbind(match_orig_data, resurvey_data) #original and resurvey only
combined_data <- rbind(orig_data, resurvey_data, resurvey2_data)  %>% filter(sampling_site %in% unlist(sites_in_all_surveys )) # combined data with sites in all surveys


uniq_sites <- combined_data %>% group_by(survey_name) %>% distinct(sampling_site)
# drop NA, make abundance numeric
list_to_remove <- combined_data[which(is.na(combined_data$cockles_per_sample)),] %>% select(sampling_site) %>% distinct()
combined_cln_15 <- anti_join(combined_data, list_to_remove, by = "sampling_site") %>% 
  mutate(abundance = as.numeric(cockles_per_sample))
# write to file
# write_rds(combined_cln_15, "~/data/combined_cln_area_15.rds")

rm(april_sites, july_sites, oct_sites, list_to_remove, uniq_sites, sites_in_all_surveys, orig_data, resurvey_data, resurvey2_data, resurvey_dir, resurvey2_dir, orig_dir)
