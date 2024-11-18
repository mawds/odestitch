test_that("downsampling works", {

  test_tibble <- tibble::tibble(x=c(1,2,3,4), thread=1)


  expect_equal(test_tibble, every_nth(test_tibble,1))
  expect_equal(every_nth(test_tibble,2),
               structure(list(x = c(2, 4), thread = c(1, 1)), class = c("tbl_df",
                                                                        "tbl", "data.frame"), row.names = c(NA, -2L))
  )

})
