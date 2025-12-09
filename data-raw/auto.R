## code to prepare `auto.csv` dataset goes here
auto <- readr::read_csv("../../homework-submissions/final-project-submissions/final-project-we-are-normal/auto.csv")

usethis::use_data(auto, overwrite = TRUE)
