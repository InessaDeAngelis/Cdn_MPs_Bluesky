#### Preamble ####
# Purpose: Deduplicate and clean the labelled data and create analysis dataset
# Author: Rohan Alexander
# Date: 25 January 2025
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites:
  # 01-download_data.R
  # 02-clean_data.R
  # Need to have added labels (done manually)

#### Workspace setup ####
library(tidyverse)
library(janitor)

data <- read_csv("outputs/data/cleaned_posts_narrow-labelled.csv")

#### Analysis dataset prep ####
# De-duplicate based on post_id
data <- 
  data |> 
  distinct(post_id, .keep_all = TRUE)

# Remove ID column
data <- 
  data |> 
  select(-ID)


### Save data ####
write_csv(data, "outputs/data/analysis_data.csv")
