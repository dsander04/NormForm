# data-raw/counties.R
counties <- readr::read_csv(here::here("data-files", "counties.csv"))

# Save to data/ as counties.rda
usethis::use_data(counties, overwrite = TRUE)
