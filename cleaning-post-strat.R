#### Work space setup ####
library(haven)
library(tidyverse)
setwd("~/Desktop/FD")
# Read in the raw data. 
raw_data <- read_csv("gss.csv")


# Keep some variables that we are going to use to build model and predict. 
reduced_data <- 
  raw_data %>% 
  select(age,
         sex,
         province)

# We are going to splitting cells by age, sex, province
reduced_data$age <- as.integer(reduced_data$age)

reduced_data <- 
  reduced_data %>%
  count(age, sex, province) %>%
  group_by(age, sex,  province) 



# Saving the census data as a csv file in my working directory

write_csv(reduced_data, "census_data.csv")
