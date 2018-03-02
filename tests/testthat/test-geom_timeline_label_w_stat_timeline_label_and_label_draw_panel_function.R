# Test geom_timeline_label (with stat_timeline_label and label_draw_panel_function)

# Note: stat_timeline_label and label_draw_panel_function are embedded in the
# geom_timeline_label call and so are only testable within it (i.e. not independently)

test_that("test_geom_timeline_label_w_stat_timeline_label_and_label_draw_panel_function", {
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
