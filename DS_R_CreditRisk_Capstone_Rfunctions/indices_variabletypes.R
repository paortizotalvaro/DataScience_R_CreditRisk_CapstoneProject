################################################################
# Definition of indices of data according to theme and type

# Author: Paula Andrea Ortiz Otalvaro
# Created:  23-09-2019
# Modifications:   ---09-2019
#                  ---09-2019
#                  ---09-2019
#
################################################################


# *********** Features separated according to theme ***********
#                   in train and test sets
id_index_curr <- 1
target_index <- 2
train_loaninfo_indices <- c(3, 9, 10, 11, 12, 33, 34 )
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
train_NOIDEAWHERE_indices <- c( 20, 42, 43, 44 )

# Same information but with column names instead of col indices
train_loaninfo_names <- c("NAME_CONTRACT_TYPE", "AMT_CREDIT", "AMT_ANNUITY", "AMT_GOODS_PRICE", "NAME_TYPE_SUITE", "WEEKDAY_APPR_PROCESS_START", "HOUR_APPR_PROCESS_START")

train_personalinfo_indices <- c("CODE_GENDER", "NAME_EDUCATION_TYPE", "DAYS_BIRTH", "DAYS_ID_PUBLISH")

# *********** Separate features into data types **************
# define which columns are categorical and non categorical

# train
train_categorical_indices <- c(2:7, 12:16, 23:40, 41, 87, 88, 90:95, train_paperwork_indices, train_creditbureau_indices)
train_continuous_indices <- c(8:11, 17:22, 42, 43, 44, 45:86, 89, 96)
train_continuous_names <- c("AMT_INCOME_TOTAL", "AMT_CREDIT", "AMT_ANNUITY"   , "AMT_GOODS_PRICE", 
                            "REGION_POPULATION_RELATIVE", "DAYS_BIRTH"   , "DAYS_EMPLOYED", 
                            "DAYS_REGISTRATION", "DAYS_ID_PUBLISH", "OWN_CAR_AGE", "EXT_SOURCE_1", 
                            "EXT_SOURCE_2", "EXT_SOURCE_3", "APARTMENTS_AVG", "BASEMENTAREA_AVG", 
                            "YEARS_BEGINEXPLUATATION_AVG", "YEARS_BUILD_AVG", "COMMONAREA_AVG", 
                            "ELEVATORS_AVG", "ENTRANCES_AVG", "FLOORSMAX_AVG", "FLOORSMIN_AVG", 
                            "LANDAREA_AVG", "LIVINGAPARTMENTS_AVG", "LIVINGAREA_AVG", 
                            "NONLIVINGAPARTMENTS_AVG", "NONLIVINGAREA_AVG", "APARTMENTS_MODE", 
                            "BASEMENTAREA_MODE", "YEARS_BEGINEXPLUATATION_MODE", "YEARS_BUILD_MODE", 
                            "COMMONAREA_MODE", "ELEVATORS_MODE", "ENTRANCES_MODE", "FLOORSMAX_MODE", 
                            "FLOORSMIN_MODE", "LANDAREA_MODE", "LIVINGAPARTMENTS_MODE", 
                            "LIVINGAREA_MODE", "NONLIVINGAPARTMENTS_MODE", "NONLIVINGAREA_MODE", 
                            "APARTMENTS_MEDI", "BASEMENTAREA_MEDI", "YEARS_BEGINEXPLUATATION_MEDI", 
                            "YEARS_BUILD_MEDI", "COMMONAREA_MEDI", "ELEVATORS_MEDI", "ENTRANCES_MEDI", 
                            "FLOORSMAX_MEDI", "FLOORSMIN_MEDI", "LANDAREA_MEDI" , 
                            "LIVINGAPARTMENTS_MEDI", "LIVINGAREA_MEDI", "NONLIVINGAPARTMENTS_MEDI", 
                            "NONLIVINGAREA_MEDI", "TOTALAREA_MODE", "DAYS_LAST_PHONE_CHANGE")

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
listoflists_categorical_indices <- list(train = train_categorical_indices,test = test_categorical_indices, 
                                        bureau = bureau_categorical_indices, bureaubalance = bureaubalance_categorical_indices, 
                                        previousapp = previousapp_categorical_indices, poscash = poscash_categorical_indices, 
                                        installments = installments_categorical_indices, creditcard = creditcard_categorical_indices )
#names(listoflists_categorical_indices) <- c("train", "test", "bureau", "bureaubalance", "previousapp", "poscash", "installments", 
#                                            "creditcard")



#  *********** Make a list with all the lists having the indices of continuous variables (in each df)  ***********
names_continuos <- c( )
########################FINISH





# --------------------------------------------------------------
#           INDICES IN DATA FRAMES WITH EXTRA COLUMN
#              ('TARGET' ADDED AS SECOND COLUMN)
# --------------------------------------------------------------


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
