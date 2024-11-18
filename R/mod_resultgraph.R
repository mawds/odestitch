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

    three_d_plot <- eventReactive({points_to_plot(); input$phi; input$theta},{

      # If there's more than one thread, use this for colvar
      # Otherwise colvar is NULL
      # (plotting doesn't work properly with a single value for
      # colvar)
      if( length(unique(points_to_plot()$thread)) > 1) {
        colvar <- points_to_plot()$thread
      } else {
        colvar <- NULL
      }

      plot3D::lines3D(points_to_plot()$x,
                      points_to_plot()$y,
                      points_to_plot()$z,
                      colvar=colvar,
                      phi=input$phi,
                      theta=input$theta)

    })

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
