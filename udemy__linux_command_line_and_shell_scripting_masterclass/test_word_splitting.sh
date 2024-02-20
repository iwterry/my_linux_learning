#!/bin/bash

# each character in the value for IFS variable is treated as a delimeter.

# NOTE: double quotes surrounding a variable prevents word splitting.

<<"##IFS_UNSET"
unset IFS
echo "IFS: '${IFS}'"
var="   one::two : three  :  ;  :  four   five   "
echo "example: '${var}'"
for item in $var; do echo "item: '${item}'"; done

# comments:
# 	- if  IFS  is  unset or has its default value (which is a space, tab, and
#	new line characters), the whitespace IFS characters at the beginning and
#	end of the variable var are ignored; in addition, a sequence of IFS 
#	whitespace characters is considered a single delimeter.
##IFS_UNSET

<<"##IFS_:;"
IFS=":;"
echo "IFS: '${IFS}'"
var="   one::two : three  :  ;  :  four   five   "
echo "example: '${var}'"
for item in $var; do echo "item: '${item}'"; done
##IFS_:;

<<"##IFS_:;<space>"
IFS=":; "
echo "IFS: '${IFS}'"
var="   one::two : three  :  ;  :  four   five   "
echo "example: '${var}'"
for item in $var; do echo "item: '${item}'"; done

# comments:
# 	- if IFS consists of both the whitespace characters and non-whitespace
#	characters, then a non-whitespace IFS character adjacent to one or more
#	IFS whitespace characters is considered a single delimeter.
#	- a sequence of IFS whitespace characters is considered a single delimeter.
#	- the sequence of whitespace IFS characters at the beginning and
#	 end of the variable var are ignored.

##IFS_:;<space>

<<"##IFS_:;<space>_NON_WHITESPACE_DELIMETER_BEFORE_AND_AFTER"
IFS=":; "
echo "IFS: '${IFS}'"
var=";:;one::two : three  :  ;  :  four;:;"
echo "example: '${var}'"
for item in $var; do echo "item: '${item}'"; done

# comments:
# 	- if IFS consists of both the whitespace characters and non-whitespace
#	characters, then a non-whitespace IFS character adjacent to one or more
#	IFS whitespace characters is considered a single delimeter.
#	- if the variable var starts with a non-whitespace IFS character
#	(or starts with a sequence of whitespace IFS characters followed by a
#	non-whitespace IFS character), a split will occur before this first sequence
#	of one or more IFS characters, and this is why the first iteration of
#	the for loop consists of the variable "item" with no characters.
#	- if the variable var ends with a non-whitespace IFS character
#	(or ends with a non-whitespace IFS character adjacent to one or
#	whitespace IFS characters), no split will occur after this final
#	sequence of one or more IFS characters.
#
##IFS_:;<space>_NON_WHITESPACE_DELIMETER_BEFORE_AND_AFTER
