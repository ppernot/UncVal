output$textTightness <- renderUI({
  list(
    h4("About"),
    HTML("
      <b>Variance-based calibration/tightness tests</b>
      <BR>&nbsp;<BR>
      <i>Local Z-variance analysis</i> <br>
      Given that Z=E/uE, the target is Var(Z) = 1, in average (calibration)
      and for all the groups (tightness).
      <ul>
        <li> <b>Var(Z) vs V</b> to be used for homoscedastic datasets.
          The default representation is <b>Var(Z) vs uE</b>.
        <li> <b>Sliding window</b> Var(Z) is estimated for a sliding
          window of the same width as the groups.
      </ul>
      <i>Reliability diagram</i> <br>
      Alternative representation where SD(E) is plotted vs RMS(uE)
      estimated within groups. The points should lie around the
      identity line.
      <ul>
        <li> <b>Bootstrap RD</b> provides confidence intervals
          on Var(E) estimated by bootstrap.
      </ul>
    ")
  )
})

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
    ErrViewLib::plotRelDiag(
      uE, E,
      logX = 'logX' %in% input$choicesTight,
      nBin = nBin,
      nBoot = if(boot) 1000 else 0,
      xlim = xlim,
      ylim = ylim,
      title = 'Reliability Diagram',
      gPars = gPars
    )

  } else {
    X = uE
    xlab = 'Prediction uncertainty, uE'
    if('xV' %in% input$choicesTight) {
      X = V
      xlab = 'Calculated Value, V'
    }
    ErrViewLib::plotLZV(
      X, E/uE,
      logX = if (min(X) > 0) 'logX' %in% input$choicesTight else FALSE,
      nBin = nBin,
      method = 'cho',
      slide = 'slide' %in% input$choicesTight,
      xlim = xlim,
      xlab = xlab,
      ylim = ylim,
      title = 'Local Z Variance analysis',
      gPars = gPars
    )
  }

},
width = plotWidth, height = plotHeight)

# observeEvent(input$choicesTight, {
#   if('logX' %in% input$choicesTight) {
#     updateCheckboxGroupInput(
#       inputId  = 'choicesVis',
#       selected =  c(input$choicesVis, 'logX')
#     )
#   } else {
#     sel = input$choicesVis
#     updateCheckboxGroupInput(
#       inputId  = 'choicesVis',
#       selected =  within(sel, rm('logX'))
#     )
#   }
# })

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

