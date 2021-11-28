#!/bin/bash

#State list
my_state=( 'Virginia' 'Idaho' 'Utah''Nevada' 'Texas')


#For command
for state in ${my_state[@]}
do
        if [ $state = 'Hawaii' ]
        then
                echo "Hawaii is the best!"
        else
                echo "I'm not fond of Hawaii"
        fi
done
