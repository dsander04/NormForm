#' Determine which column(s) is(are) a key for the data
#'
#' @param data data frame
#' @param max_size maximum size of the key
#' @return A tibble with key size and which columns if keys exist, `FALSE` otherwise
#'
#' @details
#' If `FALSE` is returned, this message will print:
#' - `"No keys of size ", max_size, " found, pick larger max size"`
#'
#' @examples
#' find_keys(college)
#'
#' @export

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
