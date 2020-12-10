# UI for project
library("shiny")
library("ggplot2")
library("plotly")

project_overview <- tabPanel(
  "Overview of our Project",

    p("Since the pandemic hit the world, it has drastically turned the lives 
    of humans all of the world upside down. One of many concerns that the 
    COVID-19 pandemic as highlighted is that of mental health. Being under 
    lockdown and limiting social interactions has led way for increased cases 
    of anxiety and depression in people.The data we are analyzing was collected 
    from a national household pulse survey
    by the U.S. Census Bureau meant to produce data on the social and
    economic impacts of Covid-19 on households in the US. This portion 
    of the survey is on the indicators of anxiety or depression changing 
    over time, during the pandemic, on different ages, races, education 
    levels and states. We chose this dataset because it is very relevant for 
    observing how many people are experiencing mental health issues during 
    the pandemic. The questions we want to answer are: QUESTION ONE, 
    Do Changes in Percentage of Mental Health Symptoms Correlate With 
    Amounts of COVID-19 Cases Over Time?, QUESTION THREE"),
  a("https://data.cdc.gov/NCHS/Indicators-of-Anxiety-or-Depression-Based-on-Repor/8pt5-q6wp"),
  img(src = "Nicole_Hwang_Coronavirus_DRS-01.png")
  
)
# Here is page two
page_one_widget <- sidebarPanel(
  radioButtons(
    inputId = "symptom_select",
    label = ("Symptom Selection:"),
    choices = c("Anxiety" = "Symptoms of Anxiety Disorder",
                "Depression" = "Symptoms of Depressive Disorder",
                "Anxiety or Depression" = "Symptoms of Anxiety Disorder or Depressive Disorder"
    ),
    selected = "Symptoms of Anxiety Disorder"
  )  
)

page_one_main <- mainPanel(
  
  plotlyOutput("case_type_plot"),
  
  p("This first plot above was to compare the different reported symptoms of 
  either, Anxiety Disorder, Depressive Disorder or both. Here you can choose
    which reported symptom to fill in for each time period. This gives us 
    an additonal insight as to what time periods had the highest reported 
    symptoms."),

  plotlyOutput("normalized_plot"),
  
  p("This plot takes each time period and averages the reported percentage 
    of people with symptoms of all and/or both disorders. Then it normalizes 
    each time period with a z-score to show which time periods had above average
    reported symptoms.")
)

page_one <- tabPanel(
  "Phases of the study by reported cases",
  
  titlePanel("Which phases of the study were above the 
    average reported percent of cases?"),
page_one_main,
page_one_widget
  )




#Here is Page Two
page_two_widget <- sidebarPanel(
  radioButtons(
    inputId = "symp_select",
    label = ("Symptom Selection:"),
    choices = c("Anxiety" = "Symptoms of Anxiety Disorder",
    "Depression" = "Symptoms of Depressive Disorder",
    "Anxiety or Depression" = "Symptoms of Anxiety Disorder or Depressive Disorder"
    ),
    selected = "Symptoms of Anxiety Disorder"
  )  
)

page_two_main <- mainPanel(

  plotlyOutput("national_plot"),
  p("This first plot above was created to answer how the percent of 
    people feeling depressed and/or anxious differs over time. 
    The time period of this chart goes from the beginning to the 
    end of the survey, from Apr 23 - May 5 to Oct 14 - Oct 26 of 2020. 
    There are three groups that can be selected in this chart: people 
    suffering from anxiety, people suffering from depression and 
    people suffering from either."),
  
  plotlyOutput("case_plot"),
  p("This second plot above was created to show the number of new cases on the
    first days of the Time Periods that the survey uses. 
    (Apr 23 to Oct 14 of 2020.)"),
)

page_two <- tabPanel(
  "Mental Health Changes Relating to COVID-19 Cases",
  
  titlePanel("Do Changes in Percentage of Mental Health Symptoms Correlate With Amounts of COVID-19 Cases Over Time?"),
  
  p("The two plots below show trends for how the percent of people experiencing
  mental health symptoms and COVID-19 cases changes over time. When looking at
  the two graphs together they resemble a very similar graph with peaks and 
  valleys at almost identical time points. The highest symptom percentages for 
  all groups was in the time period from July 16 - July 21 2020, and the highest 
  daily COVID-19 cases out of all the time periods was the same period. The 
  trends following a similar trajectory, suggesting that anxiety and
  depression could be triggered by the severity of daily cases reported in 
  the same time periods in the United States."),
  
  sidebarLayout(
    page_two_main,
    page_two_widget
  )
)


page_three_widget <- sidebarPanel(
  
)

page_three_main <- mainPanel(
  
)

page_three <- tabPanel(
  "Enter Question one here:",
  sidebarLayout(
    page_three_main,
    page_three_widget
  )
)


summary_page <- tabPanel(
  "Summary of our Project",

#First Takeaway

h4("First Takeaway: Dates of most reported mental health cases"),
p("According to the first graph on page one,  we can see that most cases occured
  evenly throughout all time periods with no one period standing out as a 
  significant outlier. This is mirrored in the second graph on page one 
  where we find both earlier time periods, May and April falling below the 
  average z score of percent reported, as well as July and June months falling
  above the average. Since the time period of the study went until October
  there is not one time period that stands as being above or below the mean.
  This could point towards people feeling anxious and/or depressed despite of 
  the time of year of the survey, but rather due to lockdowns/restrictions 
  that have occured throughout all the time-periods of the covid pandemic."),
#Second Takeaway
h4("Second Takeaway: Mental Health Relations With COVID-19 Cases"),
p(""),
#Third Takeaway
  
)

ui <- navbarPage(
  "Final Deliverable",
  project_overview,
  page_one,
  page_two,
  page_three,
  summary_page
)