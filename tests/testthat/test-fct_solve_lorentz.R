test_that("Get expected result from lorentz", {
  path <- solve_lorentz(yinit=rep(0,3),times=c(0,0.001))
  expected <- structure(c(0, 0.001, 0, 0, 0, 0, 0, 0), dim = c(2L, 4L),
                        istate = c(0L,
                                   1L, 5L, NA, NA, NA, NA, NA, NA, NA, NA, NA, 0L, NA, NA, NA, NA,
                                   4L, NA, NA, NA), dimnames = list(NULL, c("time", "1", "2", "3"
                                   )), lengthvar = 3L, class = c("deSolve", "matrix"), type = "rk")
  expect_equal(path, expected)
})
