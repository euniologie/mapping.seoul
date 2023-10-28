### directory setting
getwd()
setwd("~/Desktop/mapping_sungeun")


### loading files (download packages before loading them)
# you can either use R.data or combine shp and csv files
# I used separate shp and csv files and merged them
library(maptools)
library(readr)

#1.loading shp files
seoul <- readShapePoly("SEOUL.shp")

#2.loading csv files
green.csv <- read_csv("greenery.csv", locale = locale(encoding = "UTF-8"))
green.csv <- read.csv("greenery.csv", , stringsAsFactors = T, na = "-", 
                      encoding = "UTF-8")
colnames(green.csv)[colnames(green.csv) == "greenery_num"] <- "number of greenery"

#3.merge shp and csv files
seoul.sp <- merge(seoul,green.csv)
save(seoul.sp, file="seoul.RData")
load("seoul.Rdata")


### mapping, using "tmap" package
library(tmap)
tmap_mode("view")
# this function activates the interactive mode of the map

map <- tm_shape(seoul.sp)+tm_polygons("number of greenery")
# enter the name of polygon after tm_shape
# enter the name of the variable after tm_polygons

### customizing the map
# 1. adding the title
map + tm_layout(title = "Greenery of Seoul")
# i couldn't figure out how to move the title position

# 2. changing the categorization 
tm_shape(seoul.sp)+tm_polygons("number of greenery", style="quantile", title ="Number of Greenery")
# style includes jenks (default), quantile, and etc.

# 3. changing the colors, adding labels on the map
map2 <- tm_shape(seoul.sp) + 
  tm_polygons(col = "number of greenery", palette = "viridis", title = "Number of Greenery") +
  tm_text(text = "SIG_KOR_NM", size = 0.5)
# check out for more palette -> https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/)
# i couldn't figure out how to edit the label of the bubble that pops up whenever you click the region
map2 + tm_layout(title = "Greenery of Seoul")


### uploading the map to the website
# 1. click export button above the map
# 2. click "save as web page"
# 3. after saving the map as html, open the file and check the html code (you can check the code conveniently w/ f12 key)
# 4. copy the whole html code and embed it on your own website
# 5. done
