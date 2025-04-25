## Sort HUC12 codes  into state lists
##
## Read Previously generated CSV file with list of national HUC codes
## and state names


## Read in CSV

## Check each row for a New England State

## Mark the row as true or false

## save the new data as a csv file

## Need to be careful not to strip off the leading zero of most HUC12s
##

## Use stringr for string splitting function str_split
library(stringr)

input_file <- '../HUC-it/HUC-Data-Lists/National_HUC12List.csv'

GRTS_df <- read.csv(input_file, header = TRUE, sep = ",",
  colClasses=c("character","character","character","character","numeric","numeric"))


columns =c("X","huc12","states","name","areasqkm","areaacres")

NE_df = data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(NE_df) = columns

CT_df = data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(CT_df) = columns

MA_df = data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(MA_df) = columns

ME_df = data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(ME_df) = columns

NH_df = data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(NH_df) = columns

RI_df = data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(RI_df) = columns

VT_df = data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(VT_df) = columns

Canada_df = data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(Canada_df) = columns

NY_df = data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(NY_df) = columns

Miss_NA_df = data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(Miss_NA_df) = columns


## Define and open output files for each state and all of New England

# state_abbr <- c("CT","MA","ME","NH","RI","VT")
state_abbr_u <- c("CT MA ME NH RI VT") 
# neighbors <- c("NY CN")

New_England_HUC12s_File  <- '../HUC-it/HUC-Data-Lists/New_England_HUC12s.csv'




CT_HUCs_File <- '../HUC-it/HUC-Data-Lists/CT_HUCs.csv'
MA_HUCs_File <- '../HUC-it/HUC-Data-Lists/MA_HUCs.csv'
ME_HUCs_File <- '../HUC-it/HUC-Data-Lists/ME_HUCs.csv'
NH_HUCs_File <- '../HUC-it/HUC-Data-Lists/NH_HUCs.csv'
RI_HUCs_File <- '../HUC-it/HUC-Data-Lists/RI_HUCs.csv'
VT_HUCs_File <- '../HUC-it/HUC-Data-Lists/VT_HUCs.csv'

Canada_HUCs_File <- '../HUC-it/HUC-Data-Lists/CN_HUCs.csv'
NY_HUCs_File <- '../HUC-it/HUC-Data-Lists/NY_HUCs.csv'

Missing_NA_HUCs_File <- '../HUC-it/HUC-Data-Lists/Missing_NA__HUCs.csv'

## Match and Sort Section

# print (GRTS_df[1,])

for (i in 1:nrow(GRTS_df)) {
    states_list <- str_split (GRTS_df[i,]$states, ',', simplify = TRUE)
      
    for (j in 1:length(states_list)) {
        
        if (is.na(states_list[j])) {
            # print ("Here is an NA")
            Miss_NA_df <- rbind(Miss_NA_df,GRTS_df[i,])
            
        } else if (!nzchar(states_list[j])) {
            # print ("Here is a blank state")
            Miss_NA_df <- rbind(Miss_NA_df,GRTS_df[i,])
                        
        }

	else {


            if (grepl(states_list[j], state_abbr_u,ignore.case = TRUE)) {
             	NE_df <- rbind(NE_df,GRTS_df[i,])
	    	# print ("State List is: " )
	    	# print (states_list)

            }

            if (grepl(states_list[j], "CN", ignore.case = TRUE)) {
	     	Canada_df <- rbind(Canada_df,GRTS_df[i,])
                
            }

            if (grepl(states_list[j], "NY", ignore.case = TRUE)) {
                NY_df <- rbind(NY_df,GRTS_df[i,])

            }
	
        }

    }
}




## Write the Missing and 'NA' HUCs to mention to USGS

write.csv(Miss_NA_df, Missing_NA_HUCs_File)

## Write the NY and Canadian HUCs to file
write.csv(NY_df, NY_HUCs_File)
write.csv(Canada_df, Canada_HUCs_File)


## Sort NE file by HUC

## Nice to have, needed later in unique step

## na.last = NA means drop those with NA
NE_df <- NE_df[order(NE_df$huc12, decreasing = FALSE, na.last = NA, method = "auto"),]




for (i in 1:nrow(NE_df)) {
    ## Second layer of matches by state for New England States

    if (grepl ("CT",NE_df[i,]$states, ignore.case = TRUE)) {
       	
        CT_df <-rbind(CT_df, NE_df[i,])
	CT_df$sorted_state <- "CT" 
    }

    if (grepl ("MA",NE_df[i,]$states, ignore.case = TRUE)) {
       	NE_df$sorted_state <- "MA" # Write only one state, our main of interest
        MA_df <-rbind(MA_df,NE_df[i,])
	MA_df$sorted_state <- "MA"	
    }

    if (grepl ("ME",NE_df[i,]$states, ignore.case = TRUE)) {
    	NE_df$sorted_state <- "ME" # Write only one state, our main of interest
        ME_df <-rbind(ME_df,NE_df[i,] )
	ME_df$sorted_state <- "ME" 
    }

    if (grepl ("NH",NE_df[i,]$states, ignore.case = TRUE)) {
       	NE_df$sorted_state <- "NH" # Write only one state, our main of interest
        NH_df <-rbind(NH_df,NE_df[i,] )
	NH_df$sorted_state <- "NH"
    }

    if (grepl ("RI",NE_df[i,]$states, ignore.case = TRUE)) {
       	NE_df$sorted_state <- "RI" # Write only one state, our main of interest			
        RI_df <- rbind(RI_df,NE_df[i,] )
	RI_df$sorted_state <- "RI" 
    }

    if (grepl ("VT",NE_df[i,]$states, ignore.case = TRUE)) {
    	NE_df$sorted_state <- "VT" # Write only one state, our main of interest
        VT_df <-rbind(VT_df,NE_df[i,] )
	VT_df$sorted_state <- "VT" 
  	   
    } 
}


write.csv(CT_df, CT_HUCs_File)
write.csv(MA_df, MA_HUCs_File)
write.csv(ME_df, ME_HUCs_File)
write.csv(NH_df, NH_HUCs_File)
write.csv(RI_df, RI_HUCs_File)
write.csv(VT_df, VT_HUCs_File)


NE_df <- unique(NE_df)

# head (NE_df)

write.csv(NE_df,New_England_HUC12s_File)

warnings()
q()
