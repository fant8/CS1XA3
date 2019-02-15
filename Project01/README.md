Script Input:
When the user runs the script, they'll first be prompted with two options to either 1) Count or 2) Exit.
If the user enters 1, the rest of the script will run and output the number of files. Otherwise, if the
user enters 2, the script will terminate and exit. If the user does not enter of these two options, they'll
be prompted again. 

File Type Count:
For each type of file, the directory gets searched for files ending in the appropriate extention using find. 
This gets piped into a variable and outputted with the corresponding message. 
