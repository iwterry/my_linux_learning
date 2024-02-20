#!/bin/bash

search_and_replace() {
  log "Starting search and replace at $(date +'%Y_%m_%d-%H_%M_%S')"
  sed -E "s/([[:digit:]]{3})-([[:digit:]]{3}-[[:digit:]]{4})/(\1)\2/" \
	  "${search_and_replace_input_csv}" > "${search_and_replace_output_rpt}"
  # NOTE: the "-E" is for using extended regular expression instead of basic regular expression.
  #	- Without the "-E", the parentheses between the first and second forward slashes would need to be escaped by backslashes.
  log "Ended search and replace at $(date +'%Y_%m_%d-%H_%M_%S')"
}
