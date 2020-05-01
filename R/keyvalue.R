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


##### Coercion and Casting ------------

# key-value representations in R:
# 1) named vectors name(x) -> x, chr -> any, lookup by x[name]
# 2) two column df, df$key -> df$value, any -> any, lookup by left_join & pull
# 3) functions, x -> f(x), any -> any, lookup by f(x), not necessarily discrete
# 4) dictionary implementation?
# 5) plyr::mapvectors?
# 6) ggplot2::aes()?
# 7) purrr::as_mapper accepts formulas (anonymous functions), but turns numeric and character into extractor functions

#' @export
vec_ptype2.keyvalue.keyvalue <- function(x, y, ...) new_keyvalue()


