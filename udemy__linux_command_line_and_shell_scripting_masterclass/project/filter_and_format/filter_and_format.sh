#!/bin/bash

filter_and_format() {
  log "Starting filter and format report at $(date +'%Y_%m_%d-%H_%M_%S')"

  awk '
    BEGIN {
      FS = ",";
      print "-------------------------------------";
      printf "%-20s %-6s\n", "User", "Total";
      print "-------------------------------------";
    }

    ( $2 >= 80000 ) {
      printf "%-20s %-6s\n", $1, $2;
    }
    ' "${filter_and_format_input_csv}" | (sed -u 3q; sort -k 1) > "${filter_and_format_output_rpt}"

    # sed is only going to read the first 3 lines (and output that to STDOUT)
    # 	and then sort is going to read the rest of the lines and sort those
    #	lines (and output that to STDOUT) and all the output to STDOUT will
    #	be redirected to a file.
  log "Ended filter and format report at $(date +'%Y_%m_%d-%H_%M_%S')"
}
