# This is the third chart for our midpoint project
# Megan Taylor

chart_three <- function(df_choice) {
  library("dplyr")
  library("ggplot2")
  library("plotly")

  df_sort <- filter(df_choice,
                    Group == "National Estimate",
                    ï..Phase != -1)

  plot_three <- ggplot(data = df_sort,
                       aes(x = Time.Period.Label,
                           y = Value,
                           group = Indicator)) +
    geom_line(aes(color = Indicator)) +
    labs(
      title = "Percent of People in the US Symptomatic of Anxiety and/or Depression Over Time",
      y = "Percent of People Reporting Symptoms",
      x = "Date Period"
    ) +
    scale_color_manual(values = c("red", "purple", "blue")) +
    theme_classic() +
    theme(axis.text.x = element_text(angle = -90, hjust = 0, vjust = 0))

  return(plot_three)
}
