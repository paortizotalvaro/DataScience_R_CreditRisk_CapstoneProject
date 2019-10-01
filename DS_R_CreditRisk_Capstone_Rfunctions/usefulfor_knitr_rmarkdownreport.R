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