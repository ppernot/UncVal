output$textVisual <- renderUI({
  list(
    h4("About"),
    HTML("
       Simple visual checks:
       <ul>
         <li> <b>E (|E|) vs uE</b> plot the errors (absolute errors)
            as a function of the uncertainties. The spread of the cloud
            should be parallel to the guide lines. Running quantiles are
            drawn to facilitate appreciation.
         <li> <b>Z vs V</b> for homoscedatstic datasets, uE cannot
            be used as x-axis. In such cases, one plots Z=E/uE as a
            function of the QoI V (if available in the dataset).
         <li> <b>log(|E|) vs uE</b> an alternative representation where
            the mode of the cloud should follow the y=x line. It assumes
            that the errors are generated from a normal distribution
            with the uncertainties as standard deviation. Best with
            <i>log X-axis</i> selected. Do not use for UE95.
       </ul>

       The running statistics used in the plots are estimated on a
       window with a width specified by <b>Bin width</b> which fixes
       a percentage of the dataset size.
         ")
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

  ylab = paste0('Error, E [',dataUnits(),']')
  runMode = FALSE
  runQuant = TRUE

  if(!is.null(uE)) {
    U = uE
    xlab = paste0('Uncertainty, uE [',dataUnits(),']')
  } else {
    U = UE95
    xlab = paste0('Exp. uncertainty, UE95 [',dataUnits(),']')
  }

  X = U
  Y = E
  logY = FALSE
  type = 'prop'
  if(input$typeVis == 'ZvsV' & !is.null(V)) {
    X = V
    Y = E/U
    xlab = paste0('Calculated Value, V [',dataUnits(),']')
    ylab = 'Z-score'
    type = 'horiz'

  } else if(input$typeVis == 'absEvsuE') {
    Y = abs(E)
    ylab = paste0('Abs. error, |E| [',dataUnits(),']')

  } else if(input$typeVis == 'logEvsuE') {
    logY = TRUE
    runMode = TRUE
    runQuant = FALSE
    ylab = 'log10 |E|'

  }

  if(input$binWidthVis == 0)
    nBin = NULL
  else
    nBin = 100 / input$binWidthVis

  logX = input$logVis & min(X) > 0

  xlim = rangesVisual$x
  if(is.null(xlim) & !logX & !logY) {
    if(min(X) > 0)
      xlim = c(0,max(X))
    else
      xlim = range(X)
  }
  ylim = rangesVisual$y
  if(is.null(ylim) & !logY) {
    if(min(Y) > 0)
      ylim = c(0,max(Y))
    else
      ylim = range(Y)
  }

  ErrViewLib::plotEvsPU(
    X, Y,
    logX = logX,
    logY = logY,
    type = type,
    nBin = nBin,
    runQuant = runQuant,
    runMode = runMode,
    xlab = xlab,
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

