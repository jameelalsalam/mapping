#' Vectors of Key-Value Pairs
#'
#' @param key vector of keys
#' @param values vector of values
#'
#' Length of the `key` and `value` vectors must be the same.
#' In order to maintain vctrs invariants, these are not valid mappings in this form.
#'
#' @export
new_keyvalue <- function(key=unspecified(), value=unspecified()) {
  # ideally keys and values can be any vctrs...

  structure(
    tibble(key=key, value=value),
    class = c("keyvalue", class(tibble()))
  )
}

#' @export
length.keyvalue <- function(x) {
  vec_size(x)
}

#' @export
names.keyvalue <- function(x) {
  NULL
}

#' @import vctrs
#' @export
format.keyvalue <- function(x, ...) {
  key <- kv_keys(x)
  value <- kv_values(x)

  out <- paste0(key, vec_recycle("->", vec_size(x)), value)
  out
}

#' @export
vec_ptype_abbr.keyvalue <- function(x, ...) "kv"

#' @export
vec_ptype_full.keyvalue <- function(x, ...) {
  paste0("keyvalue<", vec_ptype_abbr(kv_keys(x)), "->", vec_ptype_abbr(kv_values(x)), ">")}









#' Key-value pairs
#'
#' @param key vector of keys
#' @param value vector of values to which keys are mapped
#'
#' Implemented to be compatible with `vctrs` and easily coercible to a mapping.
#'
#' @export
keyvalue <- function(key = unspecified(), value = unspecified()) {

  # more user-friendly, e.g., casting inputs where possible?
  stopifnot(vec_size(key) == vec_size(value))

  new_keyvalue(key, value)
}



#' Is it a keyvalue?
#'
#' @param x object to check
#'
#' @export
is_keyvalue <- function(x) {
  inherits(x, "keyvalue")
}




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
as_keyvalue <- function(x) {
  stopifnot("value" %in% colnames(x))
  stopifnot("key" %in% colnames(x))

  keyvalue(unclass(x)[["key"]], unclass(x)[["value"]])
}

#' @export
vec_ptype2.keyvalue.keyvalue <- function(x, y, ...) {
  as_keyvalue(tib_ptype2(x, y, ...))
}

#' @method vec_cast keyvalue
#' @export
vec_cast.keyvalue <- function(x, to, ...) {
  UseMethod("vec_cast.keyvalue")
}

#' @method vec_cast.keyvalue keyvalue
#' @export
vec_cast.keyvalue.keyvalue <- function(x, to, ...) {
  as_keyvalue(tib_cast(x, to, ...))
}



