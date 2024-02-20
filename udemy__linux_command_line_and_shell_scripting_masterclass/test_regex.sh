#!/bin/bash

# a regular expression is a sequence of characters that defines a search pattern for matching a string; the pattern will attempt to match any portion of the string (unless $ or ^ is used; where both are discussed later in this document)

# bash uses the =~ operator to test if a string matches a regular expression
#	- syntax: [[ str =~ regexp ]]
#	- syntax: [[ ! str =~ regexp ]]
#		- if the match was true then ! will make it false
#		- if the match was false then ! will make it true
#	- NOTE: POSIX extended regular expression is being used
#	- NOTE: all matches are case sensitive unless the shell option called nocasematch is enabled (by default, it is disabled)
#		- shopt -s nocasematch # to enable/set nocasematch
#		- shopt -u nocasematch # to disable/unset nocasematch

# if var_regexp stores the regexp, then using quotes ("${var_regexp}") will force the pattern to be interpreted as a string
#	- [[ "abcc" =~ "abc*" ]] || echo false
#	- var_regexp="abc*"; [[ "abcc" =~ ${var_regexp} ]] && echo true
#	- var_regexp="abc*"; [[ "abcc" =~ "${var_regexp}" ]] || echo false 


<< "##EXAMPLE_CASE_MATCHING"
my_reg_expr="abc"

echo "### regex=${my_reg_expr} ####"
shopt -s nocasematch
[[ "aBc" =~ ${my_reg_expr} ]] && echo true
shopt -u nocasematch
[[ "aBc" =~ ${my_reg_expr} ]] || echo false
##EXAMPLE_CASE_MATCHING

<< "##EXAMPLE_WITH_."
# the dot (.) matches only one single character
my_reg_expr="a.c"

echo "### regex=${my_reg_expr} ####"
[[ "textabctext" =~ ${my_reg_expr} ]] && echo true
[[ "ac" =~ ${my_reg_expr} ]] || echo false 
[[ ! "ac" =~ ${my_reg_expr} ]] && echo true

# NOTE: the "!" is the not operator; since the regular expression "a.c" does not match string "ac", the "!" will cause the false to become true

##EXAMPLE_WITH_.

<< "##EXAMPLE_WITH_*"
# the "*" match any character the directly precedes it

# the ".*" matches any number of characters including 0 characters
my_reg_expr="a.*c"

echo "### regex=${my_reg_expr} ####"
[[ "textabctext" =~ ${my_reg_expr} ]] && echo true
[[ "ac" =~ ${my_reg_expr} ]] &&  echo true 
[[ "aonetwothreec" =~ ${my_reg_expr} ]] && echo true

# the "c*" matches 0 or more number of c's
my_reg_expr="ac*"

echo "### regex=${my_reg_expr} ####"
[[ "textatext" =~ ${my_reg_expr} ]] && echo true
[[ "ac" =~ ${my_reg_expr} ]] &&  echo true 
[[ "acc" =~ ${my_reg_expr} ]] && echo true
##EXAMPLE_WITH_*

<< "##EXAMPLE_WITH_\s"
# the "\s" matches a space character
my_reg_expr="a\sc"

echo "### regex=${my_reg_expr} ####"
[[ "texta ctext" =~ ${my_reg_expr} ]] && echo true

##EXAMPLE_WITH_\s

#<< "##EXAMPLE_WITH_[]"
# the "[bBeM]" matches only "b", "B", "e", and "M"
my_reg_expr="a[BbeM]c"
echo "### regex=${my_reg_expr} ####"
[[ "textabctext" =~ ${my_reg_expr} ]] && echo true
[[ "aBc" =~ ${my_reg_expr} ]] && echo true
[[ "aMc" =~ ${my_reg_expr} ]] && echo true

# the "[C-Ek-m2-5]" matches only "C", "D", "E", "k", "l", "m", "2", "3", "4", and "5"
my_reg_expr="a[C-Fk-m2-5]c"
echo "### regex=${my_reg_expr} ####"
[[ "texta2ctext" =~ ${my_reg_expr} ]] && echo true
[[ "aCc" =~ ${my_reg_expr} ]] && echo true
[[ "alc" =~ ${my_reg_expr} ]] && echo true

