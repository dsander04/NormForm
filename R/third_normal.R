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

  key_cache <- new.env(parent = emptyenv())

  result_2nf <- second_normal(data, max_size = max_size)
  if (grepl("FALSE", result_2nf)) {
    return("FALSE: Dataset is NOT in Third Normal Form because it is not in Second Normal Form")
  }

  key_results <- find_keys(data, max_size = max_size)

  if (is.null(key_results) || nrow(key_results) == 0) {
    return("FALSE: No candidate keys found")
  }

  all_cols <- colnames(data)

  keys_list <- strsplit(key_results$columns, ", ")
  prime_attrs <- unique(unlist(keys_list))
  non_key_attrs <- setdiff(all_cols, prime_attrs)

  if (length(non_key_attrs) <= 1) return("TRUE")

  all_subsets <- list()
  for (k in 1:min(2, length(non_key_attrs))) {
    all_subsets <- c(all_subsets, combn(non_key_attrs, k, simplify = FALSE))
  }

  for (target in non_key_attrs) {
    for (subset in all_subsets) {

      if (target %in% subset) next

      if (is_key_cached(data, subset, key_cache)) next

      if (no_duplicates_cached(data, subset, key_cache)) {
        return(paste0(
          "FALSE: Dataset is NOT in Third Normal Form. ",
          "Possible transitive dependency: {",
          paste(subset, collapse = ", "),
          "} -> ", target,
          ". (May be data-specific coincidence)"
        ))
      }
    }
  }

  return("TRUE")
}
