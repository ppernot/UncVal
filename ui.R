function(request) {
  source_ui <- function(...) {
    source(
      file.path("ui_files", ...),
      local = TRUE
    )$value
  }

  navbarPage(
    "UncVal",
    theme = shinythemes::shinytheme(
      c("cosmo", "cerulean", "spacelab", "yeti")[3]
    ),
    tabPanel(
      title = "Data",
      source_ui("data.R")
    ),
    tabPanel(
      title = "Visual checks",
      source_ui("visual.R")
    ),
    # tabPanel(
    #   title = "Calibration",
    #   source_ui("calibration.R")
    # ),
    tabPanel(
      title = "Tightness",
      source_ui("tightness.R")
    ),
    tabPanel(
      title = "Ranking",
      source_ui("ranking.R")
    )
  )
}