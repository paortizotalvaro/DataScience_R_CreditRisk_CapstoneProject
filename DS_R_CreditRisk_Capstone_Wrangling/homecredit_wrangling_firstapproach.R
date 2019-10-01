################################################################
# This script contains functions to explore the homecredit dataset

# # To work properly this function require:
#   
### Arguments:
#   homecredit_originaldf : data frame with 
#
### Return: 
#    
#
#
# Author: Paula Andrea Ortiz Otalvaro
# Created:  06-09-2019
# Modifications:   09-09-2019
#                  10-09-2019
#                  18-09-2019
#
################################################################

# --------------------------------------------------------------
#           SET WORKING DIR TO FILE PATH
# --------------------------------------------------------------
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
print(getwd())

# --------------------------------------------------------------
#                        LOAD PACKAGES
# --------------------------------------------------------------
library(tidyverse)
library(RColorBrewer)

# --------------------------------------------------------------
#                LOAD MY OWN SCRIPTS (FUNCTIONS)
# --------------------------------------------------------------  
lapply(list.files(path = "../Intro2DS_Capstone_Rfunctions/", pattern = "[.]R$", recursive = TRUE, full.names = TRUE), 
       source)

# --------------------------------------------------------------
#                       GLOBAL VARIABLES
# --------------------------------------------------------------  


# *********** Features separated according to theme ***********
#                   in train and test sets
id_index_curr <- 1
train_loaninfo_indices <- c(3, 9, 10, 11, 33, 34 )
train_personalinfo_indices <- c(4, 14, 18, 21)
train_properties_indices <- c(5, 6, 22 )
train_family_indices <- c(7, 15, 30 )
train_work_indices <- c(8, 13, 19, 29, 41  )
train_buildinginfo_indices <- c(45:91) # continuous most of them
train_housing_indices <- c(16, 17, 31, 32, 35:40, train_buildinginfo_indices )
train_contactinfo_indices <- c(23:28, 96 )
train_socialcircle_indices <- c(92:95)
train_paperwork_indices <- c(97:116) # categorical
train_creditbureau_indices <- c(117:122) # categorical

# I don't understand what they are 
train_NOIDEAWHERE_indices <- c(12, 20, 42, 43, 44 )


# *********** Separate features into data types **************
# define which columns are categorical and non categorical

# train
train_categorical_indices <- c(2:7, 12:16, 23:40, 41, 87, 88, 90:95, train_paperwork_indices, train_creditbureau_indices)
train_continuous_indices <- c(8:11, 17:22, 42, 43, 44, train_buildinginfo_indices, 96)

# test
test_categorical_indices <- train_categorical_indices[-1] - 1
test_continuous_indices <- train_continuous_indices - 1

# bureau 
bureau_id_index <- 1
bureau_categorical_indices <- c(3, 4, 15 )
bureau_continuous_indices <- c(2, 5:9, 10:14, 16, 17 )

# bureau balance 
bureaubalance_id_index <- 1
bureaubalance_categorical_indices <- c(2, 3)

# Previous Applications 
previousapp_id_index_prev <- 1
previousapp_id_index_curr <- 2
previousapp_categorical_indices <- c(3, 9:12, 16, 17, 19:26, 28:31, 37)
previousapp_continuous_indices <- c(4:8, 13, 14, 15, 18, 27, 32:36)  

# Pos cash balance 
poscash_id_index_prev <- 1
poscash_id_index_curr <- 2
poscash_categorical_indices <- c(3, 4, 5, 6)
poscash_continuous_indices <- c(7, 8)

# Installments 
installments_id_index_prev <- 1
installments_id_index_curr <- 2
installments_categorical_indices <- c(3, 4)
installments_continuous_indices <- c(5:8)

# Credit card balance 
creditcard_id_index_prev <- 1
creditcard_id_index_curr <- 2
creditcard_categorical_indices <- c(3, 16:21)
creditcard_continuous_indices <- c(4:15, 22, 23)

#  *********** Make a list with all the lists having the indices of categorical variables (in each df)  ***********
listoflists_categorical_indices <- list(train = train_categorical_indices, test = test_categorical_indices, 
                                        bureau = bureau_categorical_indices, bureaubalance = bureaubalance_categorical_indices, 
                                        previousapp = previousapp_categorical_indices, poscash = poscash_categorical_indices, 
                                        installments = installments_categorical_indices, creditcard = creditcard_categorical_indices )
#names(listoflists_categorical_indices) <- c("train", "test", "bureau", "bureaubalance", "previousapp", "poscash", "installments", 
#                                            "creditcard")



#  *********** Make a list with all the lists having the indices of continuous variables (in each df)  ***********
names_continuos <- c( )
########################FINISH


