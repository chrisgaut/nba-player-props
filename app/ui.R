### Prop Evaluations for Every Player (P.E.E.P.) ui file

# Load libraries
library(shiny)

# Load filter choice lists
props = c('Points', 'Rebounds', 'Assists', 'PTS+REBS', 'PTS+ASTS', 
          'PTS+REBS+ASTS', 'REBS+ASTS', 'Blocks', 'Steals', '3-PT Made')
opponents = c('ATL', 'BOS', 'BRK', 'CHO', 'CHI', 'CLE', 'DAL', 'DEN', 'DET', 'GSW', 'HOU', 
              'IND', 'LAC', 'LAL', 'MEM', 'MIA', 'MIL', 'MIN', 'NOP', 'NYK', 'OKC', 'ORL', 
              'PHI', 'PHO', 'POR', 'SAC', 'SAS', 'TOR', 'UTA', 'WAS')
players = player_totals$Player

# ui
shinyUI(fluidPage(

    titlePanel("Prop Evaluations for Every Player (P.E.E.P.)"),

    fluidRow(
        column(3,
            selectInput("player",
                        label = "Player:",
                        choices = players,
                        selected = "Jalen Brunson")
        ),
        
        column(3,
               selectInput("prop",
                           label = "Prop:",
                           choices = props,
                           selected = 'Points')
        ),
        
        column(3,
               textInput("line",
                         label = "Line:",
                         placeholder = "Enter a numeric value")
        ),
        
        column(3,
               selectInput("opponent",
                           label = "Opponent:",
                           choices = opponents,
                           selected = "ATL")
        ),
        
        column(12,
               actionButton("run", 
                            label = "Get Prop Evaluation",
                            width = "100%",
                            class = "btn-lg btn-success")
        )
    ),
    
    fluidRow(
      column(6,
             plotOutput("pointPropPlot")
             ),
      column(6, 
             tableOutput("opponentTable")
             )
    )
            
        )
    )
