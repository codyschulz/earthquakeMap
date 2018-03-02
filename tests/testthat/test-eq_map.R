# Test eq_map

test_that("test_eq_map", {
  x <- earthquake_read() %>%

    eq_clean_data() %>%

    mutate(popup_text = eq_create_label(.)) %>%

    eq_map(annot_col = "popup_text")

  expect_that(x, is_a("leaflet"))

})
