#!/bin/bash

# read a file name from the command-line arg $1
file_name=${1}
echo "file_name: ${1}"


<< "##FILE_LOOP_1"
while read line; do
  echo "line: ${line}"

done < "${file_name}" | head -n 20
##FILE_LOOP_1

<< "##FILE_LOOP_2"
head -n 20 "${file_name}" | while read line; do
  echo "line: ${line}"
done
##FILE_LOOP_2

<< "##FILE_LOOP_3"
head -n 20 "${file_name}" | while read line; do
  echo "line: ${line}"

  IFS="," # assuming the input file is a csv file

  for field in $line; do
    echo "field: ${field}"
  done
done
##FILE_LOOP_3

