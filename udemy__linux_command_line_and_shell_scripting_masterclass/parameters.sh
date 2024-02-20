#!/bin/bash
<< '##PARAMETERS_SNIPPET'
  echo "Name of the script: $0"
  
  echo "Parameter #1: $1"
  echo "Parameter #2: $2"
  echo "Parameter #3: $3"

  echo "Total number of parameters: $#"

  echo "Total list of parameters: $@"
  
  echo "Process id of this script: $$"
##PARAMETERS_SNIPPET


<< '##READ_SINGLE_VARIABLE_SNIPPIT'
  echo -n 'Enter variable: '
  read var
  echo "variable is: $var"
##READ_SINGLE_VARIABLE_SNIPPIT


<< '##READ_MULTILINE_VARIABLE_SNIPPIT'
  echo -n 'Enter variables: '
  read var1 var2 var3
  echo "var1: $var1"
  echo "var2: $var2"
  echo "var3: $var3"
##READ_MULTILINE_VARIABLE_SNIPPIT


<< '##READ_WITH_PROMPT_SNIPPIT'
  read -p 'Enter variables: ' var1 var2 var3
  echo "var1: $var1"
  echo "var2: $var2"
  echo "var3: $var3"
##READ_WITH_PROMPT_SNIPPIT


<< '##READ_USING_S_OPTION_SNIPPIT'
  echo -n "Enter password: "
  read -s password
  echo -e "\npassword: $password"
##READ_USING_S_OPTION_SNIPPIT


<< '##READ_ARRAY_SNIPPET'
echo -n "Enter array: "
read -a  my_array
echo "0 index: ${my_array[0]} ---- 1 index: ${my_array[1]}"
##READ_ARRAY_SNIPPET


<< '##READ_ENTIRE_LINE_SNIPPET'
echo -n "Enter text: "
read text
echo "text: $text"
##READ_ENTIRE_LINE_SNIPPET


