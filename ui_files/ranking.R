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
        'Ideal curve'  = 'ideal',
        'Ideal CI'     = 'idealCI'
        ),
      selected = 'ideal'
    ),
    checkboxInput(
      "advancedRank",
      label= "Advanced params",
      value = FALSE
    ),
    conditionalPanel(
      condition = "input.advancedRank",
      radioButtons(
        'distIdealRank',
        label = 'Distribution for Ideal curve',
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
        'repIdealRank',
        label = 'Sample size for Ideal Curve',
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
  ),
  mainPanel(
    width = mainWidth,
    fluidRow(
      column(
        8,
        plotOutput(
          "plotRanking",
          dblclick = "Ranking_dblclick",
          brush = brushOpts(
            id = "Ranking_brush",
            resetOnNew = TRUE
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
