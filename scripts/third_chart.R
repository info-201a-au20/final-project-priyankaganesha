# This is the third chart for our midpoint project
# Megan Taylor

chart_three <- function(df_choice) {
  library("dplyr")
  library("ggplot2")
  library("plotly")

#Here the function is filtered to just rows relating to only the US as a whole,
#and removing rows with nonsense
  df_sort <- filter(df_choice,
                    Group == "National Estimate",
                    ï..Phase != -1)

#Here the plot is being created to compare the percent of people suffering
#from anxiety or depression over time for the US as a whole.
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
