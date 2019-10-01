###################################################################################################
# This script contains functions to read the home credit data set
#
# Author: Paula Andrea Ortiz Otalvaro
# Created:  06-09-2019
# Modifications:   09-09-2019
#
###################################################################################################


# -------------------------------------------------------------------------------------------------
#                  READ .csv FILES IN HOME CREDIT DATA SET AND SAVE THEM AS .RDS
# This function reads all the csv files in the home credit data set and saves them as RDS in the 
# same folder where the csv files are located. Any blank or empty entries are converted into NA.
# 
### Arguments:
#   filenames : list of names of csv files (without the csv extension) 
#   filespath : path of parent folder where .csv files are
#
### Return: 
#           
# -------------------------------------------------------------------------------------------------
csv2rds <- function(filenames,filespath){
  
  for( filename in filenames){
    print(paste0(filespath,filename,".csv"))
    df <- read.csv(paste0(filespath,filename,".csv"), sep=",",
                   stringsAsFactors = FALSE, na.strings = c(""," ",NA))
    
    saveRDS(df, paste0(filespath,filename,".RDS"))
  }
  
}




# -------------------------------------------------------------------------------------------------
#                                   READ RAW DATA (.RDS files)
#   filenames : list of names of csv files (without the csv extension) 
#   filespath : path of parent folder where .csv files are
#
#   listofdfs : list of data frames with all data from RDS files        
# -------------------------------------------------------------------------------------------------
filespath =  "../LoanData_HomeCredit/"
# filenames_homecredit <- c( "application_train", "application_test", "bureau", "bureau_balance", 
#                            "previous_application", "POS_CASH_balance", "installments_payments", 
#                            "credit_card_balance")
# listofdfs <- lapply(paste0(filespath, filenames_homecredit,".RDS"), readRDS)
# names(listofdfs) <- c( "train", "test", "bureau", "bureaubalance", "previousapp", "poscash",
#                        "installments", "creditcard")








