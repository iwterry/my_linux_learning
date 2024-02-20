#!/bin/bash

# About: this program is to compare $@, $*, "$@", and "$*" in order to better understand word splitting
# sample arguments to the program: "one two" "three_four" "five:six"
<<"MY_ANALYSIS"
$* and $@ are the same when not enclosed in quotation marks
	- each positional parameter is expanded into a separate word,
	and each word is subject to further splitting based on 
	the value of the shell variable IFS
		- if IFS is unset, spaces split the word into further words
			- example with "one two" "three_four" "five:six" given as arguments
				- "one two" would be word one and this would be split 
					- "one"
					- "two"
				- "three_four" would be word two and would not be further split
				- "five:six" would be word three and would not be further split
		- if IFS is null, no split occurs on the word
			- example with "one two" "three_four" "five:six" given as arguments
				- "one two" would be word one and would not be further split
				- "three_four" would be word two and would not be further split
				- "five:six" would be word three and would not be further split

		- otherwise, the first character of IFS is used to split the
		word into further words
			- example with "one two" "three_four" "five:six" given as arguments and setting IFS="_:"
				- "one two" would be word one and this would not be further split
				- "three_four" would be word two and would be further split:
					- "three"
					- "four"
				- "five:six" would be word three and would not be further split (because ":" is not
				the first character in IFS; ":" is the second character in IFS.

- $* and $@ are different when enclosed in double quotation marks
	- "$*" ($* enclosed in double quotation marks)
		- positional parameters are expanded into a single word,
		consisting of the positional parameters joined together
		based on the value of the shell variable IFS
			- if IFS is unset, join positional parameters by a space
				- example: <value-of-$1> <value-of-$2> <value-of-$3>
				- example: "one two three_four five:six" for the arguments "one two" "three_four" "five:six"
			- if IFS is null, join positional parameters together without
			any separation between the positional parameters
				- example: <value-of-$1><value-of-$2><value-of-$3>
				- example: "one twothree_fourfive:six" for the arguments "one two" "three_four" "five:six"
			- otherwise, join the positional parameters together using the first character of IFS
				- example: <value-of-$1><first-character-IFS><value-of-$2><first-character-IFS><value-of-$3>
				- example: "one two_three_four_five:six" for the arguments "one two" "three_four" "five:six"  and with setting IFS="_:"
	- "$@" ($@ enclosed in double quotation marks)
		- each positional parameter is expanded into a separate word,
		but each word is not further split regardless of the value of IFS
		- example with "one two" "three_four" "five:six" given as arguments:
			- "one two" would be one word one and would not be further split
			- "three_four" would be word two and would not be further split
			- "five:six" would be word three and would not be further split
MY_ANALYSIS




echo '###### IFS unset #####'
unset IFS
echo '----- "$@" -----'
for item in "$@"; do echo "item: $item"; done
echo '----- $@ ------'
for item in $@; do echo "item: $item"; done
echo '----- "$*" -----'
for item in "$*"; do echo "item: $item"; done
echo '----- $* -----'
for item in $*; do echo "item: $item"; done

echo

echo '###### IFS set to null #######'
IFS=
echo '----- "$@" -----'
for item in "$@"; do echo "item: $item"; done
echo '----- $@ ------'
for item in $@; do echo "item: $item"; done
echo '----- "$*" -----'
for item in "$*"; do echo "item: $item"; done
echo '----- $* -----'
for item in $*; do echo "item: $item"; done

echo

echo '###### IFS set to _: #######'
IFS="_;"
echo '----- "$@" -----'
for item in "$@"; do echo "item: $item"; done
echo '----- $@ ------'
for item in $@; do echo "item: $item"; done
echo '----- "$*" -----'
for item in "$*"; do echo "item: $item"; done
echo '----- $* -----'
for item in $*; do echo "item: $item"; done

unset IFS
