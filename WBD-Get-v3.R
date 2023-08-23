# Get Current Watershed Boundary Dataset and related files to tease
# out HUC codes from the USA and surrounding boundary areas (Canada,
# Mexico) into a set of spreadsheets

# Load needed libraries



if (!require (rgdal)) {
   install.packages("rgdal", repos="https://cloud.r-project.org")
   }

library (rgdal)
library (curl)
   

# Make and Set Working directory

# Relative to Startup Directory

dir.create ("../DataFetch/")
setwd("../DataFetch/")


print ("Download is about 2.2 Gb")

# if (!file.exists("WBD_National_GDB.zip")) {
# download.file("https://prd-tnm.s3.amazonaws.com/StagedProducts/Hydrography/WBD/National/GDB/WBD_National_GDB.zip",
#	destfile="WBD_National_GDB.zip", method ="curl")
#	} else print("File exists (but might need updating)")



# unzip this thing

# Currently uses a linux system call to unzip
# system("unzip -n WBD_National_GDB.zip")


gdb <- path.expand("../DataFetch/WBD_National_GDB.gdb")

print (gdb)

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
# Write HUC12 list with names
write.csv (HUC12List, "HUC12List.csv")

# Write just the HUC12 list
write.csv (HUC12List$huc12, "HUC12Vector.csv")

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










