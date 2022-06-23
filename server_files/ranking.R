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
    normal = 'normal' %in% input$choicesRank,
    conf_normal = 'normalCI' %in% input$choicesRank,
    rep_normal = max(50,input$repNormRank),
    xlim = xlim,
    ylim = ylim,
    title = paste0(
      'Confidence Curve / RCC(uE,|E|) = ',
      signif(cor(uE,abs(E),method = 'spearman'),2)
    ),
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

