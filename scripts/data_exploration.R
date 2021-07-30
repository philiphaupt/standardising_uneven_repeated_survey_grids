# Data exploration
library(tidyverse)
library(plotrix)
library(ggsci)
library("gridExtra")
# Outliers
ggplot(data = combined_cln)+
  geom_boxplot(aes(x = survey_name, y = abundance, col = survey_name))+
  theme_bw() +
  ggsci::scale_colour_jco()

# clearly the spat cannot be abalysed with the rest of the data, as it causes problems with outliers.
# drop spat (year class0)

# Outliers
ggplot(data = combined_cln %>% filter(year_class_category != "0"))+
  geom_boxplot(aes(x = survey_name, y = abundance, col = survey_name))+
  theme_bw() +
  ggsci::scale_colour_jco()
# clearly shows MASSIVE zero inflation

# Distribution
combined_cln %>% filter(year_class_category != "0") %>% 
  ggplot()+
  geom_histogram(aes(x = abundance, fill = survey_name), position = "dodge")+
  theme_bw() +
  ggsci::scale_fill_jco()

# we could expect around 20 -28 zeros, all the rest are excess zeros - clearly zero inflated. 
# count data - so ZI Poisson distribution?
# See page 272 in Zuur, mixed models
# "Overview of ZIP, ZAP, ZINB and ZANB models. All models can cope with overdispersion
# due to excessive numbers of zeros. The negative binomial models can also cope with
# overdispersion due to extra variation in the count data. The ZIP and ZINB are mixture models in
# the sense that they consist of two distributions. The ZAP and ZANB are also called hurdle models,
# conditional models, or compatible models"

# What are the underlying reasons for zreos...think piece and fill in in due course.





