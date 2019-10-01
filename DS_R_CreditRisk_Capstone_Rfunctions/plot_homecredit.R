################################################################
# This script contains functions to read the home credit data set
#
# Author: Paula Andrea Ortiz Otalvaro
# Created:  10-09-2019
# Modifications:   -09-2019
#
################################################################


# --------------------------------------------------------------
#         PIE CHART OF A FEATURE IN HOME CREDIT DATA SET
# This function plots a pie chart of a variable using ggplot.
# 
### Arguments:
#   data_df : data frame
#   column_name : name of column to use for plot
#
### Return: 
#   pie : ggplot object with pie chart
# --------------------------------------------------------------


plot_piechart <- function(data_df, column_name){
  
  colors2use <- colorRampPalette(brewer.pal(length(levels(factor(column_name)))+1, 'Set1'))      
  column2plot <- factor(data_df[[column_name]])
  levels2plot <- levels(column2plot)
      
  # pie chart
  barstacked <- ggplot( data_df, aes(x=1, fill=column2plot) ) + geom_bar()
      
  pie <- barstacked + coord_polar(theta = "y") + 
         #ggtitle(column_name) +
         scale_fill_manual( column_name,
                           values = colors2use(length(levels2plot)), 
                           labels = levels2plot ) +
         theme(legend.position="bottom")
      
  return(pie)
  
}
#myplots <- lapply(names(ids_twocatego), plot_piechart, data_df=df_categoriccols )


# -------------------------------------------------------------------------------------------------
#                PIE CHARTS OF MULTIPLE FEATURES FROM HOME CREDIT DATA SET
# This function plots pie charts of variables using ggplot and save them in a pdf file
# 
### Arguments:
#   mydf : data frame
#   column_names : list with names of columns to use for plot
#
### Return: 
#   (Nothing)
#
### Usage (example);
#   plot_grid_piecharts(mydf = twocatego_df, column_names = names(twocatego_df) , 
#                       pdfplot_name = "train")
# -------------------------------------------------------------------------------------------------


plot_grid_piecharts <- function(mydf, column_names, pdfplot_name, plot_rows = 2, plot_cols = 2, 
                                savepdf='Yes'){
  
  # make pie charts for varaibles with 2 categories in the current df
  list_piecharts <- lapply(X = column_names, FUN = plot_piechart, data_df = mydf )
  
  if(savepdf=='Yes'){
    #make a grid of pie charts and save it to a pdf
    pdf(paste0("../DS_R_CreditRisk_Capstone_Plots/DS_R_CreditRisk_Capstone_PlotsWrangling/",
               pdfplot_name,"_piecharts.pdf") )
    print( gridExtra::marrangeGrob(list_piecharts, nrow = plot_rows, ncol = plot_cols) )
    dev.off()
  }
  else{
    print( gridExtra::marrangeGrob(list_piecharts, nrow = plot_rows, ncol = plot_cols) )
  }
  
  gc()
  
}




# --------------------------------------------------------------
#         BAR CHART OF A FEATURE IN HOME CREDIT DATA SET
# This function plots a pie chart of a variable using ggplot.
# 
### Arguments:
#   datadf : data frame
#   column_index : index of column to use for plot
#
### Return: 
#   pie : ggplot object with pie chart
# --------------------------------------------------------------

plot_barchart <- function(datadf, column_name){

  # using tidyverse remove NAs in the data used for the plot
  datadf <- datadf %>% filter(!is.na(datadf[[column_name]]))
  column4plot <- factor(datadf[[column_name]])
  
  # bar chart
  bar <- ggplot( datadf, aes(x = column4plot) )  + 
                 ggtitle(column_name) + 
                 geom_bar(position = 'dodge') +
                 scale_x_discrete(names(column4plot)) +
                 scale_y_continuous("Number") 
  
  return(bar)
  
}


# -------------------------------------------------------------------------------------------------
#                PIE CHARTS OF MULTIPLE FEATURES FROM HOME CREDIT DATA SET
# This function plots pie charts of variables using ggplot and save them in a pdf file
# 
### Arguments:
#   mydf : data frame
#   column_names : list with names of columns to use for plot
#
### Return: 
#   (Nothing)
#
### Usage (example);
#   plot_grid_piecharts(mydf = twocatego_df, column_names = names(twocatego_df) , 
#                       pdfplot_name = "train")
# -------------------------------------------------------------------------------------------------
plot_grid_barcharts <- function(mydf, column_names, pdfplot_name, plot_rows = 2, plot_cols = 2, 
                                savepdf='Yes'){
  
  # make pie charts for varaibles with 2 categories in the current df
  list_barcharts <- lapply(X = column_names, FUN = plot_barchart, datadf = mydf )
  
  if(savepdf=='Yes'){
    #make a grid of pie charts and save it to a pdf
    pdf(paste0("../DS_R_CreditRisk_Capstone_Plots/DS_R_CreditRisk_Capstone_PlotsWrangling/",
               pdfplot_name,"_barcharts.pdf") )
    print( gridExtra::marrangeGrob(list_barcharts, nrow = plot_rows, ncol = plot_cols) )
    dev.off()
  }
  else{
    print( gridExtra::marrangeGrob(list_barcharts, nrow = plot_rows, ncol = plot_cols) )
  }
  
  gc()
  
}

















### este no debe funcionar hasta que se le cambie column_index por column_name:
plot_barchart_andtarget <- function(datadf, column_index){
  
  # using tidyverse to remove NAs in the columns used for the plot
  datadf <- datadf %>% filter(!is.na(datadf[[column_index]]), !is.na(datadf[['TARGET']]))
  
  column4plot <- factor(datadf[[column_index]])
  targetcolumn <- factor(datadf[['TARGET']])
  targetlevels <- levels(targetcolumn)
  colors2use <- colorRampPalette(brewer.pal(length(targetlevels)+1, 'Set1'))
  
  # bar chart
  barwithtarget <- ggplot( datadf, aes(x = column4plot, fill = targetcolumn) )  + 
                           ggtitle(names(datadf[column_index])) + 
                           geom_bar(position = 'dodge') +
                           scale_x_discrete(names(column4plot)) +
                           scale_y_continuous("Number") + 
                           scale_fill_manual('TARGET', values = colors2use(length(targetlevels)), labels = targetlevels ) +
                           theme(legend.position="bottom")
  
  return(barwithtarget)
  
}



# lev <- levels(factor(listofdfs[['train']][[2]]))
# colors2use <- colorRampPalette(brewer.pal(length(lev)+1, 'Set1'))
# 
# 
# ggplot(listofdfs[['train']], aes(x=factor(listofdfs[['train']][[4]]), fill = factor(listofdfs[['train']][[2]])  ) ) + 
#   geom_bar(position = 'dodge') +
#   scale_x_discrete(names(listofdfs[['train']][4])) +
#   scale_y_continuous("Number") +
#   scale_fill_manual(names(listofdfs[['train']][2]) , values = colors2use(length(lev)), labels = lev )
# 


