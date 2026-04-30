is_key_cached <- function(data, cols) {
  key <- paste(sort(cols), collapse = "|")

  if (exists(key, envir = key_cache)) {
    return(get(key, envir = key_cache))
  }

  val <- is_key(data, cols)
  assign(key, val, envir = key_cache)
  val
}
