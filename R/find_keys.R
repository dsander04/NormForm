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
#' @importFrom utils combn
#' @importFrom tibble tibble
#' @importFrom dplyr bind_rows
#' @importfrom tidyselect all_of
#'
#' @export

find_keys <- function(data, max_size = 2) {
  cols <- colnames(data)
  n <- length(cols)
  all_keys <- list()

  for (k in 1:min(max_size, n)) {
    combos <- combn(cols, k, simplify = FALSE)

    for (combo in combos) {
      if (is_key(data, all_of(combo))) {
        all_keys <- append(all_keys, list(combo))
      }
    }
  }

  minimal_keys <- list()

  for (key in all_keys) {
    is_minimal <- TRUE

    for (other in all_keys) {
      if (length(other) < length(key) &&
          all(other %in% key)) {
        is_minimal <- FALSE
        break
      }
    }

    if (is_minimal) {
      minimal_keys <- append(minimal_keys, list(key))
    }
  }

  if (length(minimal_keys) == 0) {
    return(NULL)
  }

  tibble(key_size = sapply(minimal_keys, length),
         columns = sapply(minimal_keys, paste, collapse = ", ")
  )
}
