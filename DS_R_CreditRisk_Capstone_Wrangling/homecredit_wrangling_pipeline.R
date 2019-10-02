###################################################################################################
# Pipeline to predict credit risk using Home Credit dataset

# Author: Paula Andrea Ortiz Otalvaro
# Created:  23-09-2019
# Modifications:   29-09-2019
#                  30-09-2019
#                  01-10-2019
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
lapply(list.files(path = "../DS_R_CreditRisk_Capstone_Rfunctions/", pattern = "[.]R$", recursive = TRUE, 
                  full.names = TRUE), source)

# -------------------------------------------------------------------------------------------------
#                                       GLOBAL VARIABLES
# -------------------------------------------------------------------------------------------------



# -------------------------------------------------------------------------------------------------
#                                         READ DATA  
#                               (uncomment a line when needed)
# -------------------------------------------------------------------------------------------------
filespath =  "../../LoanData_HomeCredit/"
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
#                                         DATA WRANGLING
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

train_ordered <- train_ordered %>% 
                 
                 # DAYS_BIRTH: change from days to years (and change column name)
                 mutate(DAYS_BIRTH = round(DAYS_BIRTH/-365, digits = 2)) %>% 
                 rename(YEARS_BIRTH = DAYS_BIRTH) %>%
                 # DAYS_EMPLOYED: change from days to years (and change column name) %>%
                 mutate(DAYS_EMPLOYED = round(DAYS_EMPLOYED/-365, digits = 2)) %>% 
                 rename(YEARS_EMPLOYED = DAYS_EMPLOYED) %>%
                 # DAYS_REGISTRATION: change from days to years (and change column name) %>%
                 mutate(DAYS_REGISTRATION = round(DAYS_REGISTRATION/-365, digits = 2)) %>% 
                 rename(YEARS_REGISTRATION = DAYS_REGISTRATION) %>%
                 # DAYS_ID_PUBLISH: change from days to years (and change column name)
                 mutate(DAYS_ID_PUBLISH = round(DAYS_ID_PUBLISH/-365, digits = 2)) %>% 
                 rename(YEARS_ID_PUBLISH = DAYS_ID_PUBLISH) %>%
                 # DAYS_LAST_PHONE_CHANGE: change from days to years (and change column name)
                 mutate(DAYS_LAST_PHONE_CHANGE = round(DAYS_LAST_PHONE_CHANGE/-365, digits = 2)) %>% 
                 rename(YEARS_LAST_PHONE_CHANGE = DAYS_LAST_PHONE_CHANGE) %>%
  
                 # Change all categorical variables to factor type
                 mutate_at(train_categorical_indices, funs(factor)) %>%

                 # Replace bad data in YEARS_EMPLOYED with NaN
                 mutate(YEARS_EMPLOYED=replace(YEARS_EMPLOYED, YEARS_EMPLOYED==-1000.67, NaN))
                 

#format also train (without changing data in years_employed)
train <- train %>%
  
         # DAYS_BIRTH: change from days to years (and change column name)
         mutate(DAYS_BIRTH = round(DAYS_BIRTH/-365, digits = 2)) %>% 
         rename(YEARS_BIRTH = DAYS_BIRTH) %>%
         # DAYS_EMPLOYED: change from days to years (and change column name) %>%
         mutate(DAYS_EMPLOYED = round(DAYS_EMPLOYED/-365, digits = 2)) %>% 
         rename(YEARS_EMPLOYED = DAYS_EMPLOYED) %>%
         # DAYS_REGISTRATION: change from days to years (and change column name) %>%
         mutate(DAYS_REGISTRATION = round(DAYS_REGISTRATION/-365, digits = 2)) %>% 
         rename(YEARS_REGISTRATION = DAYS_REGISTRATION) %>%
         # DAYS_ID_PUBLISH: change from days to years (and change column name)
         mutate(DAYS_ID_PUBLISH = round(DAYS_ID_PUBLISH/-365, digits = 2)) %>% 
         rename(YEARS_ID_PUBLISH = DAYS_ID_PUBLISH) %>%
         # DAYS_LAST_PHONE_CHANGE: change from days to years (and change column name)
         mutate(DAYS_LAST_PHONE_CHANGE = round(DAYS_LAST_PHONE_CHANGE/-365, digits = 2)) %>% 
         rename(YEARS_LAST_PHONE_CHANGE = DAYS_LAST_PHONE_CHANGE) %>%
         
         # Change all categorical variables to factor type
         mutate_at(train_categorical_indices, funs(factor))
  
                 
                       
# -------------------------------------------------------------------------------------------------
#                                   PLOT CATEGORICAL VARIABLES
# -------------------------------------------------------------------------------------------------

# *********************** Pie charts for variables with only 2 categories  ************************
# data frame with only categorical columns
categocols_df <- train[train_categorical_indices]

# check categorical columns: find the ones with only 2 categories
numberofcategories <- lapply(categocols_df, function(x){length(unique(x))})
twocatego_indices <- which(numberofcategories==2)
twocatego_df <- categocols_df[names(twocatego_indices)]

#make a grid of pie charts and save it to a pdf
plot_grid_piecharts(mydf = twocatego_df, column_names = names(twocatego_df) ,
                    pdfplot_name = "train")

# ******************* Bar charts for variables with more than 2 categories  ***********************
# check categorical columns: find the ones with MORE THAN 2 categories
manycatego_indices <- which(numberofcategories>2)
manycatego_df <- categocols_df[names(manycatego_indices)]

#make a grid of pie charts and save it to a pdf
plot_grid_barcharts(mydf = manycatego_df, column_names = names(manycatego_df) ,
                    pdfplot_name = "train")


# -------------------------------------------------------------------------------------------------
#                                   PLOT CONTINUOUS VARIABLES
# -------------------------------------------------------------------------------------------------



# **************************** Histograms for continuous variables ********************************
# data frame with only continuous columns

continuouscols_df <- train[train_continuous_indices]

#make a grid of pie charts and save it to a pdf
plot_grid_histograms(mydf = continuouscols_df, column_names = names(continuouscols_df) , 
                    pdfplot_name = "train_continuous")


