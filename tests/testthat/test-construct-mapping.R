
context("construct and apply a mapping")

test_that("constructor works", {
  lookup <- new_mapping(c("m" = "Male", "f" = "Female", "u" = NA))
  x <- c("m", "f", "u", "f", "f", "m", "m")
  expect_equal(lookup(x), c("Male", "Female", NA, "Female", "Female", "Male", "Male"))
})
