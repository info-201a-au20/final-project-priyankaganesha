# This is the summary information for our midpoint project
# Priyanka Ganesha
compute_summary <- function(df) {
  library("dplyr")

  results <- list()

  # Finds which state was most affected
  state_most_affected <- df %>%
    filter(Group == "By State") %>%
    select(State, Value) %>%
    group_by(State) %>%
    summarize(
      affected = mean(Value)
    ) %>%
    filter(affected == max(affected)) %>%
    pull(State)

  results$most_affected_state <- state_most_affected

  # Finds percentage of people with bachelors degree or higher affected
  bachelors_degree_affected <- df %>%
    filter(Group == "By Education") %>%
    select(Subgroup, Value) %>%
    filter(!is.na(Value)) %>%
    group_by(Subgroup) %>%
    summarise(
      affected_percent = mean(Value)
    ) %>%
    filter(Subgroup == "Bachelor's degree or higher") %>%
    pull(affected_percent)

  bachelors_degree_affected <- round(bachelors_degree_affected, digits = 2)

  results$bachelors_degree_affected <- bachelors_degree_affected

  # Finds if Female or Male subjects felt were affected more
  male_vs_female <- df %>%
    filter(Group == "By Gender") %>%
    select(Subgroup, Value) %>%
    filter(!is.na(Subgroup)) %>%
    filter(!is.na(Value)) %>%
    group_by(Subgroup) %>%
    summarize(
      affected = mean(Value)
    ) %>%
    filter(affected == max(affected)) %>%
    pull(Subgroup)

  results$male_v_female <- male_vs_female

  # Finds what percent of the affected surveyed people were female
  female_pecentage_of_whole <- df %>%
    filter(Group == "By Gender") %>%
    select(Subgroup, Value) %>%
    filter(!is.na(Subgroup)) %>%
    filter(!is.na(Value)) %>%
    group_by(Subgroup) %>%
    summarize(
      affected = mean(Value)
    ) %>%
    mutate(total = sum(affected)) %>%
    filter(Subgroup == "Female") %>%
    mutate(percent_of_whole = affected / total) %>%
    pull(percent_of_whole)

  female_pecentage_of_whole <- round(female_pecentage_of_whole, digits = 2)

  results$percent_of_whole_female <- female_pecentage_of_whole

  # Finds which age group was affected the most
  age_group_most_affected <- df %>%
    filter(Group == "By Age") %>%
    select(Subgroup, Value) %>%
    filter(!is.na(Value)) %>%
    group_by(Subgroup) %>%
    summarise(
      affected = mean(Value)
    ) %>%
    filter(affected == max(affected)) %>%
    pull(Subgroup)

  results$age_most_affected <- age_group_most_affected

  # Finds which age group was affected the least
  age_group_least_affected <- df %>%
    filter(Group == "By Age") %>%
    select(Subgroup, Value) %>%
    filter(!is.na(Value)) %>%
    group_by(Subgroup) %>%
    summarise(
      affected = mean(Value)
    ) %>%
    filter(affected == min(affected)) %>%
    pull(Subgroup)

  results$age_least_affected <- age_group_least_affected

  return(results)
}
