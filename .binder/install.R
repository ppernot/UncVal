install.packages(
  c(
    "boot",
    "data.table",
    "devtools",
    "shiny",
    "shinycssloaders",
    "shinyFiles",
    "shinythemes",
    "genefilter" # For ErrViewLib
  ),
  dependencies = TRUE
)
devtools::install_github("ppernot/ErrViewLIb")