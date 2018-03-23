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
# cat_id, adminname1, adminname2, changeset_id, version, continentcode)
landslides$hazard_type <- NULL
landslides$source_name <- NULL
landslides$source_link <- NULL
landslides$cat_src <- NULL
landslides$cat_id <- NULL
landslides$adminname1 <- NULL
landslides$adminname2 <- NULL
landslides$changeset_id <- NULL
landslides$version <- NULL
landslides$continentcode <- NULL

summary(landslides)


# There are several rows with missing information, starting the ones in the "fatalities" and
# "injuries" columns
landslides <- subset(landslides, !is.na(landslides$fatalities))

landslides <- subset(landslides, !is.na(landslides$injuries))

summary(landslides)

# Remove the missing values for population and distance
landslides <- subset(landslides, !is.na(landslides$population))
landslides <- subset(landslides, !is.na(landslides$distance))

summary(landslides)

# The column "countryname" and "country" basically contain the same information
# Except the column "countryname" doesn't contain contains blank cells
# Thus, we replace the column "country" by "countryname" and dump "countryname"
landslides$country <- as.character(landslides$countryname)
landslides$countryname <- NULL
summary(landslides)


# Renamings
landslides$landslide_type <- ifelse(landslides$landslide_type == "landslide",
                                    "Landslide", as.character(landslides$landslide_type))

landslides$landslide_type <- ifelse(landslides$landslide_type == "mudslide",
                                    "Mudslide", as.character(landslides$landslide_type))

##################
# VISUALIZATION #
##################

# Plot of number of number landslides cases per country
library(ggplot2)

win.graph(800, 600, 1000)
qplot(as.character(landslides$countrycode), xlab = "Country Code",
      main = "Landslides per country") +
      scale_y_continuous("Number of landlslides")


# Plot with respect to the types of landslides
qplot(landslides$landslide_type, xlab = "Landslide type",
      main = "Frequency of different types of landslides across the world") +
  scale_y_continuous("Frequency")



# Geographical locations
library(RgoogleMaps)
library(sp)
library(ggmap)

us_map <- get_map(location = "United States",
                  maptype = "satellite",
                  zoom = 10)
win.graph(800, 600, 10)
madPoints <- ggmap(us_map) + geom_point(aes(x = landslides.US$longitude,
                                            y = landslides.US$latitude),
                                        color = "red",
                                        alpha = 0.1, size = 1, data = landslides.US)
plot(madPoints)


# Collecting the landslides cases only from United States
landslides.US <- subset(landslides, landslides$countrycode == "US")
head(landslides.US)

col = as.numeric(landslides$landslide_type)
plotmap(landslides.US$latitude, landslides.US$longitude, zoom = 3, col = "red")
