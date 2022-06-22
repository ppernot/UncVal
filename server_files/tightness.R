rangesTightness <- reactiveValues(x = NULL, y = NULL)
output$plotTightness <- renderPlot({
  validate(
    need(
      !is.null(input$dataFile),
      'Please choose a datafile !'
    )
  )

  xlab = paste0('uE [',dataUnits(),']')

  if(input$binWidthTight == 0)
    nBin = NULL
  else
    nBin = 100 / input$binWidthTight


  xlim = rangesTightness$x
  ylim = rangesTightness$y

  if('relDiag' %in% input$choicesTight) {

    boot = 'boot' %in% input$choicesTight
    ErrViewLib::plotCalVar(
      uE, E,
      logX = 'logX' %in% input$choicesTight,
      nBin = nBin,
      # slide = 'slide' %in% input$choicesTight,
      nBoot = if(boot) 1000 else 0,
      xlim = xlim,
      ylim = ylim,
      title = 'Reliability Diagram',
      gPars = gPars
    )

  } else {
    ErrViewLib::plotLZV(
      uE, E/uE,
      logX = 'logX' %in% input$choicesTight,
      nBin = nBin,
      method = 'cho',
      slide = 'slide' %in% input$choicesTight,
      xlim = xlim,
      xlab = 'Prediction uncertainty, uE',
      ylim = ylim,
      title = 'Local Z Variance analysis',
      gPars = gPars
    )
  }

},
width = plotWidth, height = plotHeight)

observeEvent(input$choicesTight, {
  if('logX' %in% input$choicesTight) {
    updateCheckboxGroupInput(
      inputId  = 'choicesVis',
      selected =  c(input$choicesVis, 'logX')
    )
  } else {
    sel = input$choicesVis
    updateCheckboxGroupInput(
      inputId  = 'choicesVis',
      selected =  within(sel, rm('logX'))
    )
  }
})

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

