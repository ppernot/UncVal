sidebarLayout(
  sidebarPanel(
    width = sideWidth,
    h4("Visual check"),
    hr( style="border-color: #666;"),
    sliderInput(
      'binWidthVis',
      label = 'Bin width (%) for running stats',
      min   =   0,
      max   = 100,
      step  =  10,
      value =   0
    ),
    checkboxGroupInput(
      'choicesVis',
      label = 'Plot type',
      choices = c('logX','logY','cumMAE'),
      selected = NULL,
      inline = TRUE
    )
  ),
  mainPanel(
    width = mainWidth,
    plotOutput(
      "plotVisual",
      dblclick = "Visual_dblclick",
      brush = brushOpts(
        id = "Visual_brush",
        resetOnNew = TRUE
      )
    )
  )
)
