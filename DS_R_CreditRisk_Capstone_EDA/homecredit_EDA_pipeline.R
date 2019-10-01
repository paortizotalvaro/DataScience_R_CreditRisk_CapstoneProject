###################################################################################################
# Pipeline to predict credit risk using Home Credit dataset

# Author: Paula Andrea Ortiz Otalvaro
# Created:  23-09-2019
# Modifications:   ---09-2019
#                  ---09-2019
#                  ---09-2019
#
###################################################################################################

# -------------------------------------------------------------------------------------------------
#                                 SET WORKING DIR TO FILE'S PATH
# -------------------------------------------------------------------------------------------------
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
print(getwd())

# -------------------------------------------------------------------------------------------------# --------------------------------------------------------------
#                                        LOAD PACKAGES
# -------------------------------------------------------------------------------------------------
library(tidyverse)
library(RColorBrewer)

# *************** LOAD MY OWN SCRIPTS (FUNCTIONS) **************
lapply(list.files(path = "../CreditRisk_DSCapstone_Rfunctions/", pattern = "[.]R$", recursive = TRUE, 
                  full.names = TRUE), source)

# -------------------------------------------------------------------------------------------------
#                                       GLOBAL VARIABLES
# -------------------------------------------------------------------------------------------------



# -------------------------------------------------------------------------------------------------
#                                         READ DATA  
#                               (uncomment a line when needed)
# -------------------------------------------------------------------------------------------------
filespath =  "../LoanData_HomeCredit/"
filenames_homecredit_raw <- c( "application_train", "application_test", "bureau", "bureau_balance",
                           "previous_application", "POS_CASH_balance", "installments_payments",
                           "credit_card_balance")

# ****************** Read raw data: ALL csv files and save them in disk as .RDS files *************
# csv2rds(filenames = filenames_homecredit_raw, filespath = filespath)

# ************************************ Read raw data: ALL .RDS files ******************************
# homecredit_listofdfs <- lapply(paste0(filespath, filenames_homecredit_raw,".RDS"), readRDS)
# names(homecredit_listofdfs) <- c( "train", "test", "bureau", "bureaubalance", "previousapp", "poscash",
#                        "installments", "creditcard")

# *************************** For now reading only application_train file  ************************
train <- readRDS(file = paste0(filespath,"application_train.RDS"))

# -------------------------------------------------------------------------------------------------
#                                     DATA WRANGLING
#               Transform raw data from original form to a more convenient form
# -------------------------------------------------------------------------------------------------
# **************** Order columns according to categories (see indices.R file)  ********************
train_ordered <- cbind(train[id_index_curr], 
                       train[target_index],
                       train[train_loaninfo_indices],
                       train[train_paperwork_indices],
                       train[train_personalinfo_indices],
                       train[train_contactinfo_indices],
                       train[train_work_indices],
                       train[train_properties_indices],
                       train[train_creditbureau_indices],
                       train[train_family_indices],
                       train[train_socialcircle_indices],
                       train[train_housing_indices],
                       train[train_NOIDEAWHERE_indices]
                       )
                       
                       

