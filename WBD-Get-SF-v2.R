# Get Current Watershed Boundary Dataset and related files to tease
# out HUC codes from the USA and surrounding boundary areas (Canada,
# Mexico) into a set of spreadsheets

# Load needed libraries

# Nov 2023: Refactor to replace obsolete rgdal package with sf or terra
# April 2024: Adding a bit more info on transition to SF

# st_layers is part of SF package

# April 2025: Minor refinements

if (!require (sf)) {
   install.packages("sf", repos="https://cloud.r-project.org")
   }

if (!require (curl)) {
   install.packages("curl", repos="https://cloud.r-project.org")
   }

if (!require (tibble)) {
   install.packages("tibblecurl", repos="https://cloud.r-project.org")
   }

if (!require (gpkg)) {
   install.packages("gpkg", repos="https://cloud.r-project.org")
   }
   
#library (rgdal)
library (sf)
library (curl)
library(tibble)
library(gpkg)   

# Make and Set Working directory

# Relative to Startup Directory

# Save Current Directory

startup_dir <- getwd()

dir.create ("../DataFetch/")
dir.create("./HUC-Data-Lists/")
setwd("../DataFetch/")

# Not right url base for scripting
# base_dir <- "https://prd-tnm.s3.amazonaws.com/index.html?prefix=StagedProducts/Hydrography/WBD/National"

base_dir <- "https://prd-tnm.s3.amazonaws.com/StagedProducts/Hydrography/WBD/National"

g_types = c("/GDB/","/GPKG/")

GDB_fnames <- c("WBD_National_GDB.jpg",
		"WBD_National_GDB.xml","WBD_National_GDB.zip")

GPKG_fnames <- c("WBD_National_GPKG.jpg",
		 "WBD_National_GPKG.xml","WBD_National_GPKG.zip")


str (base_dir)
str (GPKG_fnames)
str (GDB_fnames)
str (g_types)


get_file <- function(base_dir_, g_type_,f_name_) {
  compose_filename <- paste(base_dir_,g_type_,f_name_,sep = "")
  print(compose_filename)
  print(f_name_)
  
  if (!file.exists(f_name_)) {
    download.file(compose_filename, destfile=f_name_, method = "curl")
    # Check to see if it is a zip file; if so, unzip it
    is_zip <- grepl(".zip", f_name_,ignore.case=TRUE)

    if (is_zip) {
        command_string = paste ("unzip -u",f_name_, sep = " ")
	system(command_string)
    }	
  }
}

  
for (a in  1:3) {
 
  get_file(base_dir,g_types[1],GDB_fnames[a])
    }

for (b in 1:3) {
  get_file(base_dir,g_types[2],GPKG_fnames[b])
    }
  


# Currently uses a linux system call to unzip
# system("unzip -n WBD_National_GDB.zip")

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

## NOTE:: For some pacific island territories, the State is either coded as NA or ''. April 2025

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
write.csv (HUC2DF, "National_HUC2List.csv")
write.csv (HUC4DF, "National_HUC4List.csv")
write.csv (HUC6DF, "National_HUC6List.csv")
write.csv (HUC8DF, "National_HUC8List.csv")
write.csv (HUC10DF, "National_HUC10List.csv")
write.csv (HUC12DF, "National_HUC12List.csv")
write.csv (HUC14DF, "National_HUC14List.csv")
write.csv (HUC16DF, "National_HUC16List.csv")

q()










