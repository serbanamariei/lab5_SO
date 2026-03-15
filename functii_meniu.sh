#!/bin/bash

ed_text()
{
	vim $nume
}

comp()
{
	rm -f !(*.c|*.cpp|*.sh)

	if [[ $nume == *.c ]]
	then
		gcc -Wall $nume -o $baza 2> erori.err
	elif [[ $nume == *.cpp ]]
	then
		g++ -Wall $nume -o $baza 2> erori.err
	else
		echo "Tipul nu este corect introdus, reintroduceti-l"
	fi
}

