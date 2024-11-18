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
    selectInput(ns("initial_conditions"), "Initial_conditions",
                choices = list("Pythagorean"="pythagorean",
                               "Eight"="eight",
                               "Random position"="random_position"),
                selected="pythagorean"),
    numericInput(ns("num_points"), "num_points", value=1000, min=10, max=10000),
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
      # ICs from http://www.simplyintegrate.de/sib/index.html#x1-40002
      req(input$initial_conditions, input$num_points, input$max_time)
      # Default to unit mass for each
      parms <- c(m1=1,m2=1,m3=1)
      if(input$initial_conditions == "pythagorean"){
        parms <- c(m1=3,m2=4,m3=5)
        yinit <- c(1,3, 0, -2, -1, 0, 1, -1, 0, rep(0,9))
      } else if(input$initial_conditions == "eight"){
        yinit <- c(0.9700436,-0.24308753,0,
                   -0.9700436, 0.24308753, -0,
                   0, 0, 0,
                   0.466203685, 0.43236573, 0,
                   0.466203685, 0.43236573, 0,
                   -0.93240737, -0.86473146, -0 )
      } else if (input$initial_conditions == "random_position"){
        yinit <- runif(18)
      }


      times=seq(from=0,
                to=input$max_time,
                length.out=input$num_points)

      values <- solve_threebody(times=times,
                                parms=parms,
                                yinit=yinit)
      return(values)
    })

  })
}

## To be copied in the UI
# mod_threebody_ui("threebody_1")

## To be copied in the server
# mod_threebody_server("threebody_1")
