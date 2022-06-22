rangesTightness <- reactiveValues(x = NULL, y = NULL)
output$plotTightness <- renderPlot({
  validate(
    need(
      !is.null(input$dataFile),
      'Please choose a datafile !'
    )
  )

  X = uE
  xlab = paste0('uE [',dataUnits(),']')

  Y = E/uE

  if(input$binWidthTight == 0)
    nBin = NULL
  else
    nBin = 100 / input$binWidthTight


  xlim = rangesTightness$x
  ylim = rangesTightness$y

  ErrViewLib::plotLZV(
    X, Y,
    logX = 'logX' %in% input$choicesTight,
    nBin = nBin,
    method = 'cho',
    slide = 'slide' %in% input$choicesTight,
    xlim = xlim,
    ylim = ylim,
    gPars = gPars
  )
},
width = plotWidth, height = plotHeight)


observeEvent(input$Tightness_dblclick, {
  brush <- input$Tightness_brush
  if (!is.null(brush)) {
    rangesTightness$x <- c(brush$xmin, brush$xmax)
    rangesTightness$y <- c(brush$ymin, brush$ymax)
  } else {
    rangesTightness$x <- NULL
    rangesTightness$y <- NULL
  }
})

