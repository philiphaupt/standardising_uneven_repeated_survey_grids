# plot the mean number of cockles per age category from the two surveys against each other in a bar plot
library(tidyverse)
library(plotrix)
library(ggsci)
library("gridExtra")

combined_cln <- combined_cln_15 # required name for using in plots as written below

summary_combined_data <- combined_cln %>%
  dplyr::group_by(survey_name, area_code, year_class_category) %>%
  dplyr::summarise(cockles_per_sample_mean = mean(abundance, na.rm = TRUE),
                   cockles_per_sample_se = std.error(abundance, na.rm = TRUE))


p1 <- ggplot(data = summary_combined_data,
       aes(x = year_class_category,
           y = cockles_per_sample_mean,
           fill = survey_name)
       ) +
  geom_bar(
    position = "dodge",
    stat = "identity"
  ) +
  theme_bw()+
  scale_fill_jco() +
  theme(legend.position = "none")+
  labs(title = "Cockles per year class (0 - 3+)",
       x = "Year class",
       y = "Mean number of cockles per sample",
       tag = "2a)")+
    geom_errorbar(aes(
    ymin = (cockles_per_sample_mean - cockles_per_sample_se),
    ymax = (cockles_per_sample_mean + cockles_per_sample_se),
    #colour = survey_name
      ),
    width = 0.1,
    position=position_dodge(0.9)
    )+
  facet_wrap(~area_code)


# without 0 year class
p2 <-summary_combined_data %>%
  filter(year_class_category != "0") %>%
  #dplyr::group_by(survey_name, year_class_category) %>%
  #dplyr::summarise(cockles_per_sample_mean = mean(as.numeric(cockles_per_sample), na.rm = TRUE)) %>%
   ggplot(aes(x = year_class_category,
             y = cockles_per_sample_mean,
             fill = survey_name)) +
  geom_bar(position = "dodge",
           stat = "identity") +
  theme_bw()+
  theme(legend.position = "none")+
  scale_fill_jco() +
  labs(title = "Cockles per year class (1 - 3+)",
       x = "Year class",
       y = "Mean number of cockles per sample",
       fill = "Survey period",
       tag = "2b)")+
  geom_errorbar(aes(
    ymin = (cockles_per_sample_mean - cockles_per_sample_se),
    ymax = (cockles_per_sample_mean + cockles_per_sample_se),

  ),width = 0.1,
   position=position_dodge(0.9)
  ) +
  facet_wrap(~area_code)
  #geom_rect(aes(xmin="2", xmax="3+", ymin=0, ymax=Inf),fill = "grey66", alpha = 0.01)
#   annotate("rect", xmin="2", xmax="3+", ymin=0, ymax=Inf,
#            alpha = .2, fill = "forestgreen", colour = "grey", lty ="dashed")
# #plot side by side
grid.arrange(p1, p2, ncol = 2)


adult_stock <- combined_cln %>% filter(year_class_category != "0") %>%
  dplyr::group_by(survey_name, area_code) %>%
  dplyr::summarise(number_of_samples = n()/3,#3 becuase 3 categories
                   cockles_per_sample_sum = sum(abundance, na.rm = TRUE),
                   number_adults_mean = cockles_per_sample_sum/number_of_samples,
                   adults_se = (sqrt(sum((abundance-number_adults_mean)^2, na.rm = TRUE)/number_of_samples)/sqrt(number_of_samples))# this needs a na.rm statement so taht the error bar appears on the plot
  )
#stack adults type graph
p3 <- adult_stock %>%
  ggplot(aes(
    survey_name,
    number_adults_mean,
             fill = survey_name)) +
  geom_bar(position = "dodge",
           stat = "identity") +
  theme_bw() +
  scale_fill_jco() +
  labs(
    title = "Pooled year classes (1 - 3+)",
    x = "Year class",
    y = "Mean number of adult cockles per sample",
    fill = "Survey period",
    tag = "2c)"
  ) +
  geom_errorbar(aes(
    ymin = (number_adults_mean - adults_se),
    ymax = (number_adults_mean + adults_se),

  ),
  width = 0.1,
  position = position_dodge(0.9))+
  facet_wrap(~area_code)



p3



# #plot side by side
grid.arrange(p1, p2, p3, ncol = 3)

# #write data for recall in RMD report
# write_rds(p1, "./report/data/cockle_numbers_mean_barchart.rds")
# write_rds(p2, "./report/data/cockle_numbers_mean_barchart_1to3yc.rds")
# write_rds(p3, "./report/data/cockle_numbers_mean_barchart_adults.rds")

