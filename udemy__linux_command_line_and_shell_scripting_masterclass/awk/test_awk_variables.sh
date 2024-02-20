#!/bin/bash

<< "COMMON_AWK_VARIABLES"
ARGC = number of arguments given  + 1 (this is because the word "awk" is considered the first argument)
ARGV = array storing the arguments given to awk
	- NOTE: ARGV[0] = 'awk'
	- NOTE: the arguments you pass to awk  will start at index 1
FNR = number of records processed in file
	- NOTE: this is incremented as each record is processed in a file, but it is reset for each input file
NR = total number of records processed
	- NOTE: this is incremented as each record is processed and does not reset for each input file
FS = field separator (for input file)
	- NOTE: the default value is a space
	- NOTE: instead of explicity assigning a value to FS, you can use the "-F" option on awk to provide the file separator
OFS = output field separator (the delimeter for the output file
	- NOTE: the default value is a space
NF = number of fields (for input file)
ORS = output record separator (this is how each record will be separated from each other in the output file)
	- NOTE: the default value is a new line
RS = record separator (for input file)
	- NOTE: the deffault value is a new line
ENVIRON = array that index by the name of environment variables
	- EXAMPLE: ENVIRON["USER"] will give the value of the USER environment variable
FILENAME = the name (with path used) of input file being processed by awk
COMMON_AWK_VARIABLES

<< "##ARGC_AND_ARGV_USAGE"

awk 'BEGIN {
	print "Number of args = " ARGC;
	print "ARGV[0] = " ARGV[0];
	print "ARGV[1] = " ARGV[1];
	print "ARGV[2] = " ARGV[2];
}' one two
##ARGC_AND_ARGV_USAGE


<< "##RECORD_NUM_EACH_FILE"
awk '
	BEGIN { FS=","; OFS=","; print "HEADER" }
	{ print FNR, $1, $2 }
	END { print "FOOTER"  }
' $1 $2
##RECORD_NUM_EACH_FILE


<< "##RECORD_NUM_ALL_FILES"
awk '
	BEGIN { FS=","; OFS=","; print "HEADER" }
	{ print NR, $1, $2 }
	END { print "FOOTER"  }
' $1 $2
##RECORD_NUM_ALL_FILES


<< "##PRINT_LINES_WHERE_FS_AND_OFS_DIFFER"
awk '
	BEGIN { FS=","; OFS="|"; print "HEADER" }
	{ print $1, $2  }
	END { print "FOOTER" }
' $1
##PRINT_LINES_WHERE_FS_AND_OFS_DIFFER


<< "##PRINT_LINES_WITHOUT_USING_FS"
# instead of specifying FS, we will use -F option to tell awk about how the input file is deliminted
awk -F "," '
	BEGIN { OFS="|"; print "HEADER" }
	{ print $1, $2  }
	END { print "FOOTER" }
' $1
##PRINT_LINES_WITHOUT_USING_FS


<< "##PRINT_NUM_FIELDS_EACH_LINE"
awk -F "," '
	BEGIN { print "HEADER" }
	{ print NF }
	END { print "FOOTER" }

' $1
##PRINT_NUM_FIELDS_EACH_LINE


<< "##PRINT_NUM_FIELDS_ONE_LINE"
# we are going to print NF when NR is 2
awk -F "," '
	BEGIN { print "HEADER" }
	(NR==2) { print NF }
	END { print "FOOTER" }

' $1
##PRINT_NUM_FIELDS_ONE_LINE


<< "##OUTPUT_RECORD_SEPARATOR"
# we are going to separate each record in the output with a "###" instead of new line
awk -F "," '
	BEGIN { OFS="|"; ORS="###"; print "HEADER" }
	{ print $1, $2 }
	END { print "FOOTER" }
' $1
##OUTPUT_RECORD_SEPARATOR


<< "##PRINT_FILENAME_ONE_LINE_PER_FILE"

# we are going to print NF when NR is 2
awk -F "," '
	BEGIN { print "HEADER" }
	(FNR==2) { print "filename passed to awk: " FILENAME }
	END { print "FOOTER" }

' $1 $2
##PRINT_FILENAME_ONE_LINE_PER_FILE


<< "##PRINT_ENVIRONMENT_VARIABLES"
awk 'BEGIN {
	OFS=" --- ";
	print "HOME: " ENVIRON["HOME"], "USER: " ENVIRON["USER"]
}'
##PRINT_ENVIRONMENT_VARIABLES
