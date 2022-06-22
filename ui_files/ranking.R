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
      choices = list('Oracle curve'='oracle'),
      selected = NULL
    )
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
