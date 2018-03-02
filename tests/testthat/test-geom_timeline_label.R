# Test geom_timeline_label

test_that("test_geom_timeline_label", {
  x <- earthquake_read() %>%

    eq_clean_data() %>%

    ggplot() +
    geom_timeline_label(aes(
      x = date,
      xmin = as.Date("2005-01-01"),
      xmax = as.Date("2018-02-22"),
      colour = TOTAL_DEATHS,
      y = COUNTRY,
      size = EQ_PRIMARY,
      label = "LOCATION_NAME"),
      n_max = 10
    )

  expect_that(x, is_a("ggplot"))

})
