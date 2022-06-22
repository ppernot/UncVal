
K <- reactiveVal(1)
dataUnits <- reactiveVal()
output$selectMsg <- renderPrint({
  if(is.null(input$dataFile)) {
    cat('Minimal expected datafile format (.csv):\n\n')
    cat('"E","uE"\n')
    cat('"0.1","0.2"\n')
    cat('...\n')
    cat('"0.5","0.8"\n\n')
    return()
  }

  cat('Data set : ', input$dataFile[['name']],'\n\n')

  data = data.table::fread(
    file=input$dataFile$datapath,
    header=TRUE,
    data.table = FALSE)

  cnames = colnames(data)
  if('E' %in% cnames)
    E <<- data[,'E']
  if('uE' %in% cnames)
    uE <<- data[,'uE']

  dataUnits(input$units)

  cat('Units    : ', dataUnits(),'\n')
  cat('\n')
  cat('> E & uE (5 first and last lines):\n\n')
  M = data.table(cbind(Errors = E, Unc = uE))
  print(M, trunc.cols = TRUE,row.names = FALSE)
  cat('\n')

})

output$howTo <- renderText({
  '<h4>Short help on tabs:</h4>
  <ul style="list-style-type:none;">
    <li> <b>Data:</b> Choose a csv datafile.
    <li> <b>Visual check:</b> Simple visualizations of the data.
    <li> <b>Calibration:</b> Calibration statistics.
    <li> <b>Tightness:</b> Tightness validation.
    <li> <b>Ranking:</b> ranking-based validation.
  </ul>'
})
