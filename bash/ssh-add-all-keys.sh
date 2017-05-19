#!/usr/bin/env bash

# Control if messages are to be shown
DEBUG_FLAG=1 # 0==Off and 1=On

script_name=$(basename "$0")
Log() {
	log_message="[$script_name] $1"
	test $DEBUG_FLAG -eq 1 && echo "$log_message"
}

ssh_Add_All_Keys() {
  Log "Hi there, here's a list of your existing SSH keys (just in case)"
  ssh-add -l

  Log "Refreshing your SSH keys (RSA-only. All under ~/.ssh/ )"
  Log "Expect to be asked for relevant passwords"
  ssh-add -D && find ~ -name id_rsa -exec ssh-add {} \;

  Log "Done. And here's what it looks like after"
  ssh-add -l

  Log "Finished"
}

ssh_Add_All_Keys
