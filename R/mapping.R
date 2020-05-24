
#' Create a mapping that maps names to values
#'
#' @import vctrs
#' @import rlang
#' @export
#' @examples
#' lookup <- new_mapper(c("m" = "Male", "f" = "Female", "u" = NA))
#' x <- c("m", "f", "u", "f", "f", "m", "m")
#' lookup(x)
new_mapping <- function(l) {
  stopifnot(vec_size(names(l)) == vec_size(l))

  #function(x, tbl=eval(l)) {unname(tbl[x])}

  new_function(
    args = pairlist2(x=, tbl=l),
    body = quote(unname(tbl[x])),
    env = caller_env()
  )
}
