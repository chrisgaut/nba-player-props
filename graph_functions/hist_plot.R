## This function generates a histogram for a particular player and a particular prop
## Christopher Gauthier - 12/3/2022

# Function
generate_hist_plot <- function(player_id, prop, val) {
  
  prop_col <- prop
  
  # Get data
  data <- scrape_player_game_log(player_id, 2023)
  
  # Manipulate data
  data <- data %>% 
    mutate(PR = PTS + TRB,
           PA = PTS + AST,
           RA = TRB + AST,
           PRA = PTS + TRB + AST) %>%
    mutate(Date_Short = substring(Date, 6),
           Color = ifelse(prop < val, "red","green")) %>%
    tail(n = 10)
  
  # Plot
  p <- ggplot(data=data, aes(x=Date_Short, y=prop_col, fill = Color)) +
    geom_bar(stat="identity", width = 0.75) +
    scale_fill_identity(guide = 'none') +
    geom_vline(xintercept = 5.5, linetype=2)
  
  # Return plot
  return(p)
  
}

# pts_plot <- generate_pts_plot('brunsja01', 20.5)
# pts_plot

