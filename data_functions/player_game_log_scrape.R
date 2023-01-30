## This function scrapes the game log for a particular player in a particular year off basketball-reference.com
## Christopher Gauthier - 12/3/2022

# Function
scrape_player_game_log <- function(player_id, year) {
  # Scrape url
  url = paste0("https://www.basketball-reference.com/players/d/", player_id, "/gamelog/", year)
  tbl = url%>%
    read_html() %>%
    html_nodes("table") %>%
    html_table()
  
  # Turn tbl into df
  df <- data.frame(tbl[[8]]) %>%
    # Table clean up
    filter(Rk != 'Rk') %>%
    select(-Rk)
  
  # Make stats numeric
  df$PTS <- as.numeric(df$PTS)
  df$PTS <- as.numeric(df$AST)
  df$PTS <- as.numeric(df$TRB)
  df$PTS <- as.numeric(df$STL)
  df$PTS <- as.numeric(df$BLK)
  df$PTS <- as.numeric(df$X3P)
  
  # Return table
  return(df)
}

# player_game_log <- scrape_player_game_log('duranke01', 2023)
