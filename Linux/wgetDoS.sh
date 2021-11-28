#!/bin/bash

#To attack one machine at a time remove $i in 10.0.0.$i and change to 5, 6, or 7

while true

do

	for i in 5 6 7

	do
   		wget 10.0.0.$i

	done 

done



