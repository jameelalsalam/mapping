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

  #TODO: vec_c(kv1, kv3) creates problems b/c I need to learn how to coerce partial types...
})

