#' Assess whether a proposed (set of) variable(s) is a key
#'
#' @param data data frame or tibble
#' @param ... variables to be considered as a key
#' @param optional_argument binary, defaluts to `FALSE`
#' @returns logical value: `TRUE`, if the specified variable (combination) is a key,
#' `FALSE` otherwise
#' @examples
#' @examples
#' data(college)
#' is_key(college, name)
is_key <- function(data, ..., optional_arguement = FALSE) {
  key_candidate <- data |> select(...)
  !any(duplicated(key_candidate))
}
