#!/bin/bash

demo_usage() {
  echo -e "usage: ${0} -a <arg1> -b <arg2> -c csv_file txt_file"
  echo -e "\t -a needs an input argument: arg1"
  echo -e "\t -b needs an input argument: arg2"
  echo -e "\t -c needs no argument"
  echo -e "\t csv_file is the name of the input csv file"
  echo -e "\t txt_file is the name of the input txt file"
}

<< SOME_INFO_ABOUT_GETOPTS
- getargs is a bash shell-builtin command

- getargs uses a couple of different shell variables:
	- OPTIND
		- the index of the next argument to be processed (while is processing the current option and its possible argument)
		- initialized to 1
	- OPTARG
		- the argument of an option when an option requires an argument
	- OPTERR
		- if value is 0, no diagnostic message is given when error occurs
		- if value is 1, diagnostic message can be given when error occurs in nonsilent mode
		- default value is 1 

SOME_INFO_ABOUT_GETOPTS

#<< "##UNDERSTAND_GETOPTS"
if [[ ${#} -ne 0 ]]; then
  num_iterations=0
  
  echo -e "# of arguments given: ${#}\n"
 
  echo "before argument shifting"
  indx=0
  for arg in  "${@}"; do
    (( indx += 1 ))
    echo "index ${indx}: ${arg}"
  done

  echo

  while getopts "a:b:c" opt_name; do
    echo "# of iterations: $((num_iterations += 1))"
    echo "OPTIND: ${OPTIND}"
    echo "opt_name: ${opt_name}"
    echo "OPTARG: ${OPTARG}"
  done

  # explanation of "a:b:c"
  # 	- "a:b:c" is what is called an option string and it says we have three options: "a", "b", "c"
  # 	- option "a" requires an argument to be given because it is followed by a colon
  #	- option "b" requires an argument to be given because it is followed by a colon
  # 	- option "c" does not have an argument because it is not followed by a colon


  # possible values of OPTARG
  #	- the argument of an option supplied by the user when an argument is required for a valid option
  # 	- no value when
  #		- there is no argument required for the option
  #		- an invalid option is given (such as "d") when in nonsilent mode
  #		- no argument is given but an argument is required for the option; this occurs in nonsilent mode
  #	- the option when
  #		- an invalid option is given (such as "d") when in silent mode
  #		- no argument is given but an argument is required for the option; this occurs in silent mode
  

  # possible values of opt_name
  #	- the option when a valid option is given with its argument if required
  #	- a question mark when 
  #		- an invalid option is given (such as "d")
  #		- no argument is given but an argument is required for the option; this is for nonsilent mode
  #	- a colon when
  #		- no argument is given but an argument is required for the option; this occurs in silent mode


  # getopts has two modes
  #	- nonsilent mode
  #	- silent mode
  #		- occurs when there is a colon in front of the option string (such as ":a:b:c")
  #		- no diagnostic messages are printed

  num_shifts=$(( OPTIND - 1 ))
  shift ${num_shifts}

  echo

  echo "after argument shifting"
  echo -e "# of arguments given: ${#}\n"
  
  indx=0
  for arg in  "${@}"; do
    (( indx += 1 ))
    echo "index ${indx}: ${arg}"
  done
fi
##UNDERSTAND_GETOPTS

<< "##USING_GETOPTS"
if [[ ${#} -ne 0 ]]; then

  while getopts "a:b:c" opt_name; do
    case ${opt_name} in
      a) opt_a_val=${OPTARG} ;;
      b) opt_b_val="true" ;;
      c) opt_c_val=${OPTARG} ;;
      ?) usage; exit 1 ;;
    esac 
    
  done

  num_shifts=$(( OPTIND - 1 ))
  shift ${num_shifts}

fi
##USING_GETOPTS
