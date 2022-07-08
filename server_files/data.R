

dataUnits <- reactiveVal()

output$selectMsg <- renderPrint({
  if(is.null(input$dataFile)) {
    cat('Minimal expected datafile format (.csv):\n====\n')
    cat('"E","uE"\n')
    cat('"0.1","0.2"\n')
    cat('...\n')
    cat('"0.5","0.8"\n====')
    cat('\n')
    cat('Optional columns: "V" (QoI)\n\n')
    return(NULL)
  }

  cat('Data set : ', input$dataFile[['name']],'\n\n')

  data = data.table::fread(
    file=input$dataFile$datapath,
    header=TRUE,
    data.table = FALSE)

  isolate({
    nK = newSet() + 1
    newSet(nK) # Force reset of interface with new dataset
  })

  # (Re)-set global variables
  E    <<- NULL
  uE   <<- NULL
  UE95 <<- NULL
  V    <<- NULL

  cnames = colnames(data)
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
    cat('> Parsed data (5 first and last lines):\n\n')
    if(!is.null(uE)) {
      M = data.table(cbind(E = E, uE = uE))
    } else if(!is.null(UE95)) {
      M = data.table(cbind(E = E, UE95 = UE95))
    }
    if(!is.null(V))
      M = cbind(M, V = V)
    print(M, trunc.cols = TRUE,row.names = FALSE)
    cat('\n')

  } else {
    cat('>>> Unrecognized column names :',cnames,'\n')
    cat('>>> Use (E, uE or UE95) or (V, uV or UV95, R, uR or UR95)\n')
  }

})

output$howTo <- renderText({
  '<h4>Short help on tabs:</h4>
  <ul style="list-style-type:none;">
    <li> <b>Data:</b> Choose a csv datafile.
    <li> <b>Visual check:</b> Simple visualizations of the data.
    <li> <b>C/T:</b> Calibration/Tightness validation.
    <li> <b>Ranking:</b> ranking-based validation.
  </ul>'
})
