#' lorentz UI Function
#'
#' @description Solves the Lorentz equations
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_lorentz_ui <- function(id) {
  ns <- NS(id)
  tagList(
    sliderInput(ns("sigma"), "Sigma", value=10, min=1,max=20, step=0.1, round=0.1),
    sliderInput(ns("beta"), "Beta", value=8/3, min=1, max=10, step=0.1, round=0.1),
    sliderInput(ns("rho"), "Rho", value=28, min=1,max=50, step=0.1, round=0.1),
    numericInput(ns("delta_t"), "delta t", value=5e-3, min=1e-5, max=0.1),
    numericInput(ns("max_time"), "Maximium time", value=50, min=1, max=500)
    # TODO y[1:3]
  )
}

#' lorentz Server Functions
#'
#' @noRd
mod_lorentz_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

      reactive({
      parms=c(sigma=input$sigma,
              beta=input$beta,
              rho=input$rho)
      times=seq(from=0,
                to=input$max_time,
                by=input$delta_t)


      values <- solve_lorentz(parms=parms, times=times)
      return(values)
})

  })
}

## To be copied in the UI
# mod_lorentz_ui("lorentz_1")

## To be copied in the server
# mod_lorentz_server("lorentz_1")
