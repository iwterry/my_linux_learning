#!/bin/bash

<< '##CREATING_FUNCTIONS_SNIPPET' 
function func1() {
  echo "hello from function func1()"
}

function func2 {
  echo "hello from function func2"
}

func3() {
  echo "hello from func3()"
}

func1
func2
func3
##CREATING_FUNCTIONS_SNIPPET

#<< "##EXAMPLE_2"
func4() {
  echo "func4 $1 $2"
  echo "first argument to func4: $1"
  echo "second argument to func4: $2"

  local local_var='local variable'
  global_var='global variable'
}

echo "global_var before invoking func4: $global_var"
func4 'hello' 'world'
echo "global_var after invoking func4: $global_var"
echo "local_var after invoking func4: ${local_var}"
echo "return value of func4 (is the exit status): $?"
##EXAMPLE_2


