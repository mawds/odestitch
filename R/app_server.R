#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  plotdata <- reactive({
    switch(input$ode,
           "lorentz"={
             mod_lorentz_server("lorentz_1")()
           },
           "threebody"={
             mod_threebody_server("threebody_1")()
           }
    )
  })


  # plotdata <- mod_lorentz_server("lorentz_1")

  output$odecontrols <- renderUI({
    switch(input$ode,
           lorentz={
             mod_lorentz_ui("lorentz_1")
           },
           "threebody"={
             mod_threebody_ui("threebody_1")
           })
  })

  transformation_matrix <- mod_resultgraph_server("resultgraph_1", points_to_plot=plotdata)

  mod_stitchgraph_server("stitchgraph_1",
                         transformation_matrix=transformation_matrix,
                         full_plotdata=plotdata)
}
