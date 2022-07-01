# Options ####
Sys.setlocale(category = "LC_NUMERIC", locale = "C")

options(
  width = 60,
  warn = 0
)

# Local install ----

# # CRAN Libraries ----
# libs <- c(
#   "devtools", "boot",
#   "shiny", "shinyFiles","shinycssloaders",
#   "data.table"
#
# )
# for (lib in libs) {
#   if (!require(lib, character.only = TRUE, quietly = TRUE))
#     install.packages( lib,
#       # repos = "https://cran.univ-paris1.fr",
#       dependencies = FALSE
#     )
#   library(lib, character.only = TRUE, quietly = TRUE)
# }
# # ## Other libraries ----
lib = "ErrViewLib"
if(!require(lib,character.only = TRUE))
devtools::install_github(
  paste0("ppernot/",lib),
  dependencies = TRUE)
library(lib,character.only = TRUE)

# Cloud deployment ----

library("devtools")
library("shiny")
library("shinyFiles")
library("shinycssloaders")
library("boot")
# library("ErrViewLib")
library("data.table")
