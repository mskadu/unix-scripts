# Sample script to display total/ sub-totals
#
# Usage:
#        awk -f CSV_print_grouped_totals.awk input_file.csv
#
# Useful link to Awk's built-in variables
# http://www.math.utah.edu/docs/info/gawk_11.html
# 
# Author: @mskadu (Created 13/06/2014)
#
BEGIN {
	FS="|"	# pipe is the field seperator
}

# As an example process only certain kinds of records
# In this case only those where field 7 starts with upper case text
$7 ~ /^[A-Z].*/ {

	record_type = substr( $7, 1, 2) #use first two characters to work out a unique record type
	freq[ record_type ]++ 		#keep count of how many we've got
}

END {
	# Calculate subtotals and we have FNR giving us total record count anyway.
	sub_total = 0
	for ( type in freq ) {
		printf "Record Type=%s,\tRecord Count=%d\n", type, freq[type]
		sub_total += freq[type]
	}

	printf "Sub Total=%d\n", sub_total
	printf "Total Records=%d\n", FNR
}