#' Reduces the amount of keys being stored by reducing redundant information
#'
#' @param data data frame
#' @param cols list
#'
#' @return True or False depending on whether the subset is a duplicate of
#' another subset that has already been cached

no_duplicates_cached <- function(data, cols) {
  key <- paste(sort(cols), collapse = "|")

  if (exists(key, envir = dup_cache)) {
    return(get(key, envir = dup_cache))
  }

  val <- !any(duplicated(data[, cols, drop = FALSE]))
  assign(key, val, envir = dup_cache)
  val
}
