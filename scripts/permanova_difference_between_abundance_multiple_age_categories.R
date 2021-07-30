# PERMANOVA test to see if there is signifiant difference among groupings
library(vegan)
library(labdsv)

# The age categories as species, against one variable as predictor - time of year, and sampling site as random

# Reshape the data for community matrix analysis
community_data <- combined_cln %>% 
  mutate(opname = paste0(survey_name, "_", sampling_site)) %>% 
  select(opname, year_class_category, abundance) %>% 
  pivot_wider(names_from = year_class_category, values_from = abundance, names_prefix = "yc_") %>% 
  select(-opname)
  
# Reshape env data to match above structure for analysis.
env_data <- combined_cln %>% 
  mutate(opname = paste0(survey_name, "_", sampling_site)) %>% 
  select(opname, sampling_site, survey_name) %>% 
  distinct(opname, sampling_site, survey_name)

# distance matrix
dist <- vegdist(community_data, method = "jaccard" )

# Principle coordinates analysis
pco <- wcmdscale(dist, k = k)

plot(pco)

# oridination
ord <-  metaMDS(community_data, distance = "altGower")


plot(ord)#...this may be over the top...as when 0 class inlcuded it will be significant (all taht says is that cockle shave spatted.)
# if we exclude the 0 calss?
  
  
  # maybe more sensible to run a t test for matched sites, and a Wilcoxon including non-matched sites for 2, 3+ and 2 and 3+ combined
  