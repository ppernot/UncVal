function(input, output, session) {

  # Load Server files ####
  files <- c(
    "data.R" ,
    "visual.R",
    # "calibration.R",
    "tightness.R",
    "ranking.R"
  )

  for (f in files)
    source(
      file.path("server_files", f),
      local = TRUE
    )
}
