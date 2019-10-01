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


# *********** Separate features into data types **************
# define which columns are categorical and non categorical

# train
train_categorical_indices <- c(2:7, 12:16, 23:40, 41, 87, 88, 90:95, train_paperwork_indices, train_creditbureau_indices)
train_continuous_indices <- c(8:11, 17:22, 42, 43, 44, 45:86, 89, 96)

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
