#' Determine which column(s) is(are)
#'
#' @param data data frame
#' @param max_size maximum size of the key
#' @export
#' @examples
#' find_keys(college)

find_keys <- function(data, max_size = 1) {
  cols <- colnames(data)
  n <- length(cols)
  results <- list()

  for (k in 1:min(max_size, n)) {
    combos <- combn(cols, k, simplify = FALSE)

    for (combo in combos) {
      if (is_key(data, combo)) {
        results <- append(results, list(
          tibble(key_size = k, columns = paste(combo, collapse = ", "))
        ))
      }
    }
  }

  if (nrow(bind_rows(results)) == 0) {
    return(paste0("No keys of size ", max_size, " found, pick larger max size"))
  } else {
    bind_rows(results)
  }
}
