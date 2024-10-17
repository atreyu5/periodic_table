#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

MAIN_MENU()
{
  if [[ $1 ]] 
   then
    #CHECK IF NUMBER
    if [[ $1 =~ ^[0-9]+$ ]] 
     then
       echo -e "\n$1 IS A NUMBER"
    fi
    #CHECK IF A SYMBOL
    #CHECK IF A NAME
    #OTHERWISE, REQUEST INPUT
   else
    echo -e "Please provide an element as an argument."
  fi
}

MAIN_MENU $1