#### Work space setup ####
library(haven)
library(tidyverse)
setwd("~/Desktop/FD")
# Read in the raw data. 
raw_data <- read_dta("dataverse_files copy/CES.dta")
raw_data <- labelled::to_factor(raw_data)

#keep some variables

reduced_data <- 
  raw_data %>% 
  select(cps19_citizenship,
         cps19_gender,
         cps19_province,
         cps19_votechoice,
         cps19_yob
         )

reduced_data <- reduced_data %>%  mutate(age = 100 - as.numeric(reduced_data$cps19_yob))


reduced_data<-
  reduced_data %>%
  mutate(vote_liberal = 
           ifelse(cps19_votechoice=="Liberal Party", 1, 0)) %>% 
  filter(vote_liberal != 'NA')%>%
  mutate(vote_conservative = 
           ifelse(cps19_votechoice=="Conservative Party", 1, 0)) %>% 
  filter(vote_liberal != 'NA')%>%
  mutate(sex = 
           case_when(`cps19_gender` == 'A woman' ~ 'Female', 
                     `cps19_gender` == 'A man' ~ 'Male',
                     ))%>%
  filter(sex != 'NA')%>%
  mutate(province = cps19_province)

# Saving the survey data as a csv file in my working directory

write_csv(reduced_data, "survey_data.csv")  



