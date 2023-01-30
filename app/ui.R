### Prop Evaluations for Every Player (P.E.E.P.) ui file

# Load libraries
library(shiny)

# Load filter choice lists
props = c('Points', 'Rebounds', 'Assists', 'PTS+REB', 'PTS+AST', 'PTS+REB+AST', 'REB+AST', 'Blocks', 
          'Steals', '3-PT Made')
opponents = team_opponent_totals$Tm
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
               textInput("val",
                         label = "Value:",
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
             plotOutput("propPlot")
             ),
      column(6, 
             tableOutput("opponentTable")
             )
    )
            
        )
    )
