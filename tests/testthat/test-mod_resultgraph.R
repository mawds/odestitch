short_path = structure(c(0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007,
                         0.008, 0.009, 0.485242333495989, 0.484849502637359, 0.484588481844681,
                         0.484457766575422, 0.48445590296699, 0.484581486904669, 0.484833163112672,
                         0.485209624267812, 0.485709610135316, 0.486331906726326, 0.439317306037992,
                         0.452182422025039, 0.465026328171357, 0.477852635313786, 0.490664910591254,
                         0.503466678848346, 0.516261424012669, 0.529052590446662, 0.541843584274432,
                         0.554637774684248, 0.557519967202097, 0.556251145887788, 0.554991780501937,
                         0.553741889788149, 0.552501498512045, 0.551270637359387, 0.550049342842675,
                         0.548837657215933, 0.547635628397407, 0.546443309899942),
                       dim = c(10L,
                               4L), dimnames = list(NULL, c("time", "1", "2", "3")))

testServer(
  mod_resultgraph_server,
  # Add here your module params
  args = list(points_to_plot=reactive(short_path))
  , {
    ns <- session$ns
    expect_true(
      inherits(ns, "function")
    )
    expect_true(
      grepl(id, ns(""))
    )
    expect_true(
      grepl("test", ns("test"))
    )
    # Here are some examples of tests you can
    # run on your module
    # - Testing the setting of inputs
    # session$setInputs(x = 1)
    # expect_true(input$x == 1)
    # - If ever your input updates a reactiveValues
    # - Note that this reactiveValues must be passed
    # - to the testServer function via args = list()
    # expect_true(r$x == 1)
    # - Testing output
    # expect_true(inherits(output$tbl$html, "html"))
})

test_that("module ui works", {
  ui <- mod_resultgraph_ui(id = "test")
  golem::expect_shinytaglist(ui)
  # Check that formals have not been removed
  fmls <- formals(mod_resultgraph_ui)
  for (i in c("id")){
    expect_true(i %in% names(fmls))
  }
})

