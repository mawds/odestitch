#' stitchgraph UI Function
#'
#' @description Given the data and a 3d tranformation matrix show the 2d
#' projection and export facility
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_stitchgraph_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(ns("two_d_plot")),
    checkboxInput(ns("show_stitches"), label="Show stitches"),
    sliderInput(ns("downsample_stitches"), label="Keep every nth stitch",
                value=1, min=1, max=10),
    downloadButton(ns("save_stitch_svg"), label="Save svg")

  )
}

#' stitchgraph Server Functions
#'
#' @noRd
mod_stitchgraph_server <- function(id, transformation_matrix, full_plotdata){

  stopifnot(is.reactive(transformation_matrix))
  stopifnot(is.reactive(full_plotdata))
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    plotdata <- eventReactive({full_plotdata(); input$downsample_stitches},
                              {
                                every_nth(full_plotdata(),
                                          input$downsample_stitches)
                              })

    two_d_ggplot <- eventReactive({transformation_matrix(); plotdata()}, {

      two_d_projection <- plot3D::trans3D(plotdata()[,2],
                                          plotdata()[,3],
                                          plotdata()[,4],
                                          transformation_matrix())

      tibble::tibble(x=two_d_projection$x, y=two_d_projection$y)  |>
        ggplot2::ggplot(ggplot2::aes(x=x, y=y)) +
        ggplot2::geom_path() +
        ggplot2::theme_void()
    })

    output$two_d_plot <- renderPlot({
      plt <- two_d_ggplot()

      if(input$show_stitches)
        plt <- plt +
          ggplot2::geom_point(col="blue")

      plt
      })
    output$save_stitch_svg <- downloadHandler("stitches.svg",
                                              content = function(file) {
                                                ggplot2::ggsave(file,
                                                                plot=two_d_ggplot())
                                              })

  })

}

## To be copied in the UI
# mod_stitchgraph_ui("stitchgraph_1")

## To be copied in the server
# mod_stitchgraph_server("stitchgraph_1")
