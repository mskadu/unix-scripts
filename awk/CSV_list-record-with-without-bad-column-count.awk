# Program to process CSV file and display lines which do or 
# do not not have expected number of columns 
# 
# Author: @mskadu (Created 10/07/2014)
#
BEGIN {
	FS="|" #this is the field seperator
}

(NF != 54)  { #change this print the lines that DO match
	print
}
	