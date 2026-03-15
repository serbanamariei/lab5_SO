#!/bin/bash

shopt -s extglob

source ./functii_meniu.sh

nume=$1

while [ -z $nume ]
do
	read -p "Introduceti nume fisier: " nume
done

baza="${nume%.*}"

ok=1

while [ $ok -eq 1 ]
do

	echo "Ce doriti sa faceti?"
	echo "a) Lansati in executie editorul de text"
	echo "b) Lansati in executie compilatorul"
	echo "c) Aflati continutul fisierului pentru erori"
	echo "d) Lansati in executie programul"
	echo "e) Iesire din script"
	read -p "alegere --> " alegere

	case $alegere in
		"a") 
			ed_text
			;;
		"b")
			comp
			;;
		"c")
			cat *.err
			;;
		"d")
			if [ -x "$baza" ]
			then
				./$baza
			else
				echo "Nu s-a creat executabilul" > erori.err
			fi
			;;
		"e") 
			ok=0
			;;
	esac

done
