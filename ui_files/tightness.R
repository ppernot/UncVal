sidebarLayout(
  sidebarPanel(
    width = sideWidth,
    h4("Calibration/Tightness"),
    hr( style="border-color: #666;"),
    sliderInput(
      'binWidthTight',
      label = 'Bin width (%) for local stats',
      min   =   0,
      max   =  50,
      step  =   5,
      value =  15
    ),
    uiOutput('methodTight'),
    fluidRow(
      column(
        11, offset=1,
        conditionalPanel(
          condition = "input.methodTight != 'RD'",
          checkboxGroupInput(
            'choicesTight',
            label = NULL,
            choices = list(
              'X = V'          = 'xV',
              'X log axis'     = 'logX',
              'Sliding window' = 'slide'),
            selected = NULL
          )
        ),
        conditionalPanel(
          condition = "input.methodTight == 'RD'",
          checkboxInput(
            'bootRD',
            label = 'Bootstrap RD',
            value = FALSE
          )
        )
      )
    )
  ),
  mainPanel(
    width = mainWidth,
    fluidRow(
      column(
        8,
        plotOutput(
          "plotTightness",
          dblclick = "Tightness_dblclick",
          brush = brushOpts(
            id = "Tightness_brush",
            resetOnNew = TRUE
          )
        )
      ),
      column(
        4,
        wellPanel(
          htmlOutput("textTightness")
        )
      )
    )
  )
)
