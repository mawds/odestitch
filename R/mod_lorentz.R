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
    sliderInput(ns("sigma"), "Sigma", value=10, min=1,max=20),
    sliderInput(ns("beta"), "Beta", value=8/3, min=1, max=10),
    sliderInput(ns("rho"), "Rho", value=28, min=1,max=50),
    numericInput(ns("delta_t"), "delta t", value=1e-3),
    numericInput(ns("steps"), "Steps", value=5e4)
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
                by=input$delta_t,
                length.out=input$steps)

      values <- solve_lorentz(parms=parms, times=times)
      return(values)
})

  })
}

## To be copied in the UI
# mod_lorentz_ui("lorentz_1")

## To be copied in the server
# mod_lorentz_server("lorentz_1")
