#' threebody UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_threebody_ui <- function(id) {
  ns <- NS(id)

  tagList(
    numericInput(ns("delta_t"), "delta t", value=1e-3, min=1e-5, max=0.1),
    numericInput(ns("max_time"), "Maximium time", value=100, min=1, max=500)
  )
}

#' threebody Server Functions
#'
#' @noRd
mod_threebody_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    reactive({
    #   parms=c(x1=input$x1, y1=input$y1,
    #           x2=input$x2, y2=input$y2,
    #           x3=input$x3, y3=input$y3)
    #
    #   times=seq(from=0,
    #             to=input$max_time,
    #             by=input$delta_t)
    #
    #
      # values <- solve_threebody(parms=parms, times=times)
    # Placeholder data for now
    values <- matrix(c(0,0,0,0,
                       0.1,0.1,0.1,0.1,
                       0.1,0.2,0.1,0.1,
                       0.1,0.2,0.3,0.1,
                       0.1,0.2,0.1,0.3,
                       0.2,0.1,0.2,0.1),
                     ncol=4, byrow=TRUE)
      return(values)
    })

  })
}

## To be copied in the UI
# mod_threebody_ui("threebody_1")

## To be copied in the server
# mod_threebody_server("threebody_1")
