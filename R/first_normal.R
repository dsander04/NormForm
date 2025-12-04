#' Function to check whether a dataset is in first normal form
#'
#' @param data data frame
#' @param max_size size of the key
#' @export
#' @examples
#' first_normal(college)
first_normal <- function(data, max_size = 2) {

  is_atomic <- function(x) {
    all(!sapply(x, function(v) length(v) != 1 || is.list(v)))
  }

  atomic_cols <- sapply(data, is_atomic)

  if (!all(atomic_cols)) {
    return("FALSE: Dataset is NOT in First Normal Form, non-atomic columns found")
  }

  keys <- tryCatch(
    {
      result <- find.keys(data, max_size = max_size)
      if (nrow(result) == 0) stop("No keys found")
      result
    },
    error = function(e) {
      return(NULL)
    },
    warning = function(w) {
      return(NULL)
    }
  )

  if (is.null(keys)) {
    return("FALSE: Dataset is NOT in First Normal Form, no candidate key exists")
  }

  return(list(
    message = "TRUE: Dataset is in First Normal Form", #is this message necessary?
    candidate_keys = keys
  ))
}
