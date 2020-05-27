context("construct vctrs of keyvalues")

test_that("constructor works", {
  kv <- new_keyvalue(c("m", "f", "u"), c("Male", "Female", NA))

  expect_equal(vec_size(kv), 3)
  expect_equal(vec_slice(kv, 1), new_keyvalue("m", "Male"))
  expect_equal(kv[1], kv[[1]])

  kv1 <- new_keyvalue(c("m", "f"), c("Male", "Female"))
  kv2 <- new_keyvalue("u", NA_character_)
  kv3 <- new_keyvalue("u", NA)

  expect_equal(vec_c(kv1, kv2), kv)

  #vec_c(kv1, kv3)

  kv_int <- new_keyvalue("1", 1L)
  kv_dbl <- new_keyvalue("1", 1)
  kv_chr <- new_keyvalue("1", "1")
  kv_lgl <- new_keyvalue("1", TRUE)
  kv_na  <- new_keyvalue("1", NA)

  vec_c(kv_int, kv_dbl)
  vec_c(kv_dbl, kv_int)

  #vec_c(kv_int, kv_chr) #chr and int underlying are not compatible
  #vec_c(kv_chr, kv_int)

  vec_c(kv_int, kv_lgl)
  vec_c(kv_lgl, kv_int)

  vec_c(kv_int, kv_na)
  #vec_c(kv_chr, kv_na) #NA is lgl. need to use typed NA
})

# Not currently possible: https://github.com/r-lib/vctrs/issues/1118
# test_that("the type of a keyvalue with an unspecified column retains unspecifiedness", {
#   kv1 <- keyvalue(1, NA)
#   kv2 <- keyvalue(1, unspecified(1))
#   expect <- keyvalue(numeric(), unspecified())
#
#   expect_identical(vec_ptype(kv1), expect)
#   expect_identical(vec_ptype(kv2), expect)
# })

