#!/bin/bash

echo -n "" > "${sales_agg_rpt}"

sales_report_aggregation() {
	log "######## Sales Aggregation ########"
	log "Starting sales aggregation at $(date +'%Y_%m_%d-%H_%M_%S')"

	echo -e "\n***** Aggregate Sales Totals by Month and Item *******\n" >> "${sales_agg_rpt}"
	# Aggregate totals by month and item
	awk -F "|" '
		BEGIN {
			OFS="|";
		}
		( NR > 1 ) {
			sales_jan[$1] += $2;
			sales_feb[$1] += $3;
			sales_mar[$1] += $4;
		}
		END {
			print "ItemId|Jan Totals|Feb Totals|Mar Totals";
			for (item in sales_jan) {
				# sorts by the first column
				# NOTE: I was unable to use this approach to discover how to sort by other columns;
				#	I think I would just have to use awk function "asorti" approach
				print item, sales_jan[item], sales_feb[item], sales_mar[item] | "sort";
					
			}
		}
	' "${sales_agg_csv}"  >> "${sales_agg_rpt}"

	echo -e "\n***** Aggregate Sales Totals by Month *******\n" >> "${sales_agg_rpt}"
	# Aggregate totals by item
	awk -F "|" '
		BEGIN {
			OFS="|";
		}
		( NR > 1 ) {
			sales_jan[$1] += $2;
			sales_feb[$1] += $3;
			sales_mar[$1] += $4;
		}
		END {
			print "ItemId|Totals";
			for (item in sales_jan) {
				item_total = sales_jan[item] + sales_feb[item] + sales_mar[item] 
				# sorts by the first column
				print item, item_total | "sort";
					
			}
		}
	' "${sales_agg_csv}"  >> "${sales_agg_rpt}"
	
	echo -e "\n***** Aggregate Item Counts *******\n" >> "${sales_agg_rpt}"
	# Aggregate counts by item
	awk -F "|" '
		BEGIN {
			OFS="|";
		}
		( NR > 1 ) {
			item_count[$1] += 1
		}
		END {
			print "ItemId|Counts";
			for (item in item_count) {
				# sorts by the first column
				print item, item_count[item] | "sort";
					
			}
		}
	' "${sales_agg_csv}"  >> "${sales_agg_rpt}"
	
	echo -e  "\n***** Average Sales by Month and Item *******\n" >> "${sales_agg_rpt}"
	# Average totals by month by item
	awk -F "|" '
		BEGIN {
			OFS="|";
		}
		( NR > 1 ) {
			sales_jan[$1] += $2;
			sales_feb[$1] += $3;
			sales_mar[$1] += $4;
			item_count[$1] += 1
		}
		END {
			print "ItemId|Jan Avg|Feb Avg|Mar Avg";
			for (item in sales_jan) {
				sales_jan_avg = sales_jan[item] / item_count[item]
				sales_feb_avg = sales_feb[item] / item_count[item]
				sales_mar_avg = sales_mar[item] / item_count[item]

				# sorts by the first column
				print item, sales_jan_avg, sales_feb_avg, sales_mar_avg  | "sort";
					
			}
		}
	' "${sales_agg_csv}"  >> "${sales_agg_rpt}"
	
	echo -e "\n***** Total Average Sales by Item *******\n" >> "${sales_agg_rpt}"
	# Average totals by item
	awk -F "|" '
		BEGIN {
			OFS="|";
		}
		( NR > 1 ) {
			sales_jan[$1] += $2;
			sales_feb[$1] += $3;
			sales_mar[$1] += $4;
			item_count[$1] += 1
		}
		END {
			print "ItemId|Total Avg";
			for (item in sales_jan) {
				sales_jan_avg = sales_jan[item] / item_count[item]
				sales_feb_avg = sales_feb[item] / item_count[item]
				sales_mar_avg = sales_mar[item] / item_count[item]
				total_avg = sales_jan_avg + sales_feb_avg + sales_mar_avg

				# sorts by the first column
				print item, total_avg | "sort";
					
			}
		}
	' "${sales_agg_csv}"  >> "${sales_agg_rpt}"

	log "Ended sales aggregation at $(date +'%Y_%m_%d-%H_%M_%S')"
}
