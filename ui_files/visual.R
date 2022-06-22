sidebarLayout(
  sidebarPanel(
    width = sideWidth,
    h4("Visual check"),
    hr( style="border-color: #666;"),
    sliderInput(
      'binWidthVis',
      label = 'Bin width (%) for running stats',
      min   =   0,
      max   =  50,
      step  =   5,
      value =  15
    ),
    checkboxGroupInput(
      'choicesVis',
      label = 'Plot type',
      choices = list(
        'X log axis' ='logX',
        'Use log(|E|)' = 'logY',
        'Cumul. MAE curve' = 'cumMAE'),
      selected = NULL
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
