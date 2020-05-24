
context("construct and apply a mapping")

test_that("constructor works", {
  lookup <- new_mapping(c("m", "f", "u"), c("Male", "Female", NA))
  x <- c("m", "f", "u", "f", "f", "m", "m")
  expect_equal(lookup(x), c("Male", "Female", NA, "Female", "Female", "Male", "Male"))
})

test_that("calling mapping without args returns zero-length result", {
  lookup <- new_mapping(key = c("1"), value = 2)
  expect_equal(lookup(), numeric())
})
