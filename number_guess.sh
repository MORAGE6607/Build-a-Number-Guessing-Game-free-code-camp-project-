#!/bin/bash

# PSQL variable
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Create the users table if it doesn't exist
$PSQL "CREATE TABLE IF NOT EXISTS users (username VARCHAR(22) PRIMARY KEY, games_played INT DEFAULT 0, best_game INT);"

# Prompt for username
echo "Enter your username:"
read USERNAME

# Validate username length (22 characters or less)
if [[ ${#USERNAME} -gt 22 ]]; then
  echo "Username must be 22 characters or less."
  exit 1
fi

# Check if the user exists in the database
USER_INFO=$($PSQL "SELECT games_played, best_game FROM users WHERE username = '$USERNAME';")

if [[ -z $USER_INFO ]]; then
  # New user
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  GAMES_PLAYED=0
  $PSQL "INSERT INTO users (username, games_played) VALUES ('$USERNAME', 0);"
else
  # Existing user
  IFS='|' read -ra ADDR <<< "$USER_INFO"
  GAMES_PLAYED=${ADDR[0]}
  BEST_GAME=${ADDR[1]}

  if [[ -z $BEST_GAME ]]; then
    BEST_GAME_MESSAGE="N/A"
  else
    BEST_GAME_MESSAGE=$BEST_GAME
  fi

  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME_MESSAGE guesses."
fi

# Generate a random number between 1 and 1000
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=0

# Start the guessing game
echo "Guess the secret number between 1 and 1000:"
while true; do
  read GUESS

  # Validate that the input is an integer
  if ! [[ $GUESS =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
    continue
  fi

  # Increment the guess count
  NUMBER_OF_GUESSES=$(( NUMBER_OF_GUESSES + 1 ))

  # Check the guess
  if (( GUESS < SECRET_NUMBER )); then
    echo "It's higher than that, guess again:"
  elif (( GUESS > SECRET_NUMBER )); then
    echo "It's lower than that, guess again:"
  else
    # Correct guess
    echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
    break
  fi
done

# Update user statistics in the database
NEW_GAMES_PLAYED=$(( GAMES_PLAYED + 1 ))

if [[ -z $BEST_GAME ]] || [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]; then
  $PSQL "UPDATE users SET games_played = $NEW_GAMES_PLAYED, best_game = $NUMBER_OF_GUESSES WHERE username = '$USERNAME';"
else
  $PSQL "UPDATE users SET games_played = $NEW_GAMES_PLAYED WHERE username = '$USERNAME';"
fi
