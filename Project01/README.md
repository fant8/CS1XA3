Script Input:
When the user runs the script, they'll first be prompted with two options to either 1) Count or 2) Exit.
If the user enters 1, the rest of the script will run and output the number of files. Otherwise, if the
user enters 2, the script will terminate and exit. If the user does not enter of these two options, they'll
be prompted again. 

<<<<<<< HEAD
File Type Count:
For each type of file, the directory gets searched for files ending in the appropriate extention using find. 
This gets piped into a variable and outputted with the corresponding message. 
=======
After adding the TODO Log and custom feature to the script in Part 2, the user now has the following options:
1) Count
2) TODOLog
3) CustomFeature
4) Exit
Each feature is now a function that is called as part of the user input. 

File Type Count:
For each type of file, the directory gets searched for files ending in the appropriate extention using find. 
This gets piped into a variable and outputted with the corresponding message. 

TODO Log
First checks the directory to see if there is already an existing todo.log file. If it already exists, delete it.
Grep searches for lines containing "#TODO" in the directory as a whole word, and directs this output into
the todo.log file. 

Custom Feature (Deleting files with duplicate contents):
Using two for loops and the find command (to distinguish the files in the directory), the feature iterates through
each file in the directory. A variable is used to store the contents of the current file in each for loop. 
If these contents are the same and the names of the files are not the same, one file gets deleted. 

