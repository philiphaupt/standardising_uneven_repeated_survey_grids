# statstical test to compare uneven sample size

combined_cln_15 %>% 
  group_by(survey_name) %>%
  select(abundance, survey_name)


wilcox.test(x = combined_cln_15$abundance[which(combined_cln$survey_name == "July"),],
            y = combined_cln_15$abundance[which(combined_cln$survey_name == "April"),],
            "two.sided")

# needs to be repeated for every year class - see if you can do like last example

combined_cln_15 %>%
  dplyr::group_by() %>%
  summarise(wilcox_stat = wilcox.test())

combined_data$survey_name <- factor(combined_data$survey_name)

combined_data %>%
  base::split(survey_name) %>%
  purrr::map(~ wilcox.test(cockles_per_sample ~ year_class_category, data = .)) %>%
  purrr::map_dfr(~ broom::tidy(.))


# results for change in abundance of cockles area 8 is statistically significant.
# area 15:
