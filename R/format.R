

#' @method format mapping
#' @export
format.mapping <- function(x, ...) {
  paste0(mapping_keys(x), "->", mapping_values(x))
}
