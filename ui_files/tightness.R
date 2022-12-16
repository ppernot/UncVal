sidebarLayout(
  sidebarPanel(
    width = sideWidth,
    h4("Calibration/Tightness"),
    hr( style="border-color: #666;"),
    uiOutput('methodTight'),
    conditionalPanel(
      condition = "input.methodTight != 'RD'",
      fluidRow(
        column(
          11, offset=1,
          checkboxGroupInput(
            'choicesTight',
            label = NULL,
            choices = list(
              'X = V'          = 'xV',
              'X log axis'     = 'logX'),
            selected = NULL
          )
        )
      )
    ),
    sliderInput(
      'nBinTight',
      label = 'Number of bins for local stats',
      min   =   0,
      max   =  50,
      step  =   5,
      value =  15
    ),
    fluidRow(
      column(
        6,
        checkboxInput(
          'equiPopTight',
          label = 'Equal population bins',
          value = TRUE
        ),
        conditionalPanel(
          condition = "input.equiPopTight",
          checkboxInput(
            'slideTight',
            label = 'Sliding window',
            value = FALSE
          )
        ),
        conditionalPanel(
          condition = "!input.equiPopTight",
          checkboxInput(
            'logBinTight',
            label = 'Bin widths in log-space',
            value = TRUE
          )
        )
      ),
      column(
        6,
        numericInput(
          'popMinTight',
          label = 'Min. pop. in bin',
          value = 30
        )
      )
    )
  ),
  mainPanel(
    width = mainWidth,
    fluidRow(
      column(
        8,
        shinycssloaders::withSpinner(
          plotOutput(
            "plotTightness",
            dblclick = "Tightness_dblclick",
            brush = brushOpts(
              id = "Tightness_brush",
              resetOnNew = TRUE
            )
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
