# Loading the dataset
landslides <- read.csv("Data/Global_Landslide_Catalog_Export.csv", header = TRUE)

######################
# Data Understanding #
######################
summary(landslides)
View(landslides)



####################
# Data Preparation #
####################

# Ignoring the time column (because it lacks too much information)
landslides$time <- NULL
summary(landslides)


# Same for storm_name, local_description, photos_link
landslides$storm_name <- NULL
landslides$location_description <- NULL
landslides$photos_link <- NULL

summary(landslides)


# Now, let's delete the irrelevant columns (hazard_type, source_name, source_link, cat_src,
# cat_id, adminname1, adminname2, changeset_id, version)
landslides$hazard_type <- NULL
landslides$source_name <- NULL
landslides$source_link <- NULL
landslides$cat_src <- NULL
landslides$cat_id <- NULL
landslides$adminname1 <- NULL
landslides$adminname2 <- NULL
landslides$changeset_id <- NULL
landslides$version <- NULL

summary(landslides)
