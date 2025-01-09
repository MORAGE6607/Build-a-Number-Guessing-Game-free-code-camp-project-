#!/bin/bash

# PSQL variable
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Create the users table if it doesn't exist
$PSQL "CREATE TABLE IF NOT EXISTS users (username VARCHAR(22) PRIMARY KEY, games_played INT DEFAULT 0, best_game INT DEFAULT NULL);"

# Prompt for username with validation
while true; do
    read -p "Enter your username:" USERNAME
    if [[ ${#USERNAME} -le 22 ]]; then
        break
    else
        echo "Username must be 22 characters or less. Please try again."
    fi
done

# Check if the user exists
USER_INFO=$($PSQL "SELECT games_played, best_game FROM users WHERE username = '$USERNAME';")

if [[ -z $USER_INFO ]]; then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    GAMES_PLAYED=0
    BEST_GAME=0
else
    GAMES_PLAYED=$(echo $USER_INFO | cut -d ' ' -f 1)
    BEST_GAME=$(echo $USER_INFO | cut -d ' ' -f 2)
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# Generate a random number between 1 and 1000
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=0

# Game loop
while true; do
    read -p "Guess the secret number between 1 and 1000: " GUESS

    # Check if the input is an integer
    if ! [[ $GUESS =~ ^[0-9]+$ ]]; then
        echo "That is not an integer, guess again:"
        continue
    fi

    NUMBER_OF_GUESSES=$(( NUMBER_OF_GUESSES + 1 ))

    if (( GUESS < SECRET_NUMBER )); then
        echo "It's higher than that, guess again:"
    elif (( GUESS > SECRET_NUMBER )); then
        echo "It's lower than that, guess again:"
    else
        echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
        break
    fi
done

# Update user statistics in the database
if [[ $GAMES_PLAYED -eq 0 ]]; then
    $PSQL "INSERT INTO users (username, games_played, best_game) VALUES ('$USERNAME', 1, $NUMBER_OF_GUESSES);"
else
    NEW_GAMES_PLAYED=$(( GAMES_PLAYED + 1 ))
    if [[ -z $BEST_GAME ]] || [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]; then
        $PSQL "UPDATE users SET games_played = $NEW_GAMES_PLAYED, best_game = $NUMBER_OF_GUESSES WHERE username = '$USERNAME';"
    else
        $PSQL "UPDATE users SET games_played = $NEW_GAMES_PLAYED WHERE username = '$USERNAME';"
    fi
fi