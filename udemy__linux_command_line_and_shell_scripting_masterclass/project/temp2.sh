#!/bin/bash

awk '
	BEGIN {
		FS = ",";
		OFS = "\t";
		max_user_name_length = 0;
	}
	( $2 >= 80000 && $2 < 100000 ) {
		user_data[$1] = $2;

		if (max_user_name_length < length($1)) {
			max_user_name_length = length($1);
		}
	}
	END {

		print "--------------------------------";
		printf "%-*s%s%s\n", max_user_name_length, "User", OFS, "Total";
		print "--------------------------------";
		for (user_name in user_data) {
			printf "%-*s%s%d\n", max_user_name_length, user_name, OFS, user_data[user_name] | "sort";
		}
	}
' filter_and_format/input.csv
