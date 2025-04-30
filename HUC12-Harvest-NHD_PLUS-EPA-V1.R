---
title:


---
library (sf)

## library(tibble)
## library(gpkg)   



gdb <- path.expand("../Data")


Layers <- st_layers(gdb)

# print (Layers)


HUC12 <- st_read(dsn=gdb,layer="WBDHU12")

keepsHUC12 <- c("huc12","states","name","areasqkm", "areaacres")
HUC12DF_SF  <- subset(HUC12, select = keepsHUC12)
HUC12DF <- st_drop_geometry(HUC12DF_SF)


# Write CSV Location

# change back to starting directory
setwd(startup_dir)

# Then change to subdir off starting dir

setwd("./HUC-Data-Lists/")

# Write CSV Files
write.csv (HUC12DF, "National_HUC12List.csv")

q()










