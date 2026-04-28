#' function to check whether a dataset is in second normal form
#'
#' @param data data frame
#' @param max_size maximum
#'
#' @return `TRUE` if the data is in second normal form, `FALSE` otherwise
#'
#' @details
#' If `FALSE` is returned, one of two messages will print:
#' - `"Dataset is NOT in First Normal Form, no candidate key exists"`
#' (when no column(s) are keys)
#' - `"Dataset is NOT in First Normal Form, non-atomic columns found"`
#' (when one or more columns include contain multiple values in the same row)
#'
#' @examples
#' second_normal(auto, max_size = 2)
#'
#' @export
second_normal <- function(data, max_size = 2) {

  result <- first_normal(data, max_size = max_size)
  key_results <- find_minimal_keys(data, max_size = max_size)

  if (grepl("FALSE", result)) {
    return("FALSE: Dataset is NOT in Second Normal Form because it is not in First Normal Form")
  }

  for (i in seq_len(nrow(key_results))) {

    key_cols <- unlist(strsplit(key_results$columns[i], ", "))

    if (length(key_cols) > 1) {

      subsets <- unlist(
        lapply(1:(length(key_cols) - 1),
               function(k) combn(key_cols, k, simplify = FALSE)
        ),
        recursive = FALSE
      )

      for (subset in subsets) {

        if (!any(duplicated(data[subset]))) {
          return(paste0(
            "FALSE: Dataset is NOT in Second Normal Form. ",
            "Partial dependency detected: subset {",
            paste(subset, collapse = ", "),
            "} uniquely identifies rows."
          ))
        }
      }
    }
  }

  return("TRUE")
}
