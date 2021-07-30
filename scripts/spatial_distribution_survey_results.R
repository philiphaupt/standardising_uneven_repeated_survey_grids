# REad in spatial grid from sampling design
library(sf)

# Data source:
# created in make_additional_survey_grid.R in Cockle_survey_planning R project.
# output from this stored as: GPKG  in folder
dir_survey_grid_area_15 <-  "C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/cockle_surveys/Cockle_survey_planning/"


# Read in teh double survey grid for Margate and Long sAnds
survey_grid_area_15 <- sf::st_read(paste0(dir_survey_grid_area_15, "cockle_additional_survey_pts_wgs84.gpkg"), layer = "survey_grid_area_5_8_double")#"survey_grid_area_15_double")


# read in the survey grid (full grid) from which we will extract area 8.
survey_grid_area_8 <-
        st_read(dsn = "C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/cockle_surveys/Cockle_survey_planning/cockle_grid_pts_survey_wgs84.gpkg", layer =
                        "cockle_grid_pts_extended_survey_wgs84") %>%
        filter(area == "8") %>%
        select(area_code = area,
               name = grid_position)

survey_grids_8_15 <- rbind(survey_grid_area_8, survey_grid_area_15)

# ggplot(survey_grid_area_8)+
#         geom_sf(col = "grey")+
#         geom_sf_text(aes(label = name))

# make the names match with that as in the data entry sheet.
survey_grid <- survey_grids_8_15 %>%
  mutate(row = tolower(substr(name, 1, 1)),
         # (split the) the sampling row name
         tmp_name = str_replace_all(name, "[^[:alnum:]]", ":")) %>% # it was just easier removing a semi colon than a dash which is follows by numbers - which it perceives as negative numbers) %>%
  mutate(column = ifelse(
    is.na(as.numeric(`row`)),
    str_extract(survey_grids_8_15$tmp_name, "//-*//d+//.*//d*"),
    sub(".*:", "", tmp_name)
  )) %>%
  mutate(doubled_column_names = ifelse(
    !is.na(str_extract(tmp_name, "[A-Z]+")),
    substr(tmp_name,2,3),
    `column`)
    ) %>%
  mutate(sampling_site = paste0(row, "-", doubled_column_names)) %>% #(stick them back together in a way that is consistent with the data)
  select(-c(row, column, tmp_name, doubled_column_names))


combined_cln_sf <- left_join(combined_cln, survey_grid, by = c("area_code", "sampling_site")) %>% st_sf()
# combined_cln_sf_utm <- st_transform(combined_cln_sf, 32631)
# combined_cln_sf_9001 <- st_transform(combined_cln_sf, 9001)

write_rds(combined_cln_sf, "~/data/combined_cln_sf.rds")


st_crs(combined_cln_sf)


#Area 8
surveyed_area_dir <-"C:/Users/Phillip Haupt/Documents/GIS/VMS/"
surveyed_area <- st_read(dsn = paste0(surveyed_area_dir, "cockles_vms_data_clustered.gpkg"), layer ="cockles_vms_data_clustered_area_8_tight")



# subset data
combined_cln_1_to_3_sf <- combined_cln_sf %>%
  filter(year_class_category != "0")
combined_year_classes_cln_spat_sf <- combined_cln_sf %>%
  filter(year_class_category == "0")

# plot results - wgs - area 8
adult_year_classes_spatial_plot_area_8 <- ggplot() +
  geom_sf(data = surveyed_area, col = "grey") +
  geom_sf(data = combined_cln_1_to_3_sf[which(combined_cln_1_to_3_sf$area_code == "8"),],
          aes(abundance, size = abundance, col = survey_name)) +
  labs(
    title = "Area 8: Spatial distribution of adult cockles year classes (1 - 3+)",
    x = NULL,
    y = NULL
  )+
  scale_size_continuous(name = "Number of cockles", limits = c(0,11))+
  facet_wrap(survey_name~year_class_category, nrow = 2)+
  coord_sf(xlim = c(1.16, 1.22), ylim = c(51.62, 51.66)) + #1.2833300510000001,51.4375000109999974 : 1.3624967240000001,51.4541666750000033
  theme_bw()+
  ggsci::scale_color_jco(name = "Survey date")+
  theme(legend.position = "bottom")

adult_year_classes_spatial_plot_area_8
#write plot as rds for report.
write_rds(adult_year_classes_spatial_plot_area_8,"C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/standardising_resurvey_grids/standardising_uneven_repeated_survey_grids/report/data/adult_year_classes_spatial_plot_area_8.rds")


#Area 15
surveyed_area_dir <- "C:/Users/Phillip Haupt/Documents/GIS/VMS/"
surveyed_area <- st_read(dsn = paste0(surveyed_area_dir, "cockles_vms_data_clustered.gpkg"), layer ="cockles_vms_data_clustered_area_15_tight")

# Area 15
# plot results - wgs - area 15
adult_year_classes_spatial_plot_area_15 <- ggplot() +
        geom_sf(data = surveyed_area, col = "grey") +
        geom_sf(data = combined_cln_1_to_3_sf[which(combined_cln_1_to_3_sf$area_code == "15"),],
                aes(abundance, size = abundance, col = survey_name)) +
        labs(
                title = "Area 15: Spatial distribution of adult cockles year classes (1 - 3+)",
                x = NULL,
                y = NULL
        )+
        scale_size_continuous(name = "Number of cockles", limits = c(0,20))+
        facet_wrap(survey_name~year_class_category, nrow = 2)+
        coord_sf(xlim = c(1.28, 1.37), ylim = c(51.43, 51.46)) + #1.2833300510000001,51.4375000109999974 : 1.3624967240000001,51.4541666750000033
        theme_bw()+
        ggsci::scale_color_jco(name = "Survey date")+
        theme(legend.position = "bottom")

adult_year_classes_spatial_plot_area_15
#write plot as rds for report.
write_rds(adult_year_classes_spatial_plot_area_15,"C:/Users/Phillip Haupt/Documents/SUSTAINABLE FISHERIES/cockle_fishery/standardising_resurvey_grids/standardising_uneven_repeated_survey_grids/report/data/adult_year_classes_spatial_plot_area_15.rds")


