version = 0.1

# Increase max loading size to 30 Mo
options(
  shiny.maxRequestSize=30*1024^2,
  width = 70
)

source("R/packages.R")

# Proportions of Side/Main Panels ####
sideWidth  <- 3
mainWidth  <- 12 - sideWidth
plotHeight <- 550
plotWidth  <- 750

# Graphical parameters ####
gPars = ErrViewLib::setgPars('shiny')

# Fine tune graph. params
gPars$cex = 1.5
gPars$mar[3] = 2