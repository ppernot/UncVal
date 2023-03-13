output$textTightness <- renderUI({
  req(newSet()) # Force dependence on new dataset

  if(!is.null(uE)) {
    list(
      h4("About"),
      HTML("
      <i>Variance-based analysis</i> <br>
      <ul>
        <li> <b>Local Z-Variance analysis</b>:
            Given that Z=E/uE, the target is Var(Z) = 1, in average (calibration)
            and for all the groups (tightness).
            <ul>
              <li> <b>X = V</b> to be used for homoscedastic datasets.
              The default representation is <b>X = uE</b>.
              <li> <b>Sliding window</b> Local statistic is estimated for a sliding
              window of the same width as the groups.
            </ul>
        <li> <b>Reliability diagram</b>:
            Alternative representation where SD(E) is plotted vs RMS(uE)
            estimated within groups. The points should lie around the
            identity line.
            <ul>
               <li> <b>Bootstrap RD</b> provides confidence intervals
                    on SD(E) estimated by bootstrap.
            </ul>
      </ul>
    ")
    )
  } else {
    list(
      h4("About"),
      HTML("
      <i>Interval-based analysis</i> <br>
      <ul>
        <li> <b>Local Coverage Probability analysis</b>:
            The percentage of errors within a [-UE95,UE95] interval
            should be 0.95, in average (calibration) and for all the groups
            (tightness).
        <li> <b>Local Range Ratio analysis</b>:
            The width of the [-UE95,UE95] interval divided by the width
            of a 95 percent probability interval of the errors should be 1
            for all the groups (tightness). This is mostly useful when the
            LCP analysis saturates to 1...
            <ul>
              <li> <b>X = V</b> to be used for homoscedastic datasets.
              The default representation is <b>X = UE95</b>.
              <li> <b>Sliding window</b> Local statistic is estimated for a sliding
              window of the same width as the groups.
            </ul>
      </ul>
    ")
    )
  }
})

output$methodTight <- renderUI({
  req(newSet()) # Force dependence on new dataset

  if(!is.null(uE)) {

    list(
      radioButtons(
        'methodTight',
        label = 'Variance-based analysis',
        choices = list(
          'Local Z-Inv-SD'        = 'LZISD',
          'Local Z-Variance'      = 'LZV',
          'Reliability Diagram'   = 'RD'),
        selected = NULL
      )
    )

  } else {

    list(
      radioButtons(
        'methodTight',
        label = 'Interval-based analysis',
        choices = list(
          'Local Coverage Proba.' = 'LCP',
          'Local Range Ratio'     = 'LRR'),
        selected = NULL
      )
    )

  }

})

rangesTightness <- reactiveValues(x = NULL, y = NULL)
output$plotTightness <- renderPlot({
  validate(
    need(
      !is.null(input$dataFile),
      'Please choose a datafile !'
    )
  )
  req(input$methodTight)

  if(input$nBinTight == 0)
    nBin = NULL
  else
    nBin = input$nBinTight

  xlim = rangesTightness$x
  ylim = rangesTightness$y

  if(!is.null(uE)) {
    xlab = paste0('Uncertainty, uE [',dataUnits(),']')

    if(input$methodTight == 'RD') {

      ErrViewLib::plotRelDiag(
        uE, E,
        unit = paste0(' [',dataUnits(),']'),
        logX = 'logX' %in% input$choicesTight,
        equiPop = input$equiPopTight,
        popMin = input$popMinTight,
        logBin = input$logBinTight,
        nBin = nBin,
        xlim = xlim,
        ylim = ylim,
        title = 'Reliability Diagram',
        gPars = gPars
      )

    } else {

      X = uE
      if('xV' %in% input$choicesTight & !is.null(V)) {
        X = V
        xlab = paste0('Calculated Value, V [',dataUnits(),']')
      } else if('xX' %in% input$choicesTight & !is.null(Xi)) {
        X = Xi
        xlab = 'Input feature, X'
      }
      if(input$methodTight == 'LZV')
        ErrViewLib::plotLZV(
          X, E/uE,
          logX = if (min(X) > 0) 'logX' %in% input$choicesTight else FALSE,
          nBin = nBin,
          equiPop = input$equiPopTight,
          popMin = input$popMinTight,
          logBin = input$logBinTight,
          col = 5,
          method = 'cho',
          slide = input$slideTight,
          xlim = xlim,
          xlab = xlab,
          ylim = ylim,
          title = 'Local Z Variance analysis',
          gPars = gPars
        )
      else
        ErrViewLib::plotLZISD(
          X, E/uE,
          logX = if (min(X) > 0) 'logX' %in% input$choicesTight else FALSE,
          nBin = nBin,
          equiPop = input$equiPopTight,
          popMin = input$popMinTight,
          logBin = input$logBinTight,
          col = 5,
          method = 'cho',
          slide = input$slideTight,
          xlim = xlim,
          xlab = xlab,
          ylim = ylim,
          title = 'Local Z Inv. SD analysis',
          gPars = gPars
        )

    }

  } else {

    X = UE95
    xlab = paste0('Exp. uncertainty, UE95 [',dataUnits(),']')
    if('xV' %in% input$choicesTight & !is.null(V)) {
      X = V
      xlab = paste0('Calculated Value, V [',dataUnits(),']')
    }

    if(input$methodTight == 'LCP') {
      ErrViewLib::plotLCP(
        E, UE95,
        ordX = X,
        logX = if (min(X) > 0) 'logX' %in% input$choicesTight else FALSE,
        nBin = nBin,
        slide = 'slide' %in% input$choicesTight,
        mycols = 5,
        xlim = xlim,
        xlab = xlab,
        ylim = if(is.null(ylim)) c(0.75,1) else ylim,
        title = 'Local Coverage Proba. Analysis',
        gPars = gPars
      )

    } else {
      ErrViewLib::plotLRR(
        E, UE95,
        ordX = X,
        logX = if (min(X) > 0) 'logX' %in% input$choicesTight else FALSE,
        nBin = nBin,
        slide = FALSE,
        mycols = 5,
        xlim = xlim,
        xlab = xlab,
        ylim = ylim,
        title = 'Local Range Ratio Analysis',
        gPars = gPars
      )

    }
  }
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

