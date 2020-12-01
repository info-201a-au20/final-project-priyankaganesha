# This is the summary table for our midpoint project
# Priyanka Ganesha

make_summary_table <- function(df) {
  confidence_low <- df %>%
    select(Low.CI, Indicator)

  confidence_high <- df %>%
    select(High.CI, Indicator)

  aggregated <- df %>%
    filter(Group == "By State") %>%
    select(Low.CI, Value, Indicator, High.CI) %>%
    filter(!is.na(Value)) %>%
    group_by(Indicator) %>%
    summarise(
      average_percent_affected = mean(Value),
      lowest_CI = min(Low.CI),
      highest_CI = max(High.CI)
    )

  confidence <- df %>%
    filter(Group == "By State") %>%
    select(Confidence.Interval, Indicator)

  aggregated_table <- full_join(aggregated,
                                confidence_low,
                                confidence_high, by = "Indicator") %>%
    arrange(average_percent_affected) %>%
    group_by(Indicator) %>%
    summarise(
      average_percent_affected = mean(average_percent_affected),
      lowest_CI = min(lowest_CI),
      highest_CI = max(highest_CI)
    )

  return(aggregated_table)
}