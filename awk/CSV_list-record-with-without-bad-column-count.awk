# Program to process CSV file and display lines which do or 
# do not not have expected number of columns 
#
# note: the command line equivalent for this would be as follows:
# awk -F "|" '(NF != 54) { print }'
# 
# Author: @mskadu (Created 10/07/2014)
#
BEGIN {
	FS="|" #this is the field seperator
}

(NF != 54)  { #change this print the lines that DO match
	print # or replace with whatever else you want to do with these lines
}
	
