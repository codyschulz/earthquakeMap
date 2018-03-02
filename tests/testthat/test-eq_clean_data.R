# Test eq_clean_data

test_that("test_eq_clean_data", {
  x <- earthquake_read()

  y <- x %>%
    eq_clean_data()

  expect_that(
    mean(nchar(y$LOCATION_NAME), na.rm = TRUE) < mean(nchar(x$LOCATION_NAME), na.rm = TRUE),
    is_true())

  expect_that(x$LATITUDE, is_a("character"))

  expect_that(y$LATITUDE, is_a("numeric"))

  expect_that("date" %in% colnames(x), is_false())

  expect_that("date" %in% colnames(y), is_true())

  expect_that(y$date, is_a("Date"))

  expect_that("loc0" %in% colnames(x), is_false())

  expect_that("loc0" %in% colnames(y), is_true())

})
