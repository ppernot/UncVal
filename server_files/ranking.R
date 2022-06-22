rangesRanking <- reactiveValues(x = NULL, y = NULL)
output$plotRanking <- renderPlot({
  validate(
    need(
      !is.null(input$dataFile),
      'Please choose a datafile !'
    )
  )

  xlim = rangesRanking$x
  ylim = rangesRanking$y

  ErrViewLib::plotConfidence(
    E, uE,
    oracle = 'oracle' %in% input$choicesRank,
    xlim = xlim,
    ylim = ylim,
    gPars = gPars
  )
},
width = plotWidth, height = plotHeight)


observeEvent(input$Ranking_dblclick, {
  brush <- input$Ranking_brush
  if (!is.null(brush)) {
    rangesRanking$x <- c(brush$xmin, brush$xmax)
    rangesRanking$y <- c(brush$ymin, brush$ymax)
  } else {
    rangesRanking$x <- NULL
    rangesRanking$y <- NULL
  }
})

