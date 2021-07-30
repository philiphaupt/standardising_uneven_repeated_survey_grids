# plot map of survey area with high area inside


library(stars) 
chart <- stars::read_stars("C:/Users/Phillip Haupt/Documents/GIS/admirality_charts/Raster_Charts/20191002/Raster_Charts/RCx/No_Transformation/1183-0.tif")

plot(chart)
st_bbox(chart)

st_crs(chart)
# crop
ext2 <- st_bbox(chart_utm)
ext2[1] <- 100000
ext2[2] <- 150000
ext2[3] <- 6657833
area15_chart <- st_crop(chart, ext2)
image(area15_chart)

combined_cln_sf_utm <- st_as_stars(combined_cln_sf_utm)

# create circular clip
pol <- combined_cln_sf_utm %>% st_bbox() %>% st_as_sfc() %>% st_centroid() %>% st_buffer(300)

x <- x[,,,1]
plot(combined_cln_sf_utm[pol], size = abundance)
