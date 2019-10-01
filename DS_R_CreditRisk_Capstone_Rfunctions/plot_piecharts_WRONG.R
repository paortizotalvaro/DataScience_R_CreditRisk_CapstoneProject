plot_multiple_piecharts <- function(data_df, list_indices){
  
  list_piecharts <- list()
  counter <- 1
  
  
  for(i in list_indices[1:5]){
      
      # pie chart
      barstacked <- ggplot( data_df, aes(x=1, fill=factor(data_df[[i]])) ) + geom_bar()
      pie <- barstacked + coord_polar(theta = "y") + ggtitle(names(data_df[i])) 
      
      print(counter)
      print(head(factor(data_df[[i]])))
      #print(names(data_df[i]))
      
      
      list_piecharts[counter] <- pie
      names(list_piecharts)[counter] <- names(data_df[i])
      
      #print(list_piecharts[[counter]] )
      #print('hola')
      
      counter <- counter + 1
  }
  
  
  print(list_piecharts[1] )
  print(list_piecharts[2] )
  print(list_piecharts[3] )
  
  return(list_piecharts)
  
}

#This function will always give a list with the same plot in all its elements. 
#See: https://stackoverflow.com/questions/31993704/storing-ggplot-objects-in-a-list-from-within-loop-in-r

#piecharts_train <- plot_multiple_piecharts( listofdfs[['train']], train_categorical_indices )