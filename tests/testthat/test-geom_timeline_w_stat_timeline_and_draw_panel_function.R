# Test geom_timeline (with stat_timeline and draw_panel_function)

# Note: stat_timeline and draw_panel_function are embedded in the
# geom_timeline call and so are only testable within it (i.e. not independently)

test_that("test_geom_timeline_w_stat_timeline_and_draw_panel_function", {
  x <- earthquake_read() %>%

    eq_clean_data() %>%

    ggplot() +
    geom_timeline(aes(
      x = date,
      xmin = as.Date("2005-01-01"),
      xmax = as.Date("2018-02-22"),
      colour = TOTAL_DEATHS,
      y = COUNTRY,
      size = EQ_PRIMARY)
      )

  expect_that(x, is_a("ggplot"))

})
