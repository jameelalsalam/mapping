
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

  keyvals <- setNames(values, keys)

  structure(
    new_function(
      args = pairlist2(x=NULL, kv=keyvals),
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
