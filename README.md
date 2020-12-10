Link to Shiny App: https://megant33.shinyapps.io/final-project-priyankaganesha/


# Project Brainstorm Assignment

## Domain of Interest : Covid19
#### Why are you interested in this field/domain?
We are interested in this domain because covid19 has engulfed a large part of the world right now. We would like to gain insight into a few specific cases where covid has affected areas or things that we might not expect it to, and analyze how it has affected these areas. We feel like this would help us understand the true impact of the pandemic on a diverse group of individuals and perhaps what we can do to overcome these negative impacts.

#### What other examples of data driven projects have you found related to this domain?
The Quantifying Physical Distancing project is a part of the overall COVID-19 global data science project where specifically different shutdown policies are analyzed for how they affect human mobility. They looked at how mobility was affected in densely populated areas such as Tokyo, New York and Barcelona to see how this may highlight areas that have higher human contacts, and need more restriction to prevent transmission. (https://www.covid19analytics.org/project-details/social-distancing)

The Covid Tracking Project has put together a comprehensive Covid testing data set and analysis  for all US states and territories. They have many figures that help people visualize the change in covid cases over time. (https://github.com/tirthajyoti/Covid-19-analysis and https://covidtracking.com/data)

The impact of the COVID-19 pandemic on food price indexes and data collection was analyzed in this project to see how it impacted imports and exports for the US and how it affected grocery pricing for US consumers. (https://www.bls.gov/opub/mlr/2020/article/the-impact-of-the-covid-19-pandemic-on-food-price-indexes-and-data-collection.htm)

#### What data-driven questions do you hope to answer about this domain?
_Where in the world did the highest number of people on average turn to twitter to convey their thoughts on the pandemic?_
This question can be answered by looking covid19 related tweets and the countries they were posted from. This would tell us which countries tweeted about the pandemic more.

_How has the number of covid19 related tweets changed over time since the pandemic first began? In different phases of the pandemic?_
Looking at the number of covid19 related tweets in different months since the pandemic could help answer this question. We could also connect this to the phase in the pandemic that corresponds to these months.

_What are some factors that increase the likelihood of having severe symptoms from COVID-19?_
Observe data points where people have experienced more severe symptoms of COVID-19 and the factors associated with each of those individuals. Then, make connections.

_Are there higher instances of mental health conditions during the coronavirus pandemic?_
Can be answered by looking at data related to indicators of mental health conditions (such as documented cases) during and before the pandemic and drawing conclusions.

_Is there any correlation between pre-existing health conditions and the spread of the virus?_
By looking at data that correlates the covid severity/mortality rate for those with pre-existing conditions we can observe if their condition more negatively affects the covid-19 outcomes for those people. 

## Data Sources
###  Obesity among adults by country, 1975-2016
#### Where did you download the data (e.g., a web URL)?
The Data set was downloaded from Kaggle, 
https://www.kaggle.com/amanarora/obesity-among-adults-by-country-19752016?select=obesity-cleaned.csv
####  How was the data collected or generated?
The Data was obtained from the World Health Organization. The WHO runs an observatory that collects data through the 194 member states. The WHO uses official national estimates of the member states, however, if the data is thought to be corrupted by reporting it will carry out estimates of the population based on “methodologies for specific indicators that aim for comparability across countries and time”. As far as national estimates of the member states, the data is collected through use of Census and official polling. 
#### How many observations (rows) are in your data?
The Dataset has 24570 rows
#### How many features (columns) are in the data?
The Data set has 5 columns
#### What questions (from above) can be answered using the data in this dataset?
The main question that we aim to answer by looking at this dataset is how obesity has affected Covid-19 outbreaks in different parts of the world, and if it is a contributing factor (or any correlation) between obesity rates and Covid cases. 

### Indicators of Anxiety or Depression Based on Reported Frequency of Symptoms During Last 7 Days, April 2020 to October 2020 
#### Where did you download the data?
This dataset is from the Centers for Disease Control and Prevention,
https://data.cdc.gov/NCHS/Indicators-of-Anxiety-or-Depression-Based-on-Repor/8pt5-q6wp
####  How was the data collected or generated?
This data was collected from a national household pulse survey by the U.S. Census Bureau meant to produce data on the social and economic impacts of Covid-19 on households in the US. This portion of the survey is on the indicators of anxiety or depression changing over time, during the pandemic, on different ages, races, education levels and states. 
#### How many observations (rows) are in your data?
There are 3628 rows of data observations in this dataset
#### How many features (columns) are in the data?
There are 12 columns of data features in this dataset
#### What questions (from above) can be answered using the data in this dataset?
This dataset can answer questions regarding how mental health circumstances have changed during the pandemic. Specifically, Are there higher instances of mental health conditions during the coronavirus pandemic?

### COVID-19 Tweets
#### Where did you download the data?
https://www.kaggle.com/gpreda/covid19-tweets 
####  How was the data collected or generated? 
The data was collected using Twitter API and a Python script. A query for this high-frequency hashtag (#covid19) is run on a daily basis for a certain time period, to collect a larger number of tweets samples. Link for the collection script is : https://github.com/gabrielpreda/covid-19-tweets. This script was run by an individual to collect this data. 
This data is about the tweets that were tweeted pertaining to the covid19 pandemic. The tweets have #covid19 hashtag. The collection of data started on 25/7/2020 and ended about three months ago.
#### How many observations (rows) are in your data?
There are 178983 rows in this dataset.
#### How many features (columns) are in the data?
There are 13 columns in this dataset.
#### What questions (from above) can be answered using the data in this dataset?
Where in the world did the highest number of people on average turn to twitter to convey their thoughts on the pandemic?
How has the number of covid19 related tweets changed over time since the pandemic first began? In different phases of the pandemic?
