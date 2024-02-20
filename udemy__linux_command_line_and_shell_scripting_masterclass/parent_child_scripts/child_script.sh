#!/bin/bash

echo "######## child script execution begins #######"
echo "\$0=${0}"

echo ${var2_from_parent_script}

var2_from_parent_script="var2 from parent script changed in child script"
echo ${var2_from_parent_script}

var_from_child_script="Hello, this var from child script"
echo "####### child script execution ends ########"
exit 0 
