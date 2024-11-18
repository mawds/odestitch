#' every_nth
#'
#' @description Keep every nth row of a matrix
#'
#' @param inmat The input tibble
#' @param n the amount to downsample by. 1 keeps every row, 2 keeps every other
#' row, etc.
#'
#' @return The downsampled matrix
#'
#' @noRd
every_nth <- function(intibble, n=1) {

  downsampled <- intibble |>
    dplyr::group_by(thread) |>
    dplyr::filter(dplyr::row_number() %% {{n}}==0) |>
    dplyr::ungroup()

  return(downsampled)

}
