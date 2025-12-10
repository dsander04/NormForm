## code to prepare `auto.csv` data set goes here
auto <- readr::read_csv("data-raw/auto.csv")

usethis::use_data(auto, overwrite = TRUE)
