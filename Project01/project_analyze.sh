#!/bin/bash

countFileTypes(){

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

}
 
#function to put every line containing #TODO in a todo.log
todoLog(){

  #check if todo.log already exists
  #delete if it already exists, and create new file
  if [ -f ~/CS1XA3/Project01/todo.log ]; then
    rm ~/CS1XA3/Project01/todo.log
  fi
    touch ~/CS1XA3/Project01/todo.log
  var=$(grep -rw "#TODO" --exclude="project_analyze.sh" --no-filename  ~/CS1XA3)
  echo $var >> ~/CS1XA3/Project01/todo.log
}

#function to delete files with exact duplicate contents
customFeature(){

#interate through all files in directory and compare contents
  for filename in `find ~/CS1XA3 -type f`; do
    if [ -e "$filename" ]; then
      var=$(cat $filename)
      for filename2 in `find ~/CS1XA3 -type f`; do
        var2=$(cat $filename2)
        if [ "$filename" != "$filename2" ]; then
          if [ "$var" = "$var2" ]; then
	    #delete file is contents are same
            rm "$filename2"
            echo "Removed $filename2"
          fi
        fi
      done
    fi
  done

}


#prompt for script input
echo "What do you want to do?"
select yn in "Count" "TODOlog" "CustomFeature" "Exit"; do
    case $yn in
        Count ) echo "Count for CS1XA3: "; countFileTypes; break;;
        TODOlog ) echo "todo.log updated"; todoLog; break;;
	CustomFeature ) echo "Removing files with duplicate contents"; customFeature; break;;
        Exit ) exit;;
    esac
done
