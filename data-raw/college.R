## code to prepare `college` dataset goes here
college <- readr::read_csv("../../homework-submissions/final-project-submissions/final-project-we-are-normal/college.csv")

usethis::use_data(college, overwrite = TRUE)
