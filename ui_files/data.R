sidebarLayout(
  sidebarPanel(
    width = sideWidth,
    h4("Select Data File"),
    hr(style="border-color: #666;"),
    fileInput(
      "dataFile",
      label = "Choose CSV File",
      multiple = FALSE,
      accept = c(
        "text/csv",
        "text/comma-separated-values,text/plain",
        ".csv")
    ),
    textInput(
      "units",
      label = "Units",
      value = 'a.u.'
    ),
    hr(style="border-color: #666;"),
    wellPanel(
      h4("About"),
      h5("Author      : P. Pernot"),
      h5("Affiliation : CNRS"),
      h5(paste0("Version     : ",version)),
      # hr( style="border-color: #666;"),
      # h5(a(href="https://ppernot.github.io/UncVal","User's Manual")),
      h5(a(href="https://github.com/ppernot/UncVal","How to cite")),
      h5(a(href="https://github.com/ppernot/UncVal","code@github")),
      h5(a(href="https://github.com/ppernot/UncVal/issues",
        "Bug report, Feature request"))
    )
  ),
  mainPanel(
    width = mainWidth,
    verbatimTextOutput("selectMsg"),
    htmlOutput("howTo"),
  )
)
