# Prop Evaluations for Every Player (P.E.E.P.) server file

# Load libraries
library(shiny)
library(tidyverse)
library(rvest)

# Load team opponent data
team_opponent_totals <- scrape_team_opponent_stats(2023) %>%
  arrange(Team) %>%
  mutate(Tm = opponents)

# Load player totals data
player_totals <- scrape_player_totals(2023)

# Server
shinyServer(function(input, output) {
  
  # Reactives
  individual_player <- eventReactive(input$run, {
    player_id <- get_bbref_player_id(input$player)
  })
  
  prop_line <- eventReactive(input$run, {
    prop_line <- as.numeric(input$line)
  })
  
  player_opponent <- eventReactive(input$run, {
    team_opponent_totals %>%
      filter(Tm == input$opponent)
  })

  # Outputs
  output$pointPropPlot <- renderPlot({
    player_id <- individual_player()
    prop_line <- prop_line()
    plot <- generate_pts_plot(player_id, prop_line)
    plot
  })
  
  output$opponentTable <- renderTable({
    player_opponent() %>%
      select(Tm, FG., X3P.)
    })

})
