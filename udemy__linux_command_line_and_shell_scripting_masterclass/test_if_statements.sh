#!/bin/bash

<< "##EXAMPLE_1"
for (( i=1; i <= 10; i += 1 )); do
  if [[ $i -eq 2 ]]; then
    echo 'equal to 2'
  elif [[ $i -gt 5 ]]; then
    echo 'greater than 5'
  else
    echo 'not equal to 2 nor greater than 5'
  fi
done
##EXAMPLE_1

<< "##TEST_SINGLE_PARENTHESES"
if ( grep 'iwterry' /etc/passwd ); then
  echo 'User id found'
else
  echo 'User id not found'
fi

##TEST_SINGLE_PARENTHESES

<< "##TEST_DOUBLE_PARENTHESES"
var1=100
var2=20

if (( var2 += 100,  var1 > var2 )); then
  echo 'var1 > var2'
else
  echo 'var1 <= var2'
fi
##TEST_DOUBLE_PARENTHESES

<< "##TEST_SINGLE_BRACKETS"
if [ 1 -lt  2 ]; then
  echo '1 < 2'
fi
##TEST_SINGLE_BRACKETS

#<< "##TEST_DOUBLE_BRACKETS"
if [[ 23  < 3 ]]; then
  echo '1 < 2'
fi
##TEST_DOUBLE_BRACKETS

