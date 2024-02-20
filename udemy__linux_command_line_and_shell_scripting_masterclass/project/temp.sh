#!/bin/bash

<< "##FIRST_APPROACH"
awk '
	BEGIN {
		FS = "|";
		OFS = "|";
	}
	(NR > 1) {
		departments[$2] = $2;
		stores[$1] = $1;
		sales_by_department_and_store[$2][$1] = $3;
	}
	END {
		ORS = OFS;
		print "Department";

		num_stores = length(stores);
		store_counter = 0;
		for (store in stores) {
			store_counter += 1;
			if (store_counter == num_stores) {
				ORS = "\n";
			}
			print store;	
		}

		for (department in departments) {
			ORS = OFS;
			print department;

			store_counter = 0;
			for (store in stores) {
				store_counter += 1;

				if (store_counter == num_stores) {
					ORS = "\n";
				}
				print  sales_by_department_and_store[department][store];
			}
		}
	}
' sales_reports/sales_pivot.csv
##FIRST_APPROACH

#<< "##SECOND_APPROACH"
awk '
	BEGIN {
		FS = "|";
		OFS = "|";
	}
	(NR > 1) {
		departments[$2] = $2;
		stores[$1] = $1;
		sales_by_department_and_store[$2][$1] = $3;
	}
	END {
		printf "%s",  "Department";

		for (store in stores) {
			printf "%s%s", OFS, store;	
		}

		printf "\n";

		for (department in departments) {
			printf "%s", department;

			for (store in stores) {
				printf "%s%d",  OFS, sales_by_department_and_store[department][store];
			}
			printf "\n";
		}
	}
' sales_reports/sales_pivot.csv
##SECOND_APPROACH
