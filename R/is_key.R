#' Assess whether a proposed set of variables is a key
#'
#' @param data A data frame or tibble
#' @param cols A character vector of column names to be considered as a key
#'
#' @return Logical value: `TRUE` if the specified column combination is a key,
#'   `FALSE` otherwise
#'
#' @examples
#' data(college)
#' is_key(college, "city")
#'
#' @export
is_key <- function(data, cols) {
  !any(duplicated(data[, cols, drop = FALSE]))
}
