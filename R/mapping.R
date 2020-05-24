
#' Low Level Constructor for Key-Value Mappings
#'
#' @param keys from the domain
#' @param values to which to map the keys
#'
#' Right now mapping uses a named vector lookup, so only character vectors can be keys.
#' This will be generalized to vectors in the future.
#'
#' @import vctrs
#' @import rlang
#' @export
#' @examples
#' lookup <- new_mapping(c("m", "f", "u"), c("Male", "Female", NA))
#' x <- c("m", "f", "u", "f", "f", "m", "m")
#' lookup(x)
new_mapping <- function(keys, values) {
  stopifnot(vec_size(keys) == vec_size(values))

  keyvals <- stats::setNames(values, keys)

  structure(
    new_function(
      args = pairlist2(x=vec_ptype(keys), kv=keyvals),
      body = quote(unname(kv[x])),
      env = caller_env()
    ),

    class = c("mapping", "vctrs_vctr")
  )
}

#' @export
vec_proxy.mapping <- function(x, ...) {
  fn_fmls(x)[["kv"]]
}

#' Key-value mapping
#'
#' @param keys character vector of keys
#' @param values to map the keys to
#' @export
mapping <- function(keys, values) {
  k <- vec_cast(keys, character())

  new_mapping(k, values)
}


#' Coerce objects to callable mappings
#'
#' @param x object to coerce
#' @param ... reserved
#'
#' Generic function. Methods for named vectors (chr -> vctr), dfs (df[[1]] -> df[[2]]), lists (l[[1]] -> l[[2]]), and functions (as is, but with no more than one required parameter).
#'
as_mapping <- function(x, ...) {
  UseMethod("as_mapping", x)
}

#' @method as_mapping data.frame
#' @export
as_mapping.data.frame <- function(x, ...) {

  stopifnot(ncol(x) >= 2)

  key_col_num <- (which("key" %in% names(x))) %0% 1
  value_col_num <- (which("value" %in% names(x))) %0% 2 # not really right

  new_mapping(keys = x[[key_col_num]], values = x[[value_col_num]])
}

