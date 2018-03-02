# Test eq_location_clean

test_that("test_clean", {
  x <- earthquake_read()

  y <- x %>%
    eq_location_clean()

  expect_that(
    mean(nchar(y$LOCATION_NAME), na.rm = TRUE) < mean(nchar(x$LOCATION_NAME), na.rm = TRUE),
    is_true())

  expect_that("loc0" %in% colnames(y), is_true())

  expect_that("loc0" %in% colnames(x), is_false())
})
