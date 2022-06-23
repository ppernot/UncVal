sidebarLayout(
  sidebarPanel(
    width = sideWidth,
    h4("Calibration/Tightness"),
    hr( style="border-color: #666;"),
    sliderInput(
      'binWidthTight',
      label = 'Bin width (%) for local stats',
      min   =   0,
      max   =  50,
      step  =   5,
      value =  15
    ),
    checkboxGroupInput(
      'choicesTight',
      label = 'Plot type/options',
      choices = list(
        'X log axis' ='logX',
        'Sliding window' = 'slide',
        'Reliab. Diagram' = 'relDiag',
        'Bootstrap RD' = 'boot'),
      selected = NULL
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
