# Get Current Watershed Boundary Dataset and related files to tease
# out HUC codes from the USA and surrounding boundary areas (Canada,
# Mexico) into a set of spreadsheets

# Load needed libraries

# Nov 2023: Refactor to replace obsolete rgdal package with sf or terra
# April 2024: Adding a bit more info on transition to SF

# st_layers is part of SF package


if (!require (sf)) {
   install.packages("sf", repos="https://cloud.r-project.org")
   }

if (!require (curl)) {
   install.packages("curl", repos="https://cloud.r-project.org")
   }


#library (rgdal)
library (sf)
library (curl)
library(tibble)
   

# Make and Set Working directory

# Relative to Startup Directory

# Save Current Directory

startup_dir <- getwd()

dir.create ("../DataFetch/")
dir.create("./HUC-Data-Lists/")
setwd("../DataFetch/")

base_dir <- "https://prd-tnm.s3.amazonaws.com/index.html?prefix=StagedProducts/Hydrography/WBD/National/"

g_types = as_tibble_col("GDB","GPKG")

GDB_fnames <- tibble_row(files="WBD_National_GDB.jpg",
		        "WBD_National_GDB.xml","WBD_National_GDB.zip")

GPKG_fnames <- tibble_row(files="WBD_National_GPKG.jpg",
			"WBD_National_GPKG.xml","WBD_National_GPKG.zip")

str (GPKG_fnames)

fnames <- tibble_row (names=GDB_fnames)

print (fnames)

quit()

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

# change back to starting directory
setwd(startup_dir)

# Then change to subdir off starting dir

setwd("./HUC-Data-Lists/")

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










