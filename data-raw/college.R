## code to prepare `college` dataset goes here
college <- readr::read_csv("data-raw/college.csv")

usethis::use_data(college, overwrite = TRUE)
