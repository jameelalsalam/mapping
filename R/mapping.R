
#' Low Level Constructor for Key-Value Mappings
#'
#' @param key vector from the domain
#' @param value vector to which to map the keys
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
new_mapping <- function(key, value) {
  stopifnot(vec_size(key) == vec_size(value))

  keyvals <- stats::setNames(value, key)
  keyval_df <- tibble::tibble(key = key, value = value)

  structure(
    new_function(
      args = pairlist2(x=vec_ptype(key), kv=keyval_df),
      body = quote({
        dplyr::left_join(
          tibble::tibble(key = x),
          tibble::tibble(key = keys(kv), value = values(kv)),
          by = "key"
        )[["value"]]
        }),
      env = caller_env()
    ),

    class = c("mapping", "vctrs_vctr")
  )
}

mapping_df <- function(x) {
  fn_fmls(x)[["kv"]]
}

#' Retrieve mapping values
#'
#' @export
mapping_values <- function(x) {
  fn_fmls(x)[["kv"]][["value"]]
}

#' Retrieve mapping keys
#'
#' @export
mapping_keys <- function(x) {
  fn_fmls(x)[["kv"]][["key"]]
}





#' Key-value mapping
#'
#' @param key character vector of keys
#' @param value to map the keys to
#' @export
mapping <- function(key, value) {
  new_mapping(key, value)
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

  new_mapping(key = x[[key_col_num]], value = x[[value_col_num]])
}


