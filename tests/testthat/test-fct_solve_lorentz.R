test_that("Get expected result from lorentz", {
  path <- solve_lorentz(yinit=rep(0,3),times=c(0,0.001))
  expected <- structure(list(t = c(0, 0.001), x = c(0, 0), y = c(0, 0),
                             z = c(0,
                                   0), thread = c(1, 1)), class = c("tbl_df", "tbl", "data.frame"
                                   ), row.names = c(NA, -2L))
  expect_equal(path, expected)
})
