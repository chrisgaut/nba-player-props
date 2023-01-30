# Prop Evaluations for Every Player (P.E.E.P.) server file

# Load libraries
library(shiny)
library(tidyverse)
library(rvest)

# Load functions
source('nba_prop_tool/data_functions/bbref_player_id_generator.R')
source('nba_prop_tool/data_functions/bsktbllref_player_totals_scrape.R')
source('nba_prop_tool/data_functions/player_game_log_scrape.R')
source('nba_prop_tool/data_functions/team_opponent_stats_scrape.R')

# Load team opponent data
team_opponent_totals <- scrape_team_opponent_stats(2023) %>%
  arrange(Team) %>%
  mutate(Tm = opponents)

# Load player totals data
player_totals <- scrape_player_totals(2023)

# Prop dictionary
prop_name <- c('Points', 'Rebounds', 'Assists', 'PTS+REB', 'PTS+AST', 'PTS+REB+AST', 'REB+AST', 'Blocks', 
               'Steals', '3-PT Made')
new_prop_name <- c('PTS', 'REB', 'AST', 'PR', 'PA', 'PRA', 'RA', 'BLK', 'STL', '3PM')

prop_dict <- data.frame(prop_name, new_prop_name) %>%
  column_to_rownames(var = 'prop_name')


# Server
shinyServer(function(input, output) {
  
  # Reactives
  individual_player <- eventReactive(input$run, {
    player_id <- get_bbref_player_id(input$player)
    player_id
  })
  
  prop_type <- eventReactive(input$run, {
    prop_old <- as.character(input$prop)
    prop_new <- prop_dict[prop_old,]
    prop_new
  })
  
  prop_val <- eventReactive(input$run, {
    prop_val <- as.numeric(input$val)
    prop_val
  })
  
  player_opponent <- eventReactive(input$run, {
    team_opponent_totals %>%
      filter(Tm == input$opponent)
  })

  # Outputs
  output$propPlot <- renderPlot({
    player_id <- individual_player()
    prop_type <- prop_type()
    prop_val <- prop_val()
    plot <- generate_hist_plot(player_id, prop_type, prop_val)
    plot
  })
  
  output$opponentTable <- renderTable({
    player_opponent() %>%
      select(Tm, FG., X3P.)
    })

})
