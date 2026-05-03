#' To speed up how is_key is applied in the first, second, and third_normal
#' function
#'
#' @param data data frame
#' @param cols list
#' @return True or False depending on whether the column is a key of the data
#' or not
#'
#' @noRd

is_key_cached <- function(data, cols, key_cache) {
  key <- paste(sort(cols), collapse = "|")

  if (exists(key, envir = key_cache)) {
    return(get(key, envir = key_cache))
  }

  val <- is_key(data, cols)
  assign(key, val, envir = key_cache)

  val
}
