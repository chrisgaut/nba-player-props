## This function generates a player's bbref player id
## Christopher Gauthier - 12/3/2022

# Function
get_bbref_player_id <- function(player_full_name) {
  
  # Remove all special characters
  player_full_name <- gsub('[^[:alnum:] ]','',player_full_name)
  
  # Remove accents from characters
  player_full_name <- iconv(player_full_name, to = 'ASCII//TRANSLIT')
  
  # Get first and last names separated
  first_name <- tolower(strsplit(player_full_name, " ")[[1]][1])
  last_name <- tolower(strsplit(player_full_name, " ")[[1]][2])
  
  # Combine first 5 letters of last name, first 2 letters of first name, and '01' to create player id
  player_id <- paste0(substr(last_name,1,5), substr(first_name,1,2), '01')
    
  # Return player id value
  return(player_id)
}

# player_id <- get_bbref_player_id('Jalen Brunson')