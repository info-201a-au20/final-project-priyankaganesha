# This is the second chart for our midpoint project
# Megan Taylor

chart_two <- function(df_choice) {
  library("dplyr")
  library("ggplot2")
  library("plotly")

#Here the function is filtered to just rows relating to states,
#symptoms of anxiety or depression, and certain phases of the study
  df_sort <- filter(
    df_choice, Group == "By State",
    Indicator == "Symptoms of Anxiety Disorder or Depressive Disorder",
    Time.Period == 13 | Time.Period == 1
    ) %>%
    mutate(Phase = ifelse(ï..Phase == 1, "Phase One",
      ifelse(ï..Phase == 2, "Phase Two", NA)
    )) %>%
    arrange(State)

#Here the plot is created comparing states and the percentages of anxiety or
#depression for the two phases
  phase_plot <- ggplot(data = df_sort) +
    geom_col(
      mapping = aes(x = State, y = Value, fill = Phase),
      position = position_dodge(),
      width = 1.2
    ) +
    coord_flip() +
    labs(
      title = "Percent of People Depressed or Anxious per State",
      y = "Percent of People Reporting Symptoms of Anxiety or Depression",
      x = "State"
    ) +
    scale_fill_brewer(palette = "Paired") +
    theme_classic()

#Here I make the plot interactive with ggplotly
  plot_interact <- ggplotly(phase_plot)

  return(plot_interact)
}