# --------------------------------------------------------------
#                   READ ORIGINAL DATA (.RDS files)
#   filenames : list of names of csv files (without the csv extension) 
#   filespath : path of parent folder where .csv files are
#
#   listofdfs : list of data frames with all data from RDS files        
# --------------------------------------------------------------
filespath =  "../LoanData_HomeCredit/"
# 
# filenames_homecredit <- c( "application_train", "application_test", "bureau", "bureau_balance", 
#                            "previous_application", "POS_CASH_balance", "installments_payments", 
#                            "credit_card_balance")
# 
# #temp = list.files(pattern="*.RDS") #another option
# listofdfs = lapply(paste0(filespath, filenames_homecredit,".RDS"), readRDS)
# names(listofdfs) <- c( "train", "test", "bureau", "bureaubalance", "previousapp", "poscash", "installments", 
#                       "creditcard")

# --------------------------------------------------------------
#      ADD 'TARGET' COLUMN TO ALL DATA FRAMES (for EDA)
# The resulting data frames are saved to disk as RDS files to save 
# time when reproducing the analysis (uncomment when desired)
# --------------------------------------------------------------
# # first merge bureau and bureaubalance as bureaubalance doesn't have 'SK_ID_CURR'
# bureau_all <- merge(listofdfs[['bureau']], listofdfs[['bureaubalance']], by = 'SK_ID_BUREAU', all.x = TRUE)
# 
# # Merge all data frames with 'TARGET' column from train data frame, 
# bureau_train <- merge(listofdfs[['train']][1:2], bureau_all, by = 'SK_ID_CURR', all.x = TRUE)
# previousapp_train <- merge(listofdfs[['train']][1:2], listofdfs[['previousapp']], by = 'SK_ID_CURR', all.x = TRUE)
# poscash_train <- merge(listofdfs[['train']][1:2], listofdfs[['poscash']], by = 'SK_ID_CURR', all.x = TRUE)
# installments_train <- merge(listofdfs[['train']][1:2], listofdfs[['installments']], by = 'SK_ID_CURR', all.x = TRUE)
# creditcard_train <- merge(listofdfs[['train']][1:2], listofdfs[['creditcard']], by = 'SK_ID_CURR', all.x = TRUE)
# 
# # write all these data frames to disk
# saveRDS(bureau_train, file = paste0(filespath,"bureau_train.RDS"))
# saveRDS(previousapp_train, file = paste0(filespath,"previousapp_train.RDS"))
# saveRDS(poscash_train, file = paste0(filespath,"poscash_train.RDS"))
# saveRDS(installments_train, file = paste0(filespath,"installments_train.RDS"))
# saveRDS(creditcard_train, file = paste0(filespath,"creditcard_train.RDS"))

# read .RDS files: data frames with 'TARGET' already in each of them (as second column)
train <- readRDS(file = paste0(filespath,"application_train.RDS"))
bureau_train <- readRDS(file = paste0(filespath,"bureau_train.RDS"))
previousapp_train <- readRDS(file = paste0(filespath,"previousapp_train.RDS"))
poscash_train <- readRDS(file = paste0(filespath,"poscash_train.RDS"))
installments_train <- readRDS(file = paste0(filespath,"installments_train.RDS"))
creditcard_train <- readRDS(file = paste0(filespath,"creditcard_train.RDS"))

# all data frames in one list
train_listofdfs <- list(train = train, #bureau_train = bureau_train, 
                        previousapp_train = previousapp_train, poscash_train = poscash_train,
                      installments_train = installments_train, creditcard_train = creditcard_train)

# ************* indices of categorical variables ***************
# for bureau_train the two columns of bureau_balance are added (since those 2 were merged):
bureautrain_categorical_indices <- c(bureau_categorical_indices + 1, 19, 20)

# the indices for categorical and continuous variables shift when adding TARGET as extra column
categoindices_trainsets_listoflists <- list(train = train_categorical_indices,
                                        bureau_train = bureautrain_categorical_indices,
                                        previousapp_train = c(2, previousapp_categorical_indices + 1), 
                                        poscash_train = c(2, poscash_categorical_indices + 1), 
                                        installments_train = c(2, installments_categorical_indices + 1), 
                                        creditcard_train = c(2, creditcard_categorical_indices + 1) )

# --------------------------------------------------------------
#                    PLOT CATEGORICAL VARIABLES
# --------------------------------------------------------------

