rangesVisual <- reactiveValues(x = NULL, y = NULL)
output$plotVisual <- renderPlot({
  validate(
    need(
      !is.null(input$dataFile),
      'Please choose a datafile !'
    )
  )

  X = uE
  xlab = paste0('uE [',dataUnits(),']')

  Y = E

  if(input$binWidthVis == 0)
    nBin = NULL
  else
    nBin = 100 / input$binWidthVis

  ylab = NULL
  runMode = FALSE
  runQuant = TRUE
  logY = 'logY' %in% input$choicesVis
  if(logY) {
    runMode = TRUE
    runQuant = FALSE
    ylab = 'log |E|'
  }


  xlim = rangesVisual$x
  ylim = rangesVisual$y

  ErrViewLib::plotEvsPU(
    X, Y,
    logX = 'logX' %in% input$choicesVis,
    logY = 'logY' %in% input$choicesVis,
    nBin = nBin,
    runQuant = runQuant,
    runMode = runMode,
    cumMAE = 'cumMAE' %in% input$choicesVis,
    ylab = ylab,
    xlim = xlim,
    ylim = ylim,
    gPars = gPars
  )
},
width = plotWidth, height = plotHeight)


observeEvent(input$Visual_dblclick, {
  brush <- input$Visual_brush
  if (!is.null(brush)) {
    rangesVisual$x <- c(brush$xmin, brush$xmax)
    rangesVisual$y <- c(brush$ymin, brush$ymax)
  } else {
    rangesVisual$x <- NULL
    rangesVisual$y <- NULL
  }
})

