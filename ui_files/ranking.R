sidebarLayout(
  sidebarPanel(
    width = sideWidth,
    h4("Ranking-based validation"),
    hr(style="border-color: #666;"),
    checkboxGroupInput(
      'choicesRank',
      label = 'Plot options',
      choices = list(
        'Oracle curve' = 'oracle',
        'Prob. ref. curve'  = 'probref',
        'Prob. ref. CI'     = 'probrefCI'
        ),
      selected = 'probref'
    ),
    checkboxInput(
      "advancedRank",
      label= "Advanced params",
      value = FALSE
    ),
    conditionalPanel(
      condition = "input.advancedRank",
      fluidRow(
        column(
          11, offset=1,
          radioButtons(
            'distProbrefRank',
            label = 'Distribution for prob. ref. curve',
            choices = list(
              'Normal'  = 'Normal',
              't(df=4)' = 'T4',
              'Laplace' = 'Laplace',
              'Uniform' = 'Uniform',
              'Normp(p=4)' = 'Normp4'
            ),
            inline = FALSE,
            selected = 'Normal'
          ),
          sliderInput(
            'repProbrefRank',
            label = 'Sample size for prob. ref. Curve',
            min   =   0,
            max   = 500,
            step  =  50,
            value =  50
          ),
          radioButtons(
            'statRank',
            label = 'Error statistic',
            choices = list(
              'MAE'  = 'MAE',
              'RMSD' = 'RMSD',
              'Q95'  = 'Q95'
            ),
            inline = TRUE,
            selected = 'MAE'
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
        shinycssloaders::withSpinner(
          plotOutput(
            "plotRanking",
            dblclick = "Ranking_dblclick",
            brush = brushOpts(
              id = "Ranking_brush",
              resetOnNew = TRUE
            )
          )
        )
      ),
      column(
        4,
        wellPanel(
          htmlOutput("textRanking")
        )
      )
    )
  )
)
