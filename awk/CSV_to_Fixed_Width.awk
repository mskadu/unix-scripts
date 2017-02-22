# AWK Script to convert a CSV file into fixed width
#
# usage: 
#         awk -f CSV_to_Fixed_Width.awk input_file.csv > output_fixed_width_file.dat
#
# Author: @mskadu (Created 18/08/2014)
 
# Block below executes once for each input file
BEGIN {
	# This is the field seperator
	FS=","
 
	# List of field widths of the output file
	widthlist = "1 30 15 30 30 30 30 30 18 30 8 8"
 
	# Convert to an array
	split( widthlist, widths, " " )
}
 
#Block below executes for each record
{
	for(i=1; i<=NF; i++) { 
		
		if (i==14) {	
			#Do something specific with the 14th field
			printf("alternate_value") 
		}
		else 
			printf("%-*s", widths[i], $i) # print as-is
	}
	printf("\n")
}