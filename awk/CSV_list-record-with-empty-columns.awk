# Program to display lines where a specific column meets a criteria
# 
# Usage: 
#        $awk -f CSV_list-record-with-empty-columns.awk input_file.csv
#
# Author: @mskadu (Created 13/06/2014)
#
BEGIN {
	FS="|" #this is the field seperator
}
	
# Process only lines where col 16 is empty
# Could be just as easily
#     $16 ~ /email/  {
# See: https://www.gnu.org/software/gawk/manual/html_node/Expression-Patterns.html
#
$16=="" { 
	# Display the whole record as-is
	# print	
	
	# Display specific bits of the record using C-style printf
	printf "Field 16 Empty> Record No. %d > First Field Value is %d\n", NR, $1
}

