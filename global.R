version = 0.5

options(
  shiny.maxRequestSize=15*1024^2, # Increase max loading size to 15 Mo
  width = 70
)

source("R/packages.R")

# Proportions of Side/Main Panels ####
sideWidth  <- 3
mainWidth  <- 12 - sideWidth
plotHeight <- 550
plotWidth  <- 550

# Graphical parameters ####
gPars = ErrViewLib::setgPars('shiny')

# Fine tune graph. params
gPars$cex = 1.5
gPars$mar[3] = 2

newSet <- reactiveVal(1)