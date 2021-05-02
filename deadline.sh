#!/bin/bash

echo -e "\n\t\tOdredjivanje krajnjeg roka (datuma) za pregledanje kolokvijuma\n"

case $# in
0)

	echo "Unesite datum kada je kolokvijum radjen: "
	read datum
	;;
1)
	if [[ "$1" = '--help' || "$1" = '-h' ]]
	then
		echo 'Usage: deadline [date]'
		exit 0
	else
		datum="$1"
	fi

	;;
*)
	datum="$@"
	;;
esac

ispis=$(date '+Datum odrzavanja: %F' -d "$datum" || exit 1)

if [ $? = "1" ]
then
	echo 'Usage: deadline [date]'
	exit 1
fi

echo
echo $ispis

formati="yyyy-mm-dd dd-mm-yyyy Jan_01_1970 izadji"

echo
echo 'Izaberite format datuma'

select izabran_format in $formati;
do
	case $izabran_format in
	'yyyy-mm-dd')
		format='%F'
		;;
	'dd-mm-yyyy')
		format='%d-%m-%Y'
		;;
	'Jan_01_1970')
		format='%b %d %Y'
		;;
	'izadji')
		echo ""
		exit 0 
		;;
	esac

	ispis=$(date "+Krajnji rok: $format" -d "${datum} +2 weeks" || exit 1)

	if [ $? = 1 ]
	then
		echo 'Usage: deadline [date]'
		exit 1
	fi
	
	echo $ispis
done
