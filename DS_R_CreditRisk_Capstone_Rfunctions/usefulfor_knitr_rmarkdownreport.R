# function to structure info of categorical columns in useful form to export in knitr::kable

get_table_categorical <- function(df, categorical_indices){
  
  cbind( as.data.frame(categorical_indices),
         as.data.frame(sapply(X=df[ , categorical_indices], FUN=function(x){length(unique(x))} )),
         as.data.frame(sapply(X=df[ , categorical_indices], FUN=function(x){paste(unique(x), collapse=", ")}) )
  )
  
}



# function to structure info of categorical columns in useful form to export in knitr::kable

get_table_statistic <- function(df, cont_indices){
  
  totalvalues <- as.data.frame(sapply(X = df[ ,cont_indices] , 
                                      FUN = function(x){sum(!is.na(x))}) ) %>% `colnames<-` ("Count")
  
  minvalue <- as.data.frame(sapply(X = df[ ,cont_indices], 
                                   FUN = function(x){round(min(x, na.rm = TRUE),digits = 2)} )) %>% `colnames<-` ("Min")
  
  maxvalue <- as.data.frame(sapply(X = df[ ,cont_indices], 
                                   FUN = function(x){round(max(x, na.rm = TRUE),digits = 2)} )) %>% `colnames<-` ("Max")
  
  std <- as.data.frame(sapply(X = df[ ,cont_indices], 
                              FUN = function(x){round(sd(x, na.rm = TRUE),digits = 2)}) ) %>% `colnames<-` ('St Dev')
  
  ave <- as.data.frame(sapply(X = df[ ,cont_indices], 
                              FUN = function(x){round(mean(x, na.rm = TRUE),digits = 2)}) ) %>% `colnames<-` ('Mean')
  
  mod <- as.data.frame(sapply(X = df[ ,cont_indices], 
                              FUN = function(x){names(sort(-table(x)))[1]}) ) %>% `colnames<-` ('Mode')
  
  statistics_df <- cbind(totalvalues, minvalue, maxvalue, std, ave, mod)
  
}



# function to get missing values per column in a data frame df
get_missingvalues <- function(df){
    ######
    # This function gives a dataframe with the number of missing values in each column
    missing_percol <- sapply(X = df, FUN = function(x){sum(is.na(x))})
    
    # extract columns with more than 1 missing value and get percentage of missing values
                          # extract columns with more than 1 missing value
    missingvalues_info <- as.data.frame( missing_percol[missing_percol != 0] ) %>% 
      
                          # set column name
                          `colnames<-` ("MissingValues") %>%
                          
                          # make sure the row names are preserved
                          tibble::rownames_to_column('feature') %>%
      
                          # calculate percentaje of missing values (out of the column)
                          mutate(percentage = round(100*MissingValues/ nrow(df), 
                                                    digits = 2) ) %>%
                          arrange(desc(percentage)) %>%
       
                          tibble::column_to_rownames('feature')
    return(missingvalues_info)
}
