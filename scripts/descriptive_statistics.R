# DEscriptive stas
combined_cln %>% distinct(year_class_category)

# number of successful surveys
combined_cln %>% #filter(!is.na(abundance)) %>% 
  group_by(survey_name) %>% 
  distinct(sampling_site) %>% 
  summarise(number_of_surveys = n())

# total number of cockles per year class for each of the two surveys
combined_cln %>% filter(!is.na(abundance)) %>% 
  group_by(survey_name, year_class_category) %>% 
  summarise(total = sum(abundance))
