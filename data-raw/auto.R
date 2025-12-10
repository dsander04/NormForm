# data-raw/auto.R
auto <- readr::read_csv(here::here("data-files", "auto.csv"))

# Save to data/ as auto.rda
usethis::use_data(auto, overwrite = TRUE)

