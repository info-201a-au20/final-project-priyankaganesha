# UI for project
library(shiny)
library(ggplot2)
library(plotly)

project_overview <- tabPanel(
  "Overview of our Project",
  mainPanel(
    "Enter overview here"
  )
)

page_one_widget <- sidebarPanel(
  
)

page_one_main <- mainPanel(
  
)

page_one <- tabPanel(
  "Enter Question one here:",
  sidebarLayout(
    page_one_main,
    page_one_widget
  )
)

page_two_widget <- sidebarPanel(
  
)

page_two_main <- mainPanel(
  
)

page_two <- tabPanel(
  "Enter Question one here:",
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
  mainPanel(
    "Enter summary here"
  )
)

ui <- navbarPage(
  "Final Deliverable",
  project_overview,
  page_one,
  page_two,
  page_three,
  summary_page
)