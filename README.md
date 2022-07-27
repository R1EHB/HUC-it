# HUC-it
R code to extract hydrologic unit code numbers (HUC) from the USGS
Watershed Boundary Dataset (WBD).

Code is in file WBD-Get-v2.R WBD_National_GDB.xml contains the
metadata for the version of the dataset pulled (July 27, 2022).

HUCxList.csv are the resulting data pulled from the WBD by this code
(June 27, 2022 using WBD version of July 7, 2022) at the x HUC level,
where x is one of {2,4,6,8,10,12,14,16}. Also created is an
abbreviated data set of HUC12 numbers without the HUC names, etc.

