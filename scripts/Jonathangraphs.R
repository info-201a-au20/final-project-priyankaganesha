df_chart1 <- read.csv("/Users/stlp/Github/Informatics201/group-project/final-project-priyankaganesha/data/Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv")

chart_one <- function(df_choice){
  library("dplyr")
  library("ggplot2")
  library("plotly")
  
  # Here the data frame is filtered to just include 4 columns and remove na values.
  new_df <- df_chart1 %>%
    select("Time.Period.Label", "Value", "Subgroup", "Time.Period")
  
  df_3 <- na.omit(df_2 <- aggregate(new_df$Value, by = list(Time.Period.Label=new_df$Time.Period.Label), FUN=mean))
  
  # Here the column for the z_scores of the mean percentage values for each time
  #period are created and ordered. 
  
  df_4 <- df_3 %>%
    mutate(z_score = round((x - mean(x))/ sd(x), 2)) %>%
    mutate(type = ifelse(z_score < 0, "below", "above"))
  
  
  df_4 <- df_4[order(df_4$z_score),]
  
  df_4$Time.Period.Label <- factor(df_4$Time.Period.Label, 
                                   levels = df_4$Time.Period.Label)
  # This is the code for the graph.
  
  ggplot(df_4, aes(x=Time.Period.Label, y=z_score, 
                   label = "z score of all time periods")) + 
    geom_bar(stat = 'identity', aes(fill=type), width=.5) +
    scale_fill_manual(name="Mean of reported cases in each time period", 
                      labels=c("Above Average", "Below Average"),
                      values = c("above"="#00ba38", "below"="#f8766d")) +
    labs(subtitle = "Normalized average reported cases by time period",
         title = "Reported Cases") +
    coord_flip()
  
}