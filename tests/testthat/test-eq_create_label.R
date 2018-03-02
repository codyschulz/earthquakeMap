# Test eq_create_label
library(dplyr)

test_that("test_eq_create_label", {
  x <- earthquake_read() %>%

    eq_clean_data() %>%

    mutate(popup_text = eq_create_label(.))

  expect_that("popup_text" %in% colnames(x), is_true())

  expect_that(x$popup_text, is_a("character"))

})
