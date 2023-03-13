dataUnits <- reactiveVal()

output$selectMsg <- renderPrint({
  validate(
    need(
      !is.null(input$dataFile),
      'Minimal datafile format (.csv):\n\n  "E", "uE"\n   0.1, 0.2\n  ...\n  -0.5, 0.8\n\n'
    )
  )

  cat('Data set : ', input$dataFile[['name']],'\n')

  data = data.table::fread(
    file=input$dataFile$datapath,
    header=TRUE,
    data.table = FALSE)
  cat('Nb points : ',NROW(data) ,'\n\n')

  isolate({
    nK = newSet() + 1
    newSet(nK) # Force reset of interface with new dataset
  })

  # (Re)-set global variables
  E    <<- NULL
  uE   <<- NULL
  UE95 <<- NULL
  V    <<- NULL
  Xi   <<- NULL

  cnames = colnames(data)

  if('X' %in% cnames) # Optional input feature
    Xi <<- data[,'X']

  if('E' %in% cnames) {
    # Get E, uE/UE95, opt. V

    E <<- data[,'E']

    if('uE' %in% cnames)
      uE <<- data[,'uE']

    if('UE95' %in% cnames)
      UE95 <<- data[,'UE95']

    if('V' %in% cnames) # Optional
      V <<- data[,'V']

  } else if('V' %in% cnames) {
    # Get V, R, uV/UV95, opt. uR/UR95

    V <<- data[,'V']

    if('R' %in% cnames)
      E <<- data[,'R'] - V

    if('uV' %in% cnames) {
      uE <<- data[,'uV']
      if('uR' %in% cnames)
        uE <<- sqrt(data[,'uR']^2 + data[,'uV']^2)
    }

    if('UV95' %in% cnames) {
      UE95 <<- data[,'UV95']
      if('UR95' %in% cnames)
        UE95 <<- sqrt(data[,'UR95']^2 + data[,'UV95']^2)
    }

  } else {
    # Nothing...
  }

  dataUnits(input$units)

  if(!is.null(E)) {
    cat('Units    : ', dataUnits(),'\n')
    cat('\n')
    cat('> Original data (5 first lines):\n\n')
    print(head(data, n = 5,row.names = FALSE))
    cat('\n')
    cat('> Parsed data (5 first lines):\n\n')
    if(!is.null(uE)) {
      M = data.table(cbind(E = E, uE = uE))
    } else if(!is.null(UE95)) {
      M = data.table(cbind(E = E, UE95 = UE95))
    }
    if(!is.null(V))
      M = cbind(M, V = V)
    if(!is.null(Xi))
      M = cbind(M, X = Xi)
    print(head(M, n = 5,row.names = FALSE))
    cat('\n')

  } else {
    cat('>>> Unrecognized column names :',cnames,'\n')
    cat('>>> Use (E, uE or UE95) or (V, uV or UV95, R, uR or UR95)\n')
  }

})

output$howTo <- renderText({
  '<h4>Short help on tabs:</h4>
  <ul style="list-style-type:none;">
    <li> <b>Data</b>: Choose a csv datafile.
    <li> <b>Visual checks</b>: Simple visualizations of the data.
    <li> <b>C/C/A</b>: Calibration/Consistency/Adaptivity validation.
    <li> <b>Ranking</b>: Ranking-based validation.
  </ul>
  <h4>Valid data columns combinations:</h4>
  <ul>
    <li> "E", "uE" or "UE95", ["X"]
    <li> "E", "V", "uE" or "UE95", ["X"]
    <li> "R", "V", "uE" or "UE95", ["X"]
    <li> "R", "uR" or "UR95", "V", "uV" or "UV95", ["X"]
  </ul>
  where
  <ul style="list-style-type:none;">
    <li> <b>X</b>: Input feature
    <li> <b>E</b>: Error (R-V)
    <li> <b>V</b>: Calculated/predicted value
    <li> <b>R</b>: Reference value
    <li> <b>uy</b>: Standard uncertainty on y in (E, V, R)
    <li> <b>Uy95</b>: Expanded uncertainty at 95 % level on y in (E, V, R)
  </ul>
  <BR>
  For details see <A HREF="http://dx.doi.org/10.1063/5.0109572">P. Pernot (2022)
  Prediction uncertainty validation for computational chemists.</A>
  '
})
