#' Get keyvalue keys
#'
#' @param kv keyvalues object
#'
#' @export
kv_keys <- function(kv) {
  unclass(kv)[["key"]]
}

#' Get keyvalue values
#'
#' @param kv keyvalues object
#'
#' @export
kv_values <- function(kv) {
  unclass(kv)[["value"]]
}


