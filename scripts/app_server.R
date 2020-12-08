# Server file
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)



server <- function(input, output){
  #loading data
  df_depress <- read.csv("C:/Users/Megan/Documents/Junior Year UW/info201/final-project-priyankaganesha/data/Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv", stringsAsFactors = FALSE)
  
  #Page One Plots
  
  
  #Page Two Plots
  #First plot: National Percentages of Anxiety or Depression Symptoms Over Time
  output$national_plot <- renderPlotly({
    # sort the symptom
    df_nation <- filter(df_depress, Indicator == input$symp_select,
                        Group == "National Estimate",
                        ï..Phase != -1)
    
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
                        ï..Phase != -1) %>%
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