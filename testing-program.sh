#!/bin/bash
tablica=(0 1 2 2 3 2 4 2 4 3 4 2 6 2 4 4 5 2 6 2 6 4 4 2 8 3 4 4 6 2 8 2 6 4 4 4 9 2 4 4 8 2 8 2 6 6 4 2 10 3 6 4 6 2 8 4 8 4 4 2 12 2 4 6 7 4 8 2 6 4 8 2 12 2 4 6 6 4 8 2 10 5 4 2 12 4 4 4 8 2 12 4 6 4 4 4 12 2 6 6 9)
dzielenie=$(($2/1000))
reszta=$(($2%1000))
reszta=$( printf "%03d" $reszta)
wynik="$dzielenie.$reszta""s"

for ((i=1; $i <=100; i++)) ; do
        output=$(timeout $wynik ./$1 $i)
	if [ $? -eq 124 ] ; then
		echo "TLE"
		exit 0
	fi
	if (( $output!=${tablica[$i]} )) ; then
		echo "ANS" 
		exit 0
	fi
done
echo "OK"
#Łukasz Wroński

