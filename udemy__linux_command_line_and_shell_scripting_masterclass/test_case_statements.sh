#!/bin/bash

<< "##EXAMPLE_1"
usage() {
  echo "Valid options are:"
  echo "1 - Daily"
  echo "2 - Weekly"
  echo "3 - Monthly"
}

echo "What is the schedule for running the program?"

usage

read -p "Choose a number (1,2,3) for your choice of schedule: " schedule

case ${schedule} in
  1)
    echo "Run program daily"
  ;;
  2)
    echo "Run program weekly"
  ;;
  3)
    echo "Run program monthly"
  ;;
  *)
    usage
  ;;
esac 
##EXAMPLE_1

#<< "##EXAMPLE_2"
color='blue'
case $color in
  red) echo 'Red is good color' ;;
  green) echo 'Green is a fine color' ;;
  blue) echo 'Blue is nice' ;;
  *) echo 'Whatever color you like will suit you well' ;;
esac
##EXAMPLE_2
