#!/bin/bash

TYTUL="Generator MD5"

SELECTED_TYPE=$(zenity --title="$TYTUL" --list --text "Wybierz co chcesz zrobic:" \
    --radiolist \
    --column "Select" \
    --column "Type" \
    TRUE ZakodujTekst FALSE ZakodujPlik);

case $SELECTED_TYPE in
    "ZakodujTekst")
        TEXT_PHRASE=$(zenity --title="$TYTUL" --text "Wpisz tekst" --width="150" --height="100" --entry)
        if test -n "$TEXT_PHRASE";
        then
        HASH_MD5=$(echo -n $TEXT_PHRASE | md5sum | cut -d ' ' -f1)
        zenity --info --title="$TITLE" --text="$HASH_MD5"
        else
            zenity --error --title="$TITLE" --text="Nic nie zostalo wpisane" --width="150" --height="100"
        fi
        ;;
    "ZakodujPlik")
        FILE=$(zenity --file-selection --title="Wybierz plik")
        if test -e "$FILE";
        then
            HASH_MD5=$(md5sum "$FILE" | cut -d ' ' -f1)
            zenity --info --title="$TYTUL" --text="$HASH_MD5"
        else
            zenity --error --title="$TYTUL" --text="PLik nie znaleziony" --width="150" --height="100"
        fi
        ;;
        *)
        zenity --error --title="$TYTUL" --text="Wybierz opcje" --width="150" --height="100"
        ;;
esac
