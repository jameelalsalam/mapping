#' @export
new_keyvalue <- function(key, value) {
  # ideally keys and values can be any vctrs...

  vctrs::new_rcrd(list(key=key, value=value), class="keyvalue")
}

#' Key-value pairs
#'
#' Implemented to be compatible with `vctrs` and easily coercible to a mapper.
#'
#' @export
keyvalue <- function(key, value) {

  # more user-friendly, e.g., casting inputs where possible
  # maybe checking sizes are the same?

  new_keyvalue(key, value)
}

#' @export
is_keyvalue <- function(x) {
  inherits(x, "keyvalue")
}

#' @import vctrs
#' @export
format.keyvalue <- function(x, ...) {
  key <- field(x, "key")
  value <- field(x, "value")

  out <- paste0(key, "->", value)

  out
}

#' @export
vec_ptype_abbr.keyvalue <- function(x, ...) "kv"

#' @export
vec_ptype_full.keyvalue <- function(x, ...) "keyvalue"
