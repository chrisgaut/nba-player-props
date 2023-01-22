## This function scrapes the team opponent totals table for a particular year off basketball-reference.com
## Christopher Gauthier - 12/3/2022

# Function
scrape_team_opponent_stats <- function(year) {
  # Scrape url
  url = paste0("https://www.basketball-reference.com/leagues/NBA_", year, ".html")
  tbl = url%>%
    read_html() %>%
    html_nodes("table") %>%
    html_table()
  
  # Turn tbl into df
  df <- data.frame(tbl[[6]]) %>%
    # Table clean up
    filter (Rk != 'N/A')
  
  # Return table
  return(df)
}

# bbref_opponent_totals <- scrape_team_opponent_stats()


