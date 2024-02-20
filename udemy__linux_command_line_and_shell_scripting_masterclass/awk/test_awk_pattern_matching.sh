#!/bin/bash

<< "##MATCH_PATTERN"
# $0 within awk means the whole line

# we are going to print the second column (or field) of the lines that match regular expression /C[ah]/
awk '
	BEGIN { FS="," }
	$0 ~/C[ah]/ { print $2 }
' $1
##MATCH_PATTERN

<< "##NOT_MATCH_PATTERN"
# $0 within awk means the whole line

# we are going to print the second column (or field) of the lines that do not  match regular expression /C[ah]/
awk '
	BEGIN { FS="," }
	$0 !~/C[ah]/ { print $2 }
' $1
##NOT_MATCH_PATTERN

<< "##MATCH_PATTERN_BEGINS_WITH"
# we are going to print the second column (or field) of the lines where the second column  match regular expression /^T/

awk '
	BEGIN { FS="," }
	$2 ~/^T/ { print $2 }
' $1
##MATCH_PATTERN_BEGINS_WITH

<< "##MATCH_PATTERN_NUMBER"
# we are going to print the second column (or field) of the lines where the first column match regular expression /101/

awk '
	BEGIN { FS="," }
	$1 ~/101/ { print $2 }
' $1
##MATCH_PATTERN_NUMBER

<< "##MATCH_PATTERN_BEGIN_WITH_DIFFERENT_PARTICULAR_CHARACTER"
# we are going to print the second column (or field) of the lines where the second column match regular expression /^C|^T]/

awk '
	BEGIN { FS="," }
	($2 ~/^C|^T/) { print $2 }
' $1
##MATCH_PATTERN_BEGIN_WITH_DIFFERENT_PARTICULAR_CHARACTER


<< "##MATCH_PATTERN_USING_&&"
awk -F "," '($1 < 106 && $0 ~/officer$/) { print $1, $2 }' $1
##MATCH_PATTERN_USING_&&

<< "##GSUB"
# gsub usage: gsub(/<pattern-to-search-for>/, <replacement-string-when-match-found>, <string-to-operate-on>)

awk '{ gsub(/,/, ":", $0); print $0 }' $1

# for each line
#	- replace every comma (/,/) found with a colon (":") in the record ($0)
#	- print that record

# NOTE: input file is not modified
##GSUB
