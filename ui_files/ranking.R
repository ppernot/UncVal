sidebarLayout(
  sidebarPanel(
    width = sideWidth,
    h4("Ranking-based validation"),
    hr( style="border-color: #666;"),
    # sliderInput(
    #   'binWidthTight',
    #   label = 'Bin width (%) for local stats',
    #   min   =   0,
    #   max   = 100,
    #   step  =  10,
    #   value =   0
    # ),
    checkboxGroupInput(
      'choicesRank',
      label = 'Plot options',
      choices = list(
        'Oracle curve' = 'oracle',
        'Normal curve' = 'normal',
        'Normal CI' = 'normalCI'
        ),
      selected = NULL
    ),
    sliderInput(
      'repNormRank',
      label = 'Sample size for Normal Curve',
      min   =   0,
      max   = 500,
      step  =  50,
      value =  50
    ),

  ),
  mainPanel(
    width = mainWidth,
    plotOutput(
      "plotRanking",
      dblclick = "Ranking_dblclick",
      brush = brushOpts(
        id = "Ranking_brush",
        resetOnNew = TRUE
      )
    )
  )
)
