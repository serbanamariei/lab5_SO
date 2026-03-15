#!/bin/bash

input=$1
output=$2

if [[ $# -lt 1 ]]
then
	echo "Introduceti fisierul de intrare de la linia de comanda"
	exit 1
fi

if [[ $# -le 1 ]]
then
	output=${2:-/dev/stdout}
fi

nr_linii=$(wc -l < "$input")
if [ "$nr_linii" -lt 10 ]
then
	echo "Fisierul de intrare NU are cel putin 10 linii"
	exit 1
fi

if [[ $output != "/dev/stdout" ]]
then
	> $output
fi

cnt=1

while IFS=',' read -r ip mac nume comentariu
do
	echo "procesare linie $cnt: $ip,$mac,$nume,$comentariu" >&2

	mac_formatat=$(echo "$mac" | sed \
	's/\(\w\w\)\(\w\w\)\(\w\w\)\(\w\w\)\(\w\w\)\(\w\w\)/\1:\2:\3:\4:\5:\6/g')

	{
		echo "host $nume {"
		echo "	option host-name \"$nume\";"
		echo "	hardware ethernet $mac_formatat;"
		echo "	fixed-address $ip;"
		echo "}"
	} >> "$output"

	((cnt++))
done < "$input"
