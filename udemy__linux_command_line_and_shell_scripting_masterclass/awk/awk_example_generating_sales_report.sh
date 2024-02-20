#!/bin/bash

# I am using this function to organize the sales data so that I can use this function's output to help simplify when I am creating the different sales reports
summarize_sales_data() {
awk '
	BEGIN {
		FS="|";
		OFS="|";
	}
	(NR != 1) {
		col_2[$1] += $2;
		col_3[$1] += $3;
		col_4[$1] += $4;
		count[$1] += 1;
	}
	(NR == 1) {
		header_1=$1;
		header_2="Count";
		# although the column names could be changed, I am keeping the below column names the same so that could be used later
		header_3=$2;
		header_4=$3;
	       	header_5=$4;
	}
	END {
		# printing the column names
		print header_1, header_2, header_3, header_4, header_5;
		# first sorting items, then using the sorted items to sort the data by item
		asorti(count, sorted_items);
		for(indx in sorted_items) { 
			# NOTE: the name "index" is a function in awk (so it is reserved), so I am using "indx" instead
			item=sorted_items[indx];
			print item, count[item], col_2[item], col_3[item], col_4[item];
		}
	}
' sales.csv # using the sales data from https://www.udemy.com/course/linux-command-line-and-shell-scripting-masterclass 
}

# Creating different sales reports below


summarize_sales_data | awk '
	BEGIN {
		FS="|";
		OFS="|";
		print "\n******* Average Sales per Item ********\n"
	}
	(NR == 1) {
		print $1, "Total Avg";	
	}
	(NR != 1) {
		total_avg = $3/$2 + $4/$2 + $5/$2;
	       	print $1, total_avg;	
	}
'

summarize_sales_data | awk '
	BEGIN {
		FS="|";
		OFS="|";
		print "\n******* Average Sales per Item and Month ********\n"
	}
	(NR == 1) {
		print $1, $3 " Avg", $4 " Avg", $5 " Avg";	
	}
	(NR != 1) {
		col_3_avg = $3 / $2;
		col_4_avg = $4 / $2;
		col_5_avg = $5 / $2;
	       	print $1, col_3_avg, col_4_avg, col_5_avg;	
	}
'

summarize_sales_data | awk '
	BEGIN {
		FS="|";
		OFS="|";
		print "\n******* Total Sales per Item ********\n"
	}
	(NR == 1) {
		print $1, "Total Sum";	
	}
	(NR != 1) {
		total_sum = $3 + $4 + $5;
	       	print $1, total_sum;	
	}
'

summarize_sales_data | awk '
	BEGIN {
		FS="|";
		OFS="|";
		print "\n******* Total Sales per Item and Month ********\n"
	}
	(NR == 1) {
		print $1, $3 " Total", $4 " Total", $5 " Total";	
	}
	(NR != 1) {
	       	print $1, $3, $4, $5;	
	}
'

summarize_sales_data | awk '
	BEGIN {
		FS="|";
		OFS="|";
		print "\n******* Total Counts by Item ********\n"
	}
	(NR == 1) {
		print $1, $2;	
	}
	(NR != 1) {
	       	print $1, $2;	
	}
'

