#' Function to check whether a dataset is in first normal form
#'
#' @param data data frame
#' @param max_size maximum size of the key
#' @return logical value: `TRUE`, if the data is in first normal form, `FALSE` otherwise
#'
#' @details
#' If `FALSE` is returned, one of two messages will print:
#' - `"Data set is NOT in First Normal Form, non-atomic columns found"`
#' (when one or more columns include contain multiple values in the same row)
#' - `"Data set is NOT in First Normal Form, no candidate key exists"`
#' (when there are simply no keys for the data)
#'
#' @examples
#' first_normal(college)
#'
#' @export
first_normal <- function(data, max_size = 2) {

  is_atomic <- function(x) {
    all(!sapply(x, function(v) length(v) != 1 || is.list(v)))
  }

  atomic_cols <- sapply(data, is_atomic)

  if (!all(atomic_cols)) {
    return("FALSE: Dataset is NOT in First Normal Form, non-atomic columns found")
  }

  result <- find_keys(data, max_size = max_size)
  result

  if (is.character(result)) {
    return("FALSE: Dataset is NOT in First Normal Form, no candidate key exists")
  }

  return("TRUE")
}
