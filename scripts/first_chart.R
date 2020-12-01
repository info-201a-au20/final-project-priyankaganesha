# This is the first chart for our midpoint project
# Jonathan Barrow


chart_one <- function(df_choice){
  library("dplyr")
  library("ggplot2")
  library("plotly")
  
  df_sort <- df_project %>%
    group_by(Indicator) %>%
    filter(State == "Washington")
  
  phase_plot <- ggplot(data = df_sort) +
    geom_point(mapping = aes(x = Value, y = Time.Period)
    )
  
  return(phase_plot)
}









