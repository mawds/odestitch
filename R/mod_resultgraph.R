#' resultgraph UI Function
#'
#' @description Provides a rotatable 3d line graph
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_resultgraph_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(ns("maingraph")),
    sliderInput(ns("phi"), "Phi", value=40,  min=0, max=360, step=5),
    sliderInput(ns("theta"), "Theta", value=40, min=0, max=360, step=5),

  )
}

#' resultgraph Server Functions
#'
#' @noRd
mod_resultgraph_server <- function(id, points_to_plot){

  stopifnot(is.reactive(points_to_plot))

  moduleServer(id, function(input, output, session){
    ns <- session$ns

    three_d_plot <- eventReactive({points_to_plot(); input$phi; input$theta},
                                  plot3D::lines3D(points_to_plot()[,2],
                                                  points_to_plot()[,3],
                                                  points_to_plot()[,4],
                                                  phi=input$phi,
                                                  theta=input$theta,
                                                  col="blue")

    )

    output$maingraph <- renderPlot({
      three_d_plot()
    })

    invisible(reactive(three_d_plot())) # Return transformation matrix

  })
}

## To be copied in the UI
# mod_resultgraph_ui("resultgraph_1")

## To be copied in the server
# mod_resultgraph_server("resultgraph_1")
