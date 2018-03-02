# Test earthquake_read

expect_that(earthquake_read(), is_a("tbl_df"))

expect_that(earthquake_read("in/data.csv"), throws_error())
