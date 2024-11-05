
# Default rotation matrix from plot3D::lines3D for testing
rot_mat = structure(c(0.0342407002188735, 0.0298480281838387, -1.97015423557261e-18,
                      -0.0851009564049869, -0.0139566372827497, 0.00856605504767388,
                      0.0394685544521952, -0.961567222595564, 0.0383455457858734, -0.0235350428172893,
                      0.0143653790101139, -3.07494074379295, -0.0383455457858734, 0.0235350428172893,
                      -0.0143653790101139, 4.07494074379295), dim = c(4L, 4L))

# 10 point path for testing
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
  mod_stitchgraph_server,
  # Add here your module params
  args = list(transformation_matrix = reactive(rot_mat),
              full_plotdata = reactive(short_path))

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
  ui <- mod_stitchgraph_ui(id = "test")
  golem::expect_shinytaglist(ui)
  # Check that formals have not been removed
  fmls <- formals(mod_stitchgraph_ui)
  for (i in c("id")){
    expect_true(i %in% names(fmls))
  }
})

