# Test geom_timeline

test_that("test_geom_timeline", {
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
