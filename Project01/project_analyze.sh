#!/bin/bash
echo "What do you want to do?"
select yn in "Count" "Exit"; do
    case $yn in
        Count ) echo "Count for CS1XA3: "; break;;
        Exit ) exit;;
    esac
done
  #find number of html files
  numHtml=$(find ~/CS1XA3 -iname "*.html" -type f| wc -l)
  echo "HTML: $numHtml"

  #find number of javascript files
  numJs=$(find ~/CS1XA3 -iname "*.js" -type f| wc -l)
  echo "JavaScript: $numJs"

  #find number of css files
  numCss=$(find ~/CS1XA3 -iname "*.js" -type f| wc -l)
  echo "CSS: $numCss"

  #find number of python files
  numPython=$(find ~/CS1XA3 -iname "*.py" -type f| wc -l)
  echo "Python: $numPython"

  #find number of haskell files
  numHaskell=$(find ~/CS1XA3 -iname "*.hs" -type f| wc -l)
  echo "Haskell: $numHaskell"

  #find number of bash scripts
  numBash=$(find ~/CS1XA3 -iname "*.sh" -type f| wc -l)
  echo "Bash Scripts: $numBash"

