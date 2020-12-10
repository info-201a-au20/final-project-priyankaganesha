# Server file
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library("rsconnect")




server <- function(input, output){
  #loading data
  df_depress <- read.csv("/Users/stlp/Github/Informatics201/group-project/final-project-priyankaganesha/data/Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv")
  
  #Page One Plots
  # First plot: Normalized average cases by reported time period
  
  output$normalized_plot <- renderPlotly({
    # Here the data frame is filtered to just include 4 columns and remove na values.
    new_df <- df_depress %>%
    select("Time.Period.Label", "Value", "Subgroup", "Time.Period")
  df_3 <- na.omit(new_df <- aggregate(new_df$Value, by = list(Time.Period.Label=new_df$Time.Period.Label), FUN=mean))
  
  # Here the column for the z_scores of the mean percentage values for each time
  #period are created and ordered. 
  
  df_4 <- df_3 %>%
    mutate(z_score = round((x - mean(x))/ sd(x), 2)) %>%
    mutate(type = ifelse(z_score < 0, "below", "above"))
  df_4 <- df_4[order(df_4$z_score),]
  df_4$Time.Period.Label <- factor(df_4$Time.Period.Label, 
                                   levels = df_4$Time.Period.Label)
  # This is the code for the graph.
  normalized_plot <- ggplot(df_4, aes(x=Time.Period.Label, y=z_score, 
                   label = "z score of all time periods")) + 
    geom_bar(stat = 'identity', aes(fill=type), width=.5) +
    scale_fill_manual(name="Mean of reported cases in each time period", 
                      labels=c("Above Average", "Below Average"),
                      values = c("above"="#00ba38", "below"="#f8766d")) +
    labs(subtitle = "Normalized average reported cases by time period",
         title = "Reported Cases") +
    coord_flip() 
  normalized_plot <- ggplotly(normalized_plot)
  return(normalized_plot)
  
  })
  
  #Second Plot: Percent reported by time period and case type
  output$case_type_plot <- renderPlotly({
    df_sort1 <- filter(
      df_depress, Group == "National Estimate"
    ) %>%
      arrange(Indicator)
    
    #Here the plot is created comparing states and the percentages of anxiety or
    #depression for the two phases
    phase_plot <- ggplot(data = df_sort1) +
      geom_col(
        mapping = aes(x = Time.Period.Label, y = Value, 
                      fill = 	input$symptom_select),
        position = position_dodge(),
        width = .5, show.legend = FALSE
      ) + theme(legend.position = "none") +
      coord_flip() +
      labs(
        title = "Percent of People Depressed or Anxious per Time Period",
        y = "Percent of People Reporting Symptoms of Anxiety or Depression",
        x = "Time Period"
      ) +
      scale_fill_brewer(palette = "Paired") +
      theme_classic()
    
    #Here I make the plot interactive with ggplotly
    plot_interact <- ggplotly(phase_plot)
    
    return(plot_interact)
  })
  
  
  #Page Two Plots
  #First plot: National Percentages of Anxiety or Depression Symptoms Over Time
  output$national_plot <- renderPlotly({
    # sort the symptom
    df_nation <- filter(df_depress, Indicator == input$symp_select,
                        Group == "National Estimate",
                        ?..Phase != -1)
    
    # Symptom names and title
    symp_names <- c(
      "Anxiety" = "Symptoms of Anxiety Disorder",
      "Depression" = "Symptoms of Depressive Disorder",
      "Anxiety or Depression" = "Symptoms of Anxiety Disorder or Depressive Disorder"
    )
    symp_title <- paste0(
      "Indicators of ",
      names(symp_names[which(symp_names == input$symp_select)]),
      " in the US over time"
    )
    
    # return the plot
    national_plot <- ggplot(data = df_nation, aes(x = Time.Period.Label, 
                                             y = Value, group = 1)) +
      geom_line() +
      geom_point() +
      
      labs(title = symp_title,
           y = "Percent of People Reporting Symptoms",
           x = "Time Period"
      ) +
      theme_classic() +
      theme(axis.text.x = element_text(angle = -90, hjust = 0, vjust = 0))
    
    national_plot <- ggplotly(national_plot)
    return(national_plot)
  })
  # Second Plot: Trends of New Daily Covid Cases over time
  output$case_plot <- renderPlotly({
    #added data
    df_case <- filter(df_depress, Indicator == input$symp_select,
                        Group == "National Estimate",
                        ?..Phase != -1) %>%
      mutate(cases = c(37163, 31099, 26995, 20448, 21361, 20548, 21860, 27957, 
                     40632, 52823, 59273, 72315, 46796, 40178, 42163, 45515, 
                     60238))
    
    # return the plot
    case_plot <- ggplot(data = df_sort, aes(x = Time.Period.Label, y = cases, 
                                            group = 1)) +
      geom_point()+
      geom_line()+
      labs(title = "The Number of New COVID-19 Cases Over Time",
           y = "Number Of New Cases",
           x = "Time Period"
      ) +
      
      theme_classic() +
      theme(axis.text.x = element_text(angle = -90, hjust = 0, vjust = 0))
    case_plot <- ggplotly(case_plot)
    return(case_plot)
  })
  
  #Page Three Plots
  
}
