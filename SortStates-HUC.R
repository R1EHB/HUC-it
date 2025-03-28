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

input_file <- '../HUC-it/HUC-Data-Lists/HUC12List.csv'

GRTS_df <- read.csv(input_file, header = TRUE, sep = ",",
  colClasses=c("character","character","character","character","numeric","numeric"))

head (GRTS_df)

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

head (VT_df)

## Define and open output files for each state and all of New England

# state_abbr <- c("CT","MA","ME","NH","RI","VT")
state_abbr_u <- c("CT MA ME NH RI VT")

New_England_HUCs_File  <- '../HUC-it/HUC-Data-Lists/New_England_HUCs.csv'
CT_HUCs_File <- '../HUC-it/HUC-Data-Lists/CT_HUCs.csv'
MA_HUCs_File <- '../HUC-it/HUC-Data-Lists/MA_HUCs.csv'
ME_HUCs_File <- '../HUC-it/HUC-Data-Lists/ME_HUCs.csv'
NH_HUCs_File <- '../HUC-it/HUC-Data-Lists/NH_HUCs.csv'
RI_HUCs_File <- '../HUC-it/HUC-Data-Lists/RI_HUCs.csv'
VT_HUCs_File <- '../HUC-it/HUC-Data-Lists/VT_HUCs.csv'

## Match and Sort Section

# print (GRTS_df[1,])

for (i in 1:nrow(GRTS_df)) {
    states_list <- str_split (GRTS_df[i,]$states, ',', simplify = TRUE)
      
    for (j in 1:length(states_list)) {
        # print (i)
        # print (j)
        # print (states_list[j])
        # print(state_abbr_u)

        if (is.na(states_list[j])) {
            # print ("Here is an NA")
        } else if (grepl(states_list[j], state_abbr_u,ignore.case = TRUE)) {
            NE_df <- rbind(NE_df,GRTS_df[i,])
            # print (GRTS_df[i,]$states)
            
           

            
        } else {
            ##print ("No match")
        }

    }

}

write.csv(NE_df,New_England_HUCs_File)

# ad (NE_df)



for (i in 1:nrow(NE_df)) {
    ## Second layer of matches by state for New England States
    if (grepl ("CT",NE_df[i,]$states, ignore.case = TRUE)) {
        CT_df <-rbind(CT_df, NE_df[i,])
    }
    
    else if (grepl ("MA",NE_df[i,]$states, ignore.case = TRUE)) {
        MA_df <-rbind(MA_df,NE_df[i,])
    }
    
    else if (grepl ("ME",NE_df[i,]$states, ignore.case = TRUE)) {
        ME_df <-rbind(ME_df,NE_df[i,] )
    }
    
    else if (grepl ("NH",NE_df[i,]$states, ignore.case = TRUE)) {
        NH_df <-rbind(NH_df,NE_df[i,] )
    }
    
    else if (grepl ("RI",NE_df[i,]$states, ignore.case = TRUE)) {
        RI_df <- rbind(RI_df,NE_df[i,] )
    }
    
    else if (grepl ("VT",NE_df[i,]$states, ignore.case = TRUE)) {
        VT_df <-rbind(VT_df,NE_df[i,] )
    }

    else {
        ## print ("not in New England")
    }
}


write.csv(CT_df, CT_HUCs_File)
write.csv(MA_df, MA_HUCs_File)
write.csv(ME_df, ME_HUCs_File)
write.csv(NH_df, NH_HUCs_File)
write.csv(RI_df, RI_HUCs_File)
write.csv(VT_df, VT_HUCs_File)

warnings()
q()
