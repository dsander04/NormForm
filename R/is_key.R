#' Assess whether a proposed (set of) variable(s) is a key
#'
#' @param data data frame or tibble
#' @param ... variables to be considered as a key
#' @param optional_argument binary, defaluts to `FALSE`
#' @return logical value: `TRUE`, if the specified variable (combination) is a key,
#' `FALSE` otherwise

#' @importFrom dplyr select

#' @examples
#' data(college)
#' is_key(college, city)
#'
#' @export
is_key <- function(data, ..., optional_argument = FALSE) {
  key_candidate <- data |> select(...)
  !any(duplicated(key_candidate))
}
