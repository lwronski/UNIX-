#!/bin/bash

sed -i '$s/$/\nkoniec3434/' $1
sed -i '$s/$/\nkoniec3434/' $2

# usuwanie komentarzy typu //, zamieniam na spacje
FILE1=$(perl -wpe 's/\/\/.*/ /' <$1 )
FILE2=$(perl -wpe 's/\/\/.*/ /' <$2 )


# usuwanie komentarzy typu /* */, zamieniam na spacje
FILE1=$(perl -wpe 'BEGIN{undef $/} s!/\*.*?\*/! !sg'   <(echo "$FILE1") )
FILE2=$(perl -wpe 'BEGIN{undef $/} s!/\*.*?\*/! !sg'   <(echo "$FILE2") )



# zliczenie ile linii ma dany plik

ilosc=$( grep -c '' <(echo "$FILE1") )
ilosc2=$( grep -c '' <(echo "$FILE2") )


if [ $ilosc -gt $ilosc2 ] ; then
      ilosccopy=$ilosc
      ilosc=$ilosc2
      ilosc2=$ilosccopy
fi

for (( i = 1; $i <=$ilosc; i++ )) ; do

              linia=$( sed -n "${i}p" <(echo "$FILE1") )  # wczytanie linii
              linia2=$( sed -n "${i}p" <(echo "$FILE2") )

              linia=$(sed 's/\(.*\)/ \1 /' <(echo "$linia") ) # wstawienie spacji na sam pocz¹tek
              linia2=$(sed 's/\(.*\)/ \1 /' <(echo "$linia2") )

              liniastring=$( sed 's/".*"/yyy/g' <(echo "$linia") )    # zamiania stringow na tekst yyy
              liniastring2=$( sed 's/".*"/yyy/g' <(echo "$linia2") )

              liniastring=$(sed  's/[[:space:]]*\([][!#$%&()*+,-.\/:;<=>?@\\^`'\''{}|~]\)[[:space:]]*/ \1 /g' <(echo "$liniastring") )       # przed i za operatorem wstawiam jedna spacje
              liniastring2=$( sed 's/[[:space:]]*\([][!#$%&()*+,-.\/:;<=>?@\\^`'\''{}|~]\)[[:space:]]*/ \1 /g' <(echo "$liniastring2") )

              liniastring=$(sed  's/[[:space:]]\+/ /g' <(echo "$liniastring") )       # kilkatrotne znaki bia³e zamieniam na jedna spacje
              liniastring2=$( sed 's/[[:space:]]\+/ /g' <(echo "$liniastring2") )

              onlystring=$( perl -wpe 's!.*?(".*?")!$1!sg' <(echo "$linia") )         #linia która sk³ada siê tylko ze stringów, reszte usuwam
              onlystring=$( perl -wpe 's!(".*").*!$1!sg' <(echo "$onlystring") )
              onlystring=$( sed 's/[^"]*//' <(echo "$onlystring") )                   # gdy nie wystêpuje ¿aden string, do dwóch wczeœniejszych nie nast¹pi dopasowanie

            onlystring2=$( perl -wpe 's!.*?(".*?")!$1!sg' <(echo "$linia2") )
              onlystring2=$( perl -wpe 's!(".*").*!$1!sg' <(echo "$onlystring2") )
              onlystring2=$( sed 's/[^"]*//' <(echo "$onlystring2") )


              if [[ "$liniastring" != "$liniastring2" || "$onlystring" != "$onlystring2" ]] ; then
                      echo "$i"
              fi
done

for (( i = $ilosc+1; $i <=$ilosc2-1; i++ )) ; do
      echo "$i"
done

#£ukasz Wroñski