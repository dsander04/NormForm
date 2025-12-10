# data-raw/college.R
college <- readr::read_csv(here::here("data-files", "college.csv"))

# Save to data/ as college.rda
usethis::use_data(college, overwrite = TRUE)

