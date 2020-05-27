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

  vctrs::new_rcrd(
    list(key=key, value=value),
    domain = vec_ptype(key),
    codomain = vec_ptype(value),

    class="keyvalue")
}

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

#' @import vctrs
#' @export
format.keyvalue <- function(x, ...) {
  key <- kv_keys(x)
  value <- kv_values(x)

  out <- paste0(key, "->", value)
  out
}

#' @export
vec_ptype_abbr.keyvalue <- function(x, ...) "kv"

#' @export
vec_ptype_full.keyvalue <- function(x, ...) {
  paste0("keyvalue<", vec_ptype_abbr(kv_keys(x)), "->", vec_ptype_abbr(kv_values(x)), ">")}



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
vec_ptype2.keyvalue.keyvalue <- function(x, y, ...) {
  keyvalue(vec_ptype_common(kv_keys(x), kv_keys(y)),
           vec_ptype_common(kv_values(x), kv_values(y)))
}

#' @method vec_cast keyvalue
#' @export
vec_cast.keyvalue <- function(x, to, ...) {
  UseMethod("vec_cast.keyvalue")
}

#' @method vec_cast.keyvalue keyvalue
#' @export
vec_cast.keyvalue.keyvalue <- function(x, to, ...) {
  keyvalue(
    vec_cast(kv_keys(x), kv_keys(to)),
    vec_cast(kv_values(x), kv_values(to))
  )
}



