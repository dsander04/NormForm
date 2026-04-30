no_duplicates_cached <- function(data, cols) {
  key <- paste(sort(cols), collapse = "|")

  if (exists(key, envir = dup_cache)) {
    return(get(key, envir = dup_cache))
  }

  val <- !any(duplicated(data[, cols, drop = FALSE]))
  assign(key, val, envir = dup_cache)
  val
}
