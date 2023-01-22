## This function scrapes the player totals table for a particular year off basketball-reference.com
## Christopher Gauthier - 4/18/2022

# Function
scrape_player_totals <- function(year) {
  # Scrape url
  url = paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_totals.html")
  tbl = url%>%
    read_html() %>%
    html_nodes("table") %>%
    html_table()
  
  # Turn tbl into df
  df <- data.frame(tbl) %>%
    # Table clean up
    filter(Rk != 'Rk')
  
  # Return table
  return(df)
}

# bbref_player_totals <- scrape_player_totals(2023)
