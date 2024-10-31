#' resultgraph UI Function
#'
#' @description A shiny Module.
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
    sliderInput(ns("theta"), "Theta", value=40, min=0, max=360, step=5)

  )
}

#' resultgraph Server Functions
#'
#' @noRd
mod_resultgraph_server <- function(id, points_to_plot){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    output$maingraph <- renderPlot({

      testdata <- matrix(c(0,0,0,1,1,0,1,1,1), ncol=3, byrow=TRUE)
      points_to_plot <- testdata

      plot3D::lines3D(points_to_plot[,1],
                      points_to_plot[,2],
                      points_to_plot[,3],
                         phi=input$phi, theta=input$theta)
    })

  })
}

## To be copied in the UI
# mod_resultgraph_ui("resultgraph_1")

## To be copied in the server
# mod_resultgraph_server("resultgraph_1")
