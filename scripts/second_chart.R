# This is the second chart for our midpoint project
# Megan Taylor

chart_two <- function(df_choice) {
  library("dplyr")
  library("ggplot2")
  library("plotly")

  df_sort <- filter(
    df_choice, Group == "By State",
    Indicator == "Symptoms of Anxiety Disorder or Depressive Disorder",
    Time.Period == 13 | Time.Period == 1
    ) %>%
    mutate(Phase = ifelse(ï..Phase == 1, "Phase One",
      ifelse(ï..Phase == 2, "Phase Two", NA)
    )) %>%
    arrange(State)


  phase_plot <- ggplot(data = df_sort) +
    geom_col(
      mapping = aes(x = State, y = Value, fill = Phase),
      position = position_dodge(),
      width = 1.2
    ) +
    coord_flip() +
    labs(
      title = "Comparing the Percent of People Depressed or Anxious per State at the Beginning of Phase One and Two",
      y = "Percent of People Reporting Symptoms of Anxiety or Depression",
      x = "State"
    ) +
    scale_fill_brewer(palette = "Paired") +
    theme_classic()


  plot_interact <- ggplotly(phase_plot)

  return(plot_interact)
}