# there are many defined characters classes, some of them are
#	- [:alpha:] for any alphabetical character
#	- [:digit:] for any numerical digit 0 through 9
#	- [:alnum:] for any alphabetical charactor or numerical digit
#	- [:space:] for a space character
#	- [:upper:] for any uppercase alphabetical character

my_reg_expr="a[[:alpha:]]c"
echo "### regex=${my_reg_expr} ####"
[[ "abc" =~ ${my_reg_expr} ]] && echo true
[[ "aBc" =~ ${my_reg_expr} ]] && echo true
[[ "aMc" =~ ${my_reg_expr} ]] && echo true

my_reg_expr="a[[:digit:]]c"
echo "### regex=${my_reg_expr} ####"
[[ "a0c" =~ ${my_reg_expr} ]] && echo true
[[ "a9c" =~ ${my_reg_expr} ]] && echo true
[[ "a5c" =~ ${my_reg_expr} ]] && echo true

my_reg_expr="a[[:alnum:]]c"
echo "### regex=${my_reg_expr} ####"
[[ "amc" =~ ${my_reg_expr} ]] && echo true
[[ "aBc" =~ ${my_reg_expr} ]] && echo true
[[ "a3c" =~ ${my_reg_expr} ]] && echo true

my_reg_expr="a[[:space:]]c"
echo "### regex=${my_reg_expr} ####"
[[ "a c" =~ ${my_reg_expr} ]] && echo true

my_reg_expr="a[[:upper:]]c"
echo "### regex=${my_reg_expr} ####"
[[ "aBc" =~ ${my_reg_expr} ]] && echo true
[[ "aZc" =~ ${my_reg_expr} ]] && echo true
[[ "abc" =~ ${my_reg_expr} ]] || echo false
[[ "a3c" =~ ${my_reg_expr} ]] || echo false
[[ "a c" =~ ${my_reg_expr} ]] || echo false
##EXAMPLE_WITH_[]

<< "##EXAMPLE_WITH_^_$"
# the "^a" matches any string starting with "a"
# the "c$" matches any string ending with "c"
my_reg_expr="^abc$"

echo "### regex=${my_reg_expr} ####"
[[ "textabctext" =~ ${my_reg_expr} ]] || echo false
[[ "abc" =~ ${my_reg_expr} ]] && echo true
##EXAMPLE_WITH_^_$


<< "##EXAMPLE_WITH_?"
# the "a?" means 0 or 1 "a"
# the "*b?" means 0 or 1 "b"
my_reg_expr="ab?c"

echo "### regex=${my_reg_expr} ####"
[[ "textabctext" =~ ${my_reg_expr} ]] && echo true
[[ "ac" =~ ${my_reg_expr} ]] && echo true
[[ "amc" =~ ${my_reg_expr} ]] || echo false
##EXAMPLE_WITH_?

<< "##EXAMPLE_WITH_{}"
# the "b{2}" matches exactly 2 b's
# the "b{2,}" matches 2 or more b's
# the "b{,2}" matches at least 2 b's (including none)
# the "b{2,4}" matches only 2, 3, or 4 b's

my_reg_expr="ab{2}c"
echo "### regex=${my_reg_expr} ####"
[[ "abc" =~ ${my_reg_expr} ]] || echo false
[[ "abbc" =~ ${my_reg_expr} ]] && echo true
[[ "abbbc" =~ ${my_reg_expr} ]] || echo false

my_reg_expr="ab{2,}c"
echo "### regex=${my_reg_expr} ####"
[[ "abc" =~ ${my_reg_expr} ]] || echo false
[[ "abbc" =~ ${my_reg_expr} ]] && echo true
[[ "abbbc" =~ ${my_reg_expr} ]] && echo true

my_reg_expr="ab{,3}c"
echo "### regex=${my_reg_expr} ####"
[[ "ac" =~ ${my_reg_expr} ]] && echo true
[[ "abbbc" =~ ${my_reg_expr} ]] && echo true
[[ "abbbbc" =~ ${my_reg_expr} ]] || echo false

my_reg_expr="ab{2,3}c"
echo "### regex=${my_reg_expr} ####"
[[ "abc" =~ ${my_reg_expr} ]] || echo false
[[ "abbc" =~ ${my_reg_expr} ]] && echo true
[[ "abbbc" =~ ${my_reg_expr} ]] && echo true
[[ "abbbbc" =~ ${my_reg_expr} ]] || echo false
##EXAMPLE_WITH_{}


