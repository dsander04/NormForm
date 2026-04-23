#' Function to check whether a dataset is in third normal form
#'
#' @param data data frame
#' @param max_size maximum size of the key
#'
#' @return logical value: `TRUE`, if the data is in first normal form, `FALSE` otherwise
#'
#' @details
#' If `FALSE` is returned, one of two messages will print:
#' - `"Dataset is NOT in Third Normal Form because it is not in Second Normal Form"`
#' (when data is not in second normal form)
#' - `"Transitive dependency detected"`
#' (when one column depends on a non-key column)
#'
#' @examples
#' third_normal(auto, max_size=2)
#'
#' @export

third_normal <- function(data, max_size = 2) {

  result <- second_normal(data, max_size = max_size)
  key_results <- find_keys(data, max_size = max_size)
  all_cols <- colnames(data)

  if (grepl("FALSE", result)) {
    return("FALSE: Dataset is NOT in Third Normal Form because it is not in Second Normal Form")
  }

  for (i in seq_len(nrow(key_results))) {

    key_cols <- unlist(strsplit(key_results$columns[i], ", "))
    non_key_cols <- setdiff(all_cols, key_cols)

    if (length(non_key_cols) > 1) {

      for (col in non_key_cols) {

        other_cols <- setdiff(non_key_cols, col)

        for (k in 1:length(other_cols)) {

          subsets <- combn(other_cols, k, simplify = FALSE)

          for (subset in subsets) {

            temp <- data[, c(subset, col), drop = FALSE]

            if (!any(duplicated(temp[subset]))) {
              return(paste0(
                "FALSE: Dataset is NOT in Third Normal Form. ",
                "Transitive dependency detected: {",
                paste(subset, collapse = ", "),
                "} -> ", col
              ))
            }
          }
        }
      }
    }
  }

  return("TRUE")
}
