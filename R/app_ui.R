#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      pageWithSidebar(
        titlePanel("ODE Stitch"),
        sidebarPanel(
          selectInput("ode", label="Select ODE",
                      choices = list("Lorentz"="lorentz",
                                     "Three body problem"="threebody"),
                      selected = "lorentz"),
          uiOutput("odecontrols")
        ),
        mainPanel(
          tabsetPanel(
            tabPanel("3d view",
                     shinycssloaders::withSpinner(mod_resultgraph_ui("resultgraph_1"))),
            tabPanel("Export view",
                     mod_stitchgraph_ui("stitchgraph_1")
            )
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "odestitch"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
