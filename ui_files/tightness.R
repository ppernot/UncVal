sidebarLayout(
  sidebarPanel(
    width = sideWidth,
    h4("Tightness analysis"),
    hr( style="border-color: #666;"),
    sliderInput(
      'binWidthTight',
      label = 'Bin width (%) for local stats',
      min   =   0,
      max   = 100,
      step  =  10,
      value =   0
    ),
    checkboxGroupInput(
      'choicesTight',
      label = 'Plot type',
      choices = c('logX','slide'),
      selected = NULL,
      inline = TRUE
    )
  ),
  mainPanel(
    width = mainWidth,
    plotOutput(
      "plotTightness",
      dblclick = "Tightness_dblclick",
      brush = brushOpts(
        id = "Tightness_brush",
        resetOnNew = TRUE
      )
    )
  )
)
