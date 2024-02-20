#!/bin/bash

<< "##EXAMPLE_1"
num_array=( 1 2 3 4 5 )
for x in "${num_array[@]}"; do
  echo "x = $x"

done
##EXAMPLE_1


<< "##EXAMPLE_2"
num_array=( 1 2 3 4 5 )
for (( x=0; x < ${#num_array[@]}; x+=1 )); do
  echo "x=${x} => ${num_array[x]}"
done
##EXAMPLE_2

<< "##EXAMPLE_3"
for (( x=0; x < 10; x += 1 )); do
  if [[ x -lt  5 ]]; then
    continue
  fi

  echo $x

  if [[ x -eq 8 ]]; then
    break
  fi
done
##EXAMPLE_3
