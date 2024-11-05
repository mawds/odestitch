#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  plotdata <- mod_lorentz_server("lorentz_1")

  transformation_matrix <- mod_resultgraph_server("resultgraph_1", points_to_plot=plotdata)

}
