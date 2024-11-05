test_that("downsampling works", {
  testmat <- matrix(c(1,1,2,2,3,3,4,4,5,5), ncol=2, byrow=TRUE)

  expect_equal(testmat, every_nth(testmat,1))
  expect_equal(every_nth(testmat,2), structure(c(1, 3, 5, 1, 3, 5), dim = 3:2))
  expect_error(every_nth(testmat, nrow(testmat)))

})
