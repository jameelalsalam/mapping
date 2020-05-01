#' @export
new_keyvalue <- function(key, value) {
  # ideally keys and values can be any vctrs...

  vctrs::new_rcrd(list(key=key, value=value), class="keyvalue")
}

#' @method format keyvalue
#' @import vctrs
#' @export
format.keyvalue <- function(x, ...) {
  key <- field(x, "key")
  value <- field(x, "value")

  out <- paste0(key, "->", value)

  out
}

# vec_ptype_abbr.keyvalue <- function(x, ...) "k-v"
# vec_ptype_full.keyvalue <- function(x, ...) "key-value"
