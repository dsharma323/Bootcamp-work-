#!/bin/bash
read -p "Enter the game: " game_played
if [ "$game_played" = roulette ]
then
 grep $2 $1_Dealer_schedule | grep $3 | awk -F" " '{print "Time: "$1,$2" | ""Dealer: "$5,$6}'

elif [ "$game_played" = blackjack ]
then
 grep $2 $1_Dealer_schedule | grep $3 | awk -F" " '{print "Time: "$1,$2" | ""Dealer: "$3,$4}'

elif [ "$game_played" = texas ]
then
 grep $2 $1_Dealer_schedule | grep $3 | awk -F" " '{print "Time: "$1,$2" | ""Dealer: "$7,$8}'
fi
