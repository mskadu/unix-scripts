#!bin/bash

# Template Shell Script to connect to and execute commands on various hosts
# The list of hosts is contained in $MULTIHOSTEXEC_HOSTLIST_FILE
# Author: Mayuresh Kadu (Created: Dt 12/04/2010)
#
# Assumption: The same set of actions are to be repeated of each host
#
# TODO:
# 	- display error/info messages using logging functions
#		- display error message when the SSH to a host fails

MULTIHOSTEXEC_HOSTLIST_FILE=template-multihost-hosts.lst

# Parse hosts list file, ignoring any empty and comment lines
#
nHostListCount=`grep -v "^$\|#" $MULTIHOSTEXEC_HOSTLIST_FILE 2>/dev/null | wc -l`
arrHostList=`grep -v "^$\|#" $MULTIHOSTEXEC_HOSTLIST_FILE 2>/dev/null`


if [ ! -s $MULTIHOSTEXEC_HOSTLIST_FILE -o ! -r $MULTIHOSTEXEC_HOSTLIST_FILE -o $nHostListCount -eq 0 ]; then
	echo "Error: Cannot read host file or it is empty"
	exit 1
fi

echo "Found $nHostListCount hosts"
nHostIndex=0
for nHost in $arrHostList
do
	nHostIndex=`expr $nHostIndex + 1`
	echo "Processing [$nHostIndex of $nHostListCount] $nHost"
	# source: http://stackoverflow.com/questions/305035/how-to-use-ssh-to-run-shell-script-on-a-remote-machine
	ssh -q -T $nHost <<-'ENDSSH'

  ## Sample set of actions on the REMOTE host
  #
	strTarFileName="$(hostname -f)-data-$(date +%Y%m%d).tar.gz"
	echo "On REMOTE - Gathering data to $strTarFileName"
	tar czf /some/remote-folder/$strTarFileName /some/other/folder/data/*.dat # && ls -l /some/remote-folder/$strTarFileName
	test $? && echo "On REMOTE - Data gather complete"
	ENDSSH

	# Sample set of actions on LOCAL host
  strRemoteFileName="/some/remote-folder/*$(date +%Y%m%d).tar.gz"
	echo "On LOCAL - Downloading remote file $nHost:$strRemoteFileName $strRemoteFileName"
	scp -q $nHost:$strRemoteFileName .
	test $? && echo "On LOCAL - File download complete"
  #
  ## END of Sample set of actions
done
echo "All Done"
