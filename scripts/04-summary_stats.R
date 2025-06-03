#### Preamble ####
# Purpose: Calculates summary statistics & creates figures shown in the research note
# Author: Inessa De Angelis
# Date: 25 January 2025
# Contact: inessa.deangelis@mail.utoronto.ca 
# License: MIT
# Pre-requisites:
  # 01-download_data.R
  # 02-clean_data.R
  # 03-clean_labelled_data.R

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(kableExtra)
library(ggplot2)

accounts <- read_csv("outputs/data/cdn_politicians_bluesky_cleaned.csv")

analysis_data <- read_csv("outputs/data/analysis_data.csv")

both <- 
  analysis_data |> 
  left_join(accounts, by = join_by(author_handle==username))
  
#### Calculate the number of posts on Bluesky, by language ####
analysis_data |>
  count(language, sort = TRUE) |>
  mutate(pct_posts = round(n / sum(n) * 100, 1)) |>
  kable(
    col.names = c("Language", "Number", "Percentage"),
    booktabs = TRUE
  )

#### Calculate the number of MPs on Bluesky, by political affiliation ####
accounts |>
  count(political_affiliation, sort = TRUE) |>
  mutate(proportion = round(n / sum(n) * 100, 1)) |>
  kable(
    col.names = c("Political Affiliation", "Number", "Percentage"),
    booktabs = TRUE
  )

#### Calculate the number of MPs on Bluesky, by gender ####
accounts |>
  count(gender, sort = TRUE) |>
  mutate(proportion = round(n / sum(n) * 100, 1)) |>
  kable(
    col.names = c("Gender", "Number", "Percentage"),
    booktabs = TRUE
  )

#### Calculate the number of posts on Bluesky, by gender and classification ####
both |>
  count(gender, classification, sort = TRUE) |>
  mutate(pct_posts = round(n / sum(n) * 100, 1)) |>
  kable(
    col.names = c("Gender", "Classification", "Number", "Percentage"),
    booktabs = TRUE
  )

#### Graph the number of posts on Bluesky, by MP ####
analysis_data |>
  count(author_handle, sort = TRUE) |>
  ggplot(aes(x = n)) +
  geom_histogram(binwidth = 1) +
  theme_classic() +
  labs(x = "Number of posts", y = "Number of MPs")

#### Calculate the number of posts on Bluesky, by political affiliation ####
both |>
  count(political_affiliation, sort = TRUE) |>
  mutate(pct_posts = round(n / sum(n) * 100, 1)) |>
  kable(
    col.names = c("Political Affiliation", "Number", "Percentage"),
    booktabs = TRUE
  )

#### Calculate the number of posts on Bluesky, by the province of the riding the MPs represents ####
both |>
  count(province_territory, sort = TRUE) |>
  mutate(pct_posts = round(n / sum(n) * 100, 1)) |>
  kable(
    col.names = c("Province/Territory", "Number", "Percentage"),
    booktabs = TRUE
  )

#### Calculate the number of posts on Bluesky, by classification ####
analysis_data |>
  count(classification, sort = TRUE) |>
  mutate(pct_posts = round(n / sum(n) * 100, 1)) |>
  kable(
    col.names = c("Classification", "Number", "Percentage"),
    booktabs = TRUE
  )

#### Calculate the number of posts on Bluesky, by party and classification ####
both |>
  count(political_affiliation, classification, sort = TRUE) |>
  mutate(pct_posts = round(n / sum(n) * 100, 1)) |>
  kable(
    col.names = c("Party", "Classification", "Number", "Percentage"),
    booktabs = TRUE
  )
