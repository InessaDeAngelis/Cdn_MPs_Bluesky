#### Preamble ####
# Purpose: Clean December 2024 Bluesky posts from active Canadian MPs & account info dataset
# Author: Inessa De Angelis
# Date: 10 January 2025
# Contact: inessa.deangelis@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
  # 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(cld2)

mp_accounts <- read_csv("inputs/data/cdn_politicians_bluesky.csv")

raw_posts <- read_csv("inputs/data/all_mp_posts.csv")

#### Clean Bluesky account info dataset ####
## Drop MPs without accounts ##
mp_accounts_cleaned <- mp_accounts |>
  drop_na(username) 

mp_accounts_cleaned <- unite(mp_accounts_cleaned, name, c(first_name, last_name), sep = " ")

## Save dataset ##
write_csv(mp_accounts_cleaned, "outputs/data/cdn_politicians_bluesky_cleaned.csv")

#### Clean Bluesky posts dataset ####
## Clean full sample dataset ##
cleaned_posts <- raw_posts |>
  select(uri, author_handle, author_name, text, indexed_at) |>
  rename(post_id = uri, date_posted = indexed_at) |>
  mutate(date_posted = as.Date(as.POSIXct(date_posted)))

cleaned_posts$post_id <- sub(".*/", "", cleaned_posts$post_id)
  
# Detect languages #
language_results <- detect_language(cleaned_posts$text)

print(language_results)

# Put language categorizations into df #
df <- data.frame(language_results)

# Combine language categorizations with the rest of the data #
cleaned_posts_df <- cbind(cleaned_posts, df)

# Re-code language categorizations #
cleaned_posts_df <- cleaned_posts_df |>
  mutate("language_results" = case_when( 
    language_results == "iu" ~ "English", 
    language_results == "en" ~ "English",
    language_results == "fr" ~ "French")) |>
  rename(language = language_results)
    
## Save full sample dataset ##
write_csv(cleaned_posts_df, "outputs/data/cleaned_posts.csv")

## Narrow sample period (December 7-21, 2024) & add ID column ##
cleaned_posts2 <- cleaned_posts_df |>
  filter(between(date_posted, as.Date('2024-12-07'), as.Date('2024-12-21'))) |>
  mutate(ID = row_number(), .before = "post_id")
  
## Save narrower sample dataset ##
write_csv(cleaned_posts2, "outputs/data/cleaned_posts_narrow.csv")

#### Get sample of 58 ####
posts_full_sample <- cleaned_posts2 |>
  slice_sample(n = 58)

## Save dataset ##
write_csv(posts_full_sample, "outputs/data/posts_full_sample.csv")
