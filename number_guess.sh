#!/bin/bash

# PSQL variable
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Create the users table if it doesn't exist
$PSQL "CREATE TABLE IF NOT EXISTS users (username VARCHAR(22) PRIMARY KEY, games_played INT DEFAULT 0, best_game INT DEFAULT NULL);"

# Prompt for username with validation
while true; do
    read -p "Enter your username (up to 22 characters): " USERNAME
    if [[ ${#USERNAME} -le 22 ]]; then
        break
    else
        echo "Username must be 22 characters or less. Please try again."
    fi
done