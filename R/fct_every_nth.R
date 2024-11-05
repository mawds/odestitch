#' every_nth
#'
#' @description Keep every nth row of a matrix
#'
#' @param inmat The input matrix
#' @param n the amount to downsample by. 1 keeps every row, 2 keeps every other
#' row, etc.
#'
#' @return The downsampled matrix
#'
#' @noRd
every_nth <- function(inmat, n=1) {

  if(nrow(inmat) - n <= 1){
    stop("Too few rows")
  }

  windowvec <- c(TRUE, rep(FALSE, n-1))

  return(inmat[windowvec, ])

}
