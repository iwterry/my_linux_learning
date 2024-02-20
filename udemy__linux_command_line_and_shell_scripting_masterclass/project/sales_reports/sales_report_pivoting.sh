#!/bin/bash

sales_report_pivoting() {
log "######## Sales Report Pivoting ########";
log "Starting sales report pivoting at $(date +'%Y_%m_%d-%H_%M_%S')";
<< "##FIRST_APPROACH"
awk -F "|" '
        ( NR > 1 ) {
                departments[$2]; 
                # equal to departments[$2] = ""
        }

        ( $1 == "ABC" ) {
                abc_sales[$2] = $3;
        }

        ( $1 == "CDE" ) {
                cde_sales[$2] = $3;
        }

        ( $1 == "XYZ" ) {
                xyz_sales[$2] = $3;
        }

        END {
                print "Department|ABC|CDE|XYZ";
                for (dept in departments) {
                        printf "%s|%s|%s|%s\n", dept, abc_sales[dept], cde_sales[dept], xyz_sales[dept];
                }
        }
' "${sales_pivot_csv}" > "${sales_pivot_rpt}"
##FIRST_APPROACH

#<< "##ANOTHER_APPROACH"
awk '
	BEGIN {
		FS = "|";
		OFS = "|";
	}

	( NR > 1 ) {
		departments[$2] = "";

		if ( $1 == "ABC" ) {
			abc_sales[$2] = $3;
		}
		else if ( $1 == "CDE" ) {
			cde_sales[$2] = $3;
		}
		else if ( $1 == "XYZ" ) {
			xyz_sales[$2] = $3;
		}
	}

	END {
		print "Department|ABC|CDE|XYZ";
		for (dept in departments) {
			printf "%s%s%s%s%s%s%s\n",
				dept,
				OFS,
			       	abc_sales[dept], 
				OFS,
				cde_sales[dept],
				OFS,
				xyz_sales[dept];
		}
	}
' "${sales_pivot_csv}" > "${sales_pivot_rpt}"
##ANOTHER_APPROACH
log "Ended sales report pivoting at $(date +'%Y_%m_%d-%H_%M_%S')";
}
