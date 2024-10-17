#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN_MENU()
{
  if [[ $1 ]] 
   then
      #CHECK IF NOT A NUMBER
      if ! [[ $1 =~ ^[0-9]+$ ]] 
        then
          I_LENGTH=${#1}
          #CHECK IF A SYMBOL
          if (( $I_LENGTH <= 2 ))
            then
              RESULT_ATOMIC_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
            #ELSE, CHECK IF A NAME
            else
              RESULT_ATOMIC_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
            fi
        #ELSE, IF A NUMBER:
        else 
          RESULT_ATOMIC_NUM=$1 
        fi        
        
      #CHECK FOR A RESULT IN DB:
      if [[ -z $RESULT_ATOMIC_NUM ]]
       then 
        RESULT_ATOMIC_NUM=0
      fi

      RESULT_ELEMENT=$($PSQL "SELECT e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements AS e INNER JOIN properties AS p ON e.atomic_number=p.atomic_number INNER JOIN types AS t ON p.type_id=t.type_id WHERE e.atomic_number = $RESULT_ATOMIC_NUM")
      if [[ -z $RESULT_ELEMENT ]]
        then
          echo -e "I could not find that element in the database."
        else
         IFS='|' read -r -a ELEMENT <<< "$RESULT_ELEMENT"
         echo -e "The element with atomic number $1 is ${ELEMENT[1]} (${ELEMENT[0]}). It's a ${ELEMENT[5]}, with a mass of ${ELEMENT[2]} amu. Hydrogen has a melting point of ${ELEMENT[3]} celsius and a boiling point of ${ELEMENT[4]} celsius."       
      fi 
    #OTHERWISE, REQUEST INPUT
   else
    echo -e "Please provide an element as an argument."
  fi
}

MAIN_MENU $1