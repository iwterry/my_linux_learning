#!/bin/bash

echo "###### sourced script execution begins ######"
echo "\$0=${0}"

var_from_sourced_script="Hello, I am var from the sourced script"

func_from_sourced_script() {
  echo "### func from sourced script begins ###"
  echo ${var_from_sourced_script}
  echo "### func from sourced script ends ###" 
}

echo ${var_from_parent_script}
var_from_parent_script="var from parent script changed in sourced script"
echo ${var_from_parent_script}

echo ${var2_from_parent_script}
var2_from_parent_script="var2 from parent script changed in sourced script"
echo ${var2_from_parent_script}
echo "##### sourced script execution ends ######"
