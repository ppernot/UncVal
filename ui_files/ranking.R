sidebarLayout(
  sidebarPanel(
    width = sideWidth,
    h4("Ranking analysis"),
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
      label = 'Plot type',
      choices = c('oracle'),
      selected = NULL,
      inline = TRUE
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
