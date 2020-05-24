
#' Create a mapping that maps names to values
#'
#' @import vctrs
#' @import rlang
#' @export
#' @examples
#' lookup <- new_mapper(c("m" = "Male", "f" = "Female", "u" = NA))
#' x <- c("m", "f", "u", "f", "f", "m", "m")
#' lookup(x)
new_mapping <- function(keyvals) {
  stopifnot(vec_size(names(keyvals)) == vec_size(keyvals))

  new_function(
    args = pairlist2(x=, kv=keyvals),
    body = quote(unname(kv[x])),
    env = caller_env()
  )
}
