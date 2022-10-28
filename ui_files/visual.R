sidebarLayout(
  sidebarPanel(
    width = sideWidth,
    h4("Visual check"),
    hr( style="border-color: #666;"),
    sliderInput(
      'binWidthVis',
      label = 'Bin width (%) for running stats',
      min   =   0,
      max   =  50,
      step  =   5,
      value =  15
    ),
    radioButtons(
      'typeVis',
      label = 'Plot type',
      choices = list(
        'E vs uE' = 'EvsuE',
        '|E| vs uE' = 'absEvsuE',
        'Z vs V'  = 'ZvsV',
        'log(|E|) vs uE' = 'logEvsuE'
      ),
      inline = FALSE,
      selected = 'EvsuE'
    ),
    fluidRow(
      column(
        11, offset=1,
        checkboxInput(
          'logVis',
          label = 'log X-axis',
          value = FALSE
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
            "plotVisual",
            dblclick = "Visual_dblclick",
            brush = brushOpts(
              id = "Visual_brush",
              resetOnNew = TRUE
            )
          )
        )

      ),
      column(
        4,
        wellPanel(
          htmlOutput("textVisual")
        )
      )
    )
  )
)
