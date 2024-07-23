# Get Current Watershed Boundary Dataset and related files to tease
# out HUC codes from the USA and surrounding boundary areas (Canada,
# Mexico) into a set of spreadsheets

# Load needed libraries

# Nov 2023: Refactor to replace obsolete rgdal package with sf or terra




if (!require (sf)) {
   install.packages("sf", repos="https://cloud.r-project.org")
   }

if (!require (curl)) {
   install.packages("curl", repos="https://cloud.r-project.org")
   }


#library (rgdal)
library (sf)
library (curl)
   

# Make and Set Working directory

# Relative to Startup Directory

dir.create ("../DataFetch/")
setwd("../DataFetch/")


print ("Download is about 2.2 Gb")

if (!file.exists("WBD_National_GDB.zip")) {
download.file("https://prd-tnm.s3.amazonaws.com/StagedProducts/Hydrography/WBD/National/GDB/WBD_National_GDB.zip",
	destfile="WBD_National_GDB.zip", method ="curl")
	} else print("File exists (but might need updating)")


# unzip this thing

# Currently uses a linux system call to unzip
system("unzip -n WBD_National_GDB.zip")

# Alternative is 
# # unzip(zipfile, files = NULL, list = FALSE, overwrite = TRUE,
# #      junkpaths = FALSE, exdir = ".", unzip = "internal",
# #      setTimes = FALSE)

### From utils library (?)


gdb <- path.expand("../DataFetch/WBD_National_GDB.gdb")


# Layers <- st_layers(gdb)

# print (Layers)

# HUC2 <- st_read(gdb)  #hu2 layer

# Note: HUC14 and HUC16 are experimental for USGS and not widely deployed

# Cluster the layer read operations by HUC level together

HUC2 <- st_read(dsn=gdb,layer="WBDHU2")
HUC4 <- st_read(dsn=gdb,layer="WBDHU4")
HUC6 <- st_read(dsn=gdb,layer="WBDHU6")
HUC8 <- st_read(dsn=gdb,layer="WBDHU8")
HUC10 <- st_read(dsn=gdb,layer="WBDHU10")
HUC12 <- st_read(dsn=gdb,layer="WBDHU12")
HUC14 <- st_read(dsn=gdb,layer="WBDHU14")
HUC16 <- st_read(dsn=gdb,layer="WBDHU16")


# Cluster Write Operations together

## Set non-geometric variables to drop and drop geometry

keepsHUC2  <- c("huc2","states","name","areasqkm", "areaacres")
HUC2DF_SF   <- subset(HUC2, select = keepsHUC2)
HUC2DF <- st_drop_geometry(HUC2DF_SF)

keepsHUC4  <- c("huc4","states","name","areasqkm", "areaacres")
HUC4DF_SF   <- subset(HUC4, select = keepsHUC4)
HUC4DF <- st_drop_geometry(HUC4DF_SF)

keepsHUC6  <- c("huc6","states","name","areasqkm", "areaacres")
HUC6DF_SF   <- subset(HUC6, select = keepsHUC6)
HUC6DF <- st_drop_geometry(HUC6DF_SF)

keepsHUC8  <- c("huc8","states","name","areasqkm", "areaacres")
HUC8DF_SF   <- subset(HUC8, select = keepsHUC8)
HUC8DF <- st_drop_geometry(HUC8DF_SF)

keepsHUC10 <- c("huc10","states","name","areasqkm", "areaacres")
HUC10DF_SF  <- subset(HUC10, select = keepsHUC10)
HUC10DF <- st_drop_geometry(HUC10DF_SF)

keepsHUC12 <- c("huc12","states","name","areasqkm", "areaacres")
HUC12DF_SF  <- subset(HUC12, select = keepsHUC12)
HUC12DF <- st_drop_geometry(HUC12DF_SF)

keepsHUC14 <- c("huc14","states","name","areasqkm", "areaacres")
HUC14DF_SF  <- subset(HUC14, select = keepsHUC14)
HUC14DF <- st_drop_geometry(HUC14DF_SF)

keepsHUC16 <- c("huc16","states","name","areasqkm", "areaacres")
HUC16DF_SF  <- subset(HUC16, select = keepsHUC16)
HUC16DF <- st_drop_geometry(HUC16DF_SF)

# Write CSV Location

# Current Directory

setwd("../HUC-Data-Lists/")

# Write CSV Files
write.csv (HUC2DF, "HUC2List.csv")
write.csv (HUC4DF, "HUC4List.csv")
write.csv (HUC6DF, "HUC6List.csv")
write.csv (HUC8DF, "HUC8List.csv")
write.csv (HUC10DF, "HUC10List.csv")
write.csv (HUC12DF, "HUC12List.csv")
write.csv (HUC14DF, "HUC14List.csv")
write.csv (HUC16DF, "HUC16List.csv")

q()


# ogrListLayers(gdb)

# Layers of Interest:
  # * WBDHU2
  # * WBDHU4
  # * WBDHU6
  # * WBDHU8
  # * WBDHU10
  # * WBDHU12		 
  # * WBDHU14
  # * WBDHU16

HUC2 <- readOGR(gdb, "WBDHU2")
# str (HUC2)

# Interested in only the @data, and of them, the fields:huc2, states, name

# Write CSV Location
setwd("../HUC-Data/")

keepsHUC2 <- c("huc2","states","name")
HUC2List <- HUC2@data[keepsHUC2]
# str (HUC2List)
rm (HUC2)
write.csv (HUC2List, "HUC2List.csv")

# Do similar for HUC4,etc
HUC4 <- readOGR(gdb, "WBDHU4")
keepsHUC4  <- c("huc4","states","name")
HUC4List <- HUC4@data[keepsHUC4]
rm (HUC4)
write.csv (HUC4List, "HUC4List.csv")



HUC6 <- readOGR(gdb, "WBDHU6")
keepsHUC6  <- c("huc6","states","name")
HUC6List <- HUC6@data[keepsHUC6]
rm(HUC6)
write.csv (HUC6List, "HUC6List.csv")

HUC8 <- readOGR(gdb, "WBDHU8")
keepsHUC8  <- c("huc8","states","name")
HUC8List   <- HUC8@data[keepsHUC8]
rm (HUC8)
write.csv (HUC8List, "HUC8List.csv")

HUC10 <- readOGR(gdb, "WBDHU10")
keepsHUC10 <- c("huc10","states","name")
HUC10List  <- HUC10@data[keepsHUC10]
rm (HUC10)
write.csv (HUC10List, "HUC10List.csv")

HUC12 <- readOGR(gdb, "WBDHU12")
keepsHUC12 <- c("huc12","states","name")
HUC12List <- HUC12@data[keepsHUC12]
rm (HUC12)
write.csv (HUC12List, "HUC12List.csv")

HUC14 <- readOGR(gdb, "WBDHU14")
keepsHUC14 <- c("huc14","states","name")
HUC14List <- HUC14@data[keepsHUC14]
rm(HUC14)
write.csv (HUC14List, "HUC14List.csv")

HUC16 <- readOGR(gdb, "WBDHU16")
keepsHUC16 <- c("huc16","states","name")
HUC16List <- HUC16@data[keepsHUC16]
rm(HUC16)
write.csv (HUC16List, "HUC16List.csv")










