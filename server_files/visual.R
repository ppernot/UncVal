output$textVisual <- renderUI({
  list(
    h4("About"),
    HTML("
       Simple visual checks:
       <ul>
         <li> <b>E vs uE</b> plot the errors as a function of the
            uncertainties. The spread of the cloud should be
            parallel to the guide lines. Running quantiles are
            drawn to facilitate appreciation.
         <li> <b>Z vs V</b> for homoscedatstic datasets, uE cannot
            be used as x-axis. In scu cases, one plots Z=E/uE as a
            function od the QoI V (it it has been entered in the dataset).
         <li> <b>log(|E|) vs uE</b> an alternative representation where
            the mode of the cloud should follow the y=x line. It assumes
            that the errors are generated from a normal distribution
            with the uncertainties as standard deviation. Best with
            <i>log X-axis</i> selected.
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

