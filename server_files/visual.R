output$textVisual <- renderUI({
  list(
    h4("Explanations"),
    hr( style="border-color: #666;"),
    "blabla..."
  )
})

rangesVisual <- reactiveValues(x = NULL, y = NULL)
output$plotVisual <- renderPlot({
  validate(
    need(
      !is.null(input$dataFile),
      'Please choose a datafile !'
    )
  )

  ylab = NULL
  runMode = FALSE
  runQuant = TRUE

  X = uE
  Y = E
  logY = FALSE
  xlab = paste0('uE [',dataUnits(),']')
  type = 'prop'
  if(input$typeVis == 'ZvsV') {
    X = V
    Y = E/uE
    xlab = 'Calculated Value, V'
    ylab = 'Z-score'
    type = 'horiz'
  }

  if(input$binWidthVis == 0)
    nBin = NULL
  else
    nBin = 100 / input$binWidthVis

  if(input$typeVis == 'logEvsuE') {
    logY = TRUE
    runMode = TRUE
    runQuant = FALSE
    ylab = 'log10 |E|'
  }

  xlim = rangesVisual$x
  ylim = rangesVisual$y

  ErrViewLib::plotEvsPU(
    X, Y,
    logX = input$logVis,
    logY = logY,
    type = type,
    nBin = nBin,
    runQuant = runQuant,
    runMode = runMode,
    ylab = ylab,
    xlim = xlim,
    ylim = ylim,
    gPars = gPars
  )

},
width = plotWidth, height = plotHeight)


# observeEvent(input$choicesVis, {
#   if('logX' %in% input$choicesVis) {
#     updateCheckboxGroupInput(
#       inputId  = 'choicesTight',
#       selected =  c(input$choicesTight, 'logX')
#     )
#   } else {
#     sel = input$choicesTight
#     updateCheckboxGroupInput(
#       inputId  = 'choicesTight',
#       selected =  within(sel, rm('logX'))
#     )
#   }
# })

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

