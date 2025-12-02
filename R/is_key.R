is.key <- function(data, ..., optional_arguement = FALSE) {
  key_candidate <- data |> select(...)
  !any(duplicated(key_candidate))
}
