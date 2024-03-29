# Server file
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library("rsconnect")




server <- function(input, output){
  #loading data
  #df_depress1 <- read.csv("C:/Users/Megan/Documents/Junior Year UW/info201/final-project-priyankaganesha/data/Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv", stringsAsFactors = FALSE)
  df_depress <- read.csv("data/Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8-BOM")
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
    scale_fill_manual(name="Mean Cases", 
                      labels=c("Above Average", "Below Average"),
                      values = c("above"="#00ba38", "below"="#f8766d")) +
    ggtitle("Reported Cases by Week") +
    xlab("Time period in weeks") + ylab("Z score of average values") +
    coord_flip() 
  normalized_plot <- ggplotly(normalized_plot)
  return(normalized_plot)
  
  })
  
  #Second Plot: Percent reported by time period and case type
  output$case_type_plot <- renderPlotly({
    df_sort1 <- filter(
      df_depress, Group == "National Estimate",
      Phase != -1) %>%
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
      scale_fill_brewer(palette = "Paired") +
      theme_classic() + ggtitle("Percent of People Depressed or Anxious per Time Period") +
      ylab("Percent of case reported ") + xlab("Time Period")
    
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
                        Phase != -1) %>%
      rename(dates = Time.Period.Label) 
    
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
    national_plot <- ggplot(data = df_nation, aes(x = dates, 
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
                        Phase != -1) %>%
      rename(dates = Time.Period.Label) %>%
      mutate(cases = c(37163, 31099, 26995, 20448, 21361, 20548, 21860, 27957, 
                     40632, 52823, 59273, 72315, 46796, 40178, 42163, 45515, 
                     60238))
    
    # return the plot
    case_plot <- ggplot(data = df_case, aes(x = dates, y = cases, 
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
  #First plot: Race
  output$race_plot <- renderPlotly({

    # filter df
    df_race <- df_depress %>% filter(Subgroup == input$race_select,
                        Phase != -1) %>%
      rename(dates = Time.Period.Label) %>%
      group_by(dates) %>%
      summarise(
        Value = mean(Value)
      )
    
    # Race
    race_names <- c(
      "White" = "Non-Hispanic white, single race",
      "Black" = "Non-Hispanic black, single race",
      "Asian" = "Non-Hispanic Asian, single race",
      "Other/Mixed Races" = "Non-Hispanic, other races and multiple races",
      "Hispanic or Latino" = "Hispanic or Latino"
    )
    race_title <- paste0(
      "Percentage of people identifying as ",
      names(race_names[which(race_names == input$race_select)]),
      " reporting symptoms in the US over time"
    )
    
    # return the plot
    race_plot <- ggplot(data = df_race, aes(x = dates, 
                                                  y = Value, group = 1)) +
      geom_point() + stat_smooth()+
      
      labs(title = race_title,
           y = "Percentage Reporting Symptoms",
           x = "Time"
      ) +
      theme_classic() +
      theme(axis.text.x = element_text(angle = -90, hjust = 0, vjust = 0))
    
    race_plot <- ggplotly(race_plot)
    return(race_plot)
  })
  
  
  # Gender Plot
  output$gender_plot <- renderPlotly({
    # Filter DF
    df_gender <- df_depress %>% filter(Group == "By Gender",
                                       Phase != -1) %>%
      rename(dates = Time.Period.Label) %>%
      group_by(dates, Subgroup) %>%
      summarise(
        Value = mean(Value)
      )
    
    # return the plot
    gender_plot <- ggplot(data = df_gender, aes(x = dates, y = Value, 
                                            group = 1, color = Subgroup)) +
      geom_point()+
      geom_line()+
      labs(title = "Gender vs. Symptoms of Anxiety and/or Depression",
           y = "Percentage Reporting Symptoms",
           x = "Time"
           
      ) +
      
      theme_classic() +
      theme(axis.text.x = element_text(angle = -90, hjust = 0, vjust = 0))
    gender_plot <- ggplotly(gender_plot)
    return(gender_plot)
  })
  
}
