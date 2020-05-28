context("construct vctrs of keyvalues")

kv <- new_keyvalue(c("m", "f", "u"), c("Male", "Female", NA))

kv_int <- new_keyvalue("1", 1L)
kv_dbl <- new_keyvalue("1", 1)
kv_chr <- new_keyvalue("1", "1")
kv_lgl <- new_keyvalue("1", TRUE)
kv_na  <- new_keyvalue("1", NA)

test_that("can construct and access components", {
  kv <- new_keyvalue(c("m", "f", "u"), c("Male", "Female", NA))

  expect_equal(length(kv), 3)
  expect_equal(vec_size(kv), 3)

  expect_equal(vec_slice(kv, 1), new_keyvalue("m", "Male"))

  expect_equal(kv_keys(kv), c("m", "f", "u"))
  expect_equal(kv_values(kv), c("Male", "Female", NA))

  expect_null(names(kv))
})

test_that("rcrd functions also work !?!", {
  r <- new_keyvalue(key = 1, value = 2)

  expect_equal(length(r), 1)
  expect_equal(n_fields(r), 2)

  expect_equal(names(r), NULL)
  expect_equal(fields(r), c("key", "value"))

  #expect_error(r$key, class = "vctrs_error_unsupported")
  expect_equal(field(r, "key"), 1)
})

test_that("keyvalue prototype", {
  expect_identical(vec_ptype(kv), new_keyvalue(character(), character()))
})

test_that("coercions of keyvalues", {

  expect_identical(vec_cast(kv_int, vec_ptype(kv_dbl)), kv_dbl)
  expect_identical(vec_cast(kv_dbl, vec_ptype(kv_int)), kv_int)
  expect_identical(vec_cast(kv_lgl, vec_ptype(kv_int)), kv_int)

})


test_that("combining keyvalues", {
  kv1 <- new_keyvalue(c("m", "f"), c("Male", "Female"))
  kv2 <- new_keyvalue("u", NA_character_)
  kv3 <- new_keyvalue("u", NA)

  expect_equal(vec_c(kv1, kv2), kv)
  expect_equal(vec_c(kv1, kv3), kv)

  vec_c(kv_int, kv_dbl)
  vec_c(kv_dbl, kv_int)

  vec_c(kv_int, kv_lgl)
  vec_c(kv_lgl, kv_int)
})

test_that("na can be combined with any other types", {
  expect_equal(vec_c(kv_int, kv_na), keyvalue(c("1", "1"), c(1L, NA_integer_)))
  expect_equal(vec_c(kv_chr, kv_na), keyvalue(c("1", "1"), c("1", NA_character_)))
})

# Not possible with rcrd, so switched to tibble: https://github.com/r-lib/vctrs/issues/1118
test_that("the type of a keyvalue with an unspecified column retains unspecifiedness", {
  kv1 <- keyvalue(1, NA)
  kv2 <- keyvalue(1, unspecified(1))
  expect <- keyvalue(numeric(), unspecified())

  expect_identical(vec_ptype(kv1), expect)
  expect_identical(vec_ptype(kv2), expect)
})

