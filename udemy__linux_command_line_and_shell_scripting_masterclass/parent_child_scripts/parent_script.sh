#!/bin/bash


var2_from_parent_script="Hello, this var2 from parent script"
echo ${var2_from_parent_script}

export  var2_from_parent_script
$(dirname "${0}")/child_script.sh
echo ${var2_from_parent_script}

echo

var_from_parent_script="Hello, this is var from parent script"
echo ${var_from_parent_script}
source $(dirname "${0}")/source_script.sh
echo ${var_from_parent_script}
echo ${var2_from_parent_script}

echo

echo ${var_from_sourced_script}
var_from_sourced_script="var from sourced script changed in parent script"
echo ${var_from_sourced_script}
func_from_sourced_script



exit 0
