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
landslides$local_description <- NULL
landslides$photos_link <- NULL
