#!/bin/bash
# Script to compare contents of two files containing list of files
# List of missing files is written to STDERR
#
# Usage:
#   sh compare_files.sh 2>file_difference.log
#
# Author: Mayuresh Kadu (15/09/2015)
#
COMPARE_FROM=all_data-working-archive-sorted.lst
COMPARE_WITH=all_data-andover-sorted.lst

echo "Starting"
echo "List of files to compare is in: $COMPARE_WITH"
echo "List of files to compare with is: $COMPARE_FROM"

while IFS= read -r this_file
do
	this_file_basename=`basename $this_file` #get only the filename
 	echo -ne "Processing: $this_file_basename \033[0K\r"
	grep -q $this_file_basename $COMPARE_WITH
	if [ $? -eq 1 ]
	then
		echo "Missing: $this_file" 1>&2;
	fi
done < "$COMPARE_FROM"

echo "Finished"
