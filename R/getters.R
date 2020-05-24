#' Get keyvalue keys
#'
#' @param kv keyvalues object
#'
#' @export
kv_keys <- function(kv) {
  field(kv, "key")
}

#' Get keyvalue values
#'
#' @param kv keyvalues object
#'
#' @export
kv_values <- function(kv) {
  field(kv, "value")
}


