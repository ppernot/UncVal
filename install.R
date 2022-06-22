# CRAN Libraries ----
libs <- c(
  "devtools","shiny","shinyFiles","inlmisc","data.table"
  # "Hmisc", "rlist", "boot", "lmtest",
  # "shiny", "shinyFiles", "BiocManager","Biogenerics","Biobase",
  # "DT", "tools", "inlmisc", "distillery", "ineq","plotly",   "pvclust"
)
for (lib in libs)
  install.packages( lib, dependencies = TRUE)

# ## Other libraries ----
lib = "ErrViewLib"
devtools::install_github(paste0("ppernot/",lib))