listoflists_piecharts <- list()
barcharts_listoflists <- list()
counter_df <- 1
for(name_df in names(categoindices_trainsets_listoflists)[2:3] ){
  
  df <- train_listofdfs[[name_df]]
  indices_list <- categoindices_trainsets_listoflists[[name_df]]
  df_categoriccols <- df[indices_list]
  
  # **************************************************************      
  # Get a pie chart for all categorical variables with 2 categories
  # **************************************************************      
  # get indices for variables with only 2 categories
  
  number_catego <- lapply(df_categoriccols, function(x){length(unique(x))})
  ids_twocatego <- which(number_catego==2)  #indices in the df_categoriccols df
  cols_twocatego <- df_categoriccols[names(ids_twocatego)]
  
  if(length(ids_twocatego) > 0){
  
    # make pie charts for varaibles with 2 categories in the current df
    list_piecharts <- lapply(X = names(ids_twocatego), 
                             FUN = plot_piechart, data_df = df_categoriccols )
  
    # add the list of piecharts of this df as 1 element to listoflists_piecharts
    listoflists_piecharts[[counter_df]] <- list_piecharts
    names(listoflists_piecharts)[counter_df] <- name_df
    #OR
    #listoflists_piecharts <- c(listoflists_piecharts, assign(name_df, list_piecharts) )
    
    #make a grid of pie charts and save it to a pdf
    pdf(paste0("../Intro2DS_Capstone_Plots/Intro2DS_Capstone_PlotsWrangling/",
               names(listoflists_piecharts)[counter_df],"_piecharts.pdf") )
    print( gridExtra::marrangeGrob(list_piecharts, nrow = 2, ncol = 2) )
    dev.off()
  
    counter_df <- counter_df + 1
  }
  gc()
  
  # **************************************************************      
  # Analize categorical variables also through bar charts 
  # **************************************************************      
  
  
  print('plotting')
  print(paste0("../Intro2DS_Capstone_Plots/Intro2DS_Capstone_PlotsWrangling/",name_df,"_barcharts.pdf") )
  
  
  
  # make bar charts for all categorical variables in each data frame (add them to a list)
  barcharts_list <- lapply(X = indices_list, FUN = plot_barchart, datadf = df)
  
  #make a grid of pie charts and save it to a pdf
  
  
  
  pdf(paste0("../Intro2DS_Capstone_Plots/Intro2DS_Capstone_PlotsWrangling/",name_df,"_barcharts.pdf") )
  print( gridExtra::marrangeGrob(barcharts_list, nrow = 2, ncol = 2) )
  dev.off()
  
  print('plotted')
  print(paste0("../Intro2DS_Capstone_Plots/Intro2DS_Capstone_PlotsWrangling/",name_df,"_barcharts.pdf") )
  
  # add the list of piecharts of this df as 1 element to barcharts_listoflists
  # Uncomment if needed
  #barcharts_listoflists <- c(barcharts_listoflists, assign(name_df, barcharts_list) )
  
  gc()
  # # **************************************************************
  # # Analize categorical variables also through bar charts
  # #      (now comparing each variable with TARGET)
  # # **************************************************************
  # # make bar charts for all categorical variables in each data frame (add them to a list)
  # barcharts_target_list <- lapply(X = indices_list, FUN = plot_barchart_andtarget, datadf = df)
  # 
  # #make a grid of pie charts and save it to a pdf
  # print(paste0("../Intro2DS_Capstone_Plots/Intro2DS_Capstone_PlotsWrangling/",name_df,"_barcharts_withTarget.pdf") )
  # pdf(paste0("../Intro2DS_Capstone_Plots/Intro2DS_Capstone_PlotsWrangling/",name_df,"_barcharts_withTarget.pdf") )
  # print( gridExtra::marrangeGrob(barcharts_target_list, nrow = 2, ncol = 2) )
  # dev.off()
  # 
  # # add the list of piecharts of this df as 1 element to barcharts_listoflists
  # # Uncomment if needed
  # # barcharts_target_listoflists <- c(barcharts_target_listoflists, assign(name_df, barcharts_list) )

  
  
}  

# #OPTION 2: AS A FUNCTION
# gridplot_pdf <- function(list_plots, pdfname){
# 
#   pdf(pdfname)
#   print( gridExtra::marrangeGrob(list_plots , nrow = 2, ncol = 2) )
#   dev.off()
# 
# }
# 
# gridplot_pdf(list_plots = listoflists_piecharts[[2]],
#              pdfname = paste0("../Intro2DS_Capstone_Plots/Intro2DS_Capstone_PlotsWrangling/",
#                               names(listoflists_piecharts)[2],"_piecharts.pdf") )
# 
# # OPTION 3: INSIDE A FOR LOOP (OUTSIDE THE INITIAL FOR LOOP)
# for(iii in seq(1,2)) {
#   print(iii)
#   # make a grid of pie charts and save to pdf
#   pdf(paste0("../Intro2DS_Capstone_Plots/Intro2DS_Capstone_PlotsWrangling/",names(listoflists_piecharts)[iii],"_piecharts.pdf"))
#   gridExtra::marrangeGrob(listoflists_piecharts[[iii]][1:5], nrow = 2, ncol = 2)
#   dev.off()
# 
# }
#  
#  # DOING IT MANUALLY UNTIL I UNDERSTAND WHAT'S GOING ON
#  istep=1
#  pdf(paste0("../Intro2DS_Capstone_Plots/Intro2DS_Capstone_PlotsWrangling/",names(listoflists_piecharts)[istep],"_piecharts.pdf"))
#  gridExtra::marrangeGrob(listoflists_piecharts[[istep]][1:5], nrow = 2, ncol = 2)
#  dev.off()
# 
#  istep=2
#  pdf(paste0("../Intro2DS_Capstone_Plots/Intro2DS_Capstone_PlotsWrangling/",names(listoflists_piecharts)[istep],"_piecharts.pdf"))
#  gridExtra::marrangeGrob(listoflists_piecharts[[istep]][1:5], nrow = 2, ncol = 2)
#  dev.off()
 

 
  
  
  
  








