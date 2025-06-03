#### Preamble ####
# Purpose: Download December 2024 Bluesky posts from active Canadian MPs
# Author: Inessa De Angelis
# Date: 10 January 2025
# Contact: inessa.deangelis@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(atrrr)

#### Download and save skeets ####
## Create a function to download and save skeets ##
download_posts <- function(mp_username, file_name) {
  get_skeets_authored_by(actor = mp_username, parse = TRUE, limit = Inf) |>
    filter(grepl('2024-12', indexed_at)) |> # only save skeets from December 1-31, 2024
    filter(author_handle == mp_username) |> # only include original posts
    filter(!grepl('at://did', in_reply_to)) |> # get rid of replies
    filter(!grepl('at://did', quotes)) |> # get rid of quote skeets
    write_csv(file_name, append = TRUE, col_names = FALSE)}

## Create list of MP usernames ##
mp_usernames <- c(
  "anitaanandmp.bsky.social",
  "charlieangus104.bsky.social",
 "aryacanada.bsky.social",
  "taylorbachrach.bsky.social",
  "lisamariebarron.bsky.social",
  "terrybeech.bsky.social",
 "rachelbendayan.bsky.social",
  "lucberthold.bsky.social",
  "sylvieberube.bsky.social",
  "chrisbittle.bsky.social",
  "yfblanchet.bsky.social",
  "mbjdepute.bsky.social",
  "rboissonnault.bsky.social",
  "alexboulerice.bsky.social",
  "valbradfordmp.bsky.social",
  "alexisduceppe.bsky.social",
  "dickcannings.bsky.social",
  "martchampoux.bsky.social",
  "sophiechatel.bsky.social",
  "shaunchenmp.bsky.social",
  "laurelcollins.bsky.social",
  "coteau.bsky.social",
  "juliedabrusin.bsky.social",
  "pamdamoff.bsky.social",
  "leiladance.bsky.social",
  "donvdavies.bsky.social",
  "carolinebq.bsky.social",
  "blakedesjarlais.bsky.social",
  "jyduclos.bsky.social",
  "beynate.bsky.social",
  "darrenfisherns.bsky.social",
  "annamgainey.bsky.social",
  "leahgazan.bsky.social",
  "markgerretsen.bsky.social",
  "karinagould.bsky.social",
  "matthewgreen.bsky.social",
  "stevenguilbeault.bsky.social",
  "pattyhajdu.bsky.social",
  "drbrendanhanley.bsky.social",
  "kenhardie.bsky.social",
  "lisahepfner.bsky.social",
  "markhollandlib.bsky.social",
  "aiaconomp.bsky.social",
  "loriidlout.bsky.social",
  "gordjohns.bsky.social",
  "melaniejolycan.bsky.social",
  "mpjulian.bsky.social",
  "kayabagaarielle.bsky.social",
  "iqrakhalidmp.bsky.social",
  "kamalkheralib.bsky.social",
  "jennykwan.bsky.social",
  "mflalonde.bsky.social",
  "vivianelapointe.bsky.social",
  "andreannelarouche.bsky.social",
  "seblemire.bsky.social",
  "waynelongsj.bsky.social",
  "lloydlongfield.bsky.social",
  "timlouiskitcon.bsky.social",
  "alistairmacgregor.bsky.social",
  "maloneyj.bsky.social",
  "brianmassemp.bsky.social",
  "lindsaymathyssen.bsky.social",
  "elizabethemay.bsky.social",
  "gregmcleanyyc.bsky.social",
  "heathermcpherson.bsky.social",
  "alexandramendes.bsky.social",
  "kristinamichaud.bsky.social",
  "marcmillermp.bsky.social",
  "taleeb.bsky.social",
  "roboliphant.bsky.social",
  "pierrepaul-hus.bsky.social",
  "alainrayes.bsky.social",
  "michellegarner.bsky.social",
  "pablo-rodriguez.bsky.social",
  "manindersidhu.bsky.social",
  "jagmeetsingh.ca",
  "pascalestonge.bsky.social",
  "turnbullwhitby.bsky.social",
  "rechievaldez.bsky.social",
  "avankoeverden.bsky.social",
  "anitavandenbeld.bsky.social",
  "renevillemure.bsky.social",
  "patrickbweiler.bsky.social",
  "jeanyip3.bsky.social",
  "mp-bonitazarrillo.bsky.social")

## Loop through each MP's username and save their posts in CSV ##
for (mp_username in mp_usernames) {
  download_posts(mp_username, "inputs/data/all_mp_posts.csv")}
