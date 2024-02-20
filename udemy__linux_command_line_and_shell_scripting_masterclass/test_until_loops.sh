#!/bin/bash

#<< "##EXAMPLE_1"
i=0
until [[ $i -ge  10 ]]; do
  echo $i 

  (( i += 1 ))
done	
##EXAMPLE_1
