#!/bin/bash

document_merge() {
  log "######### Document Merge Process ###########"
  start_time=$(date +"%Y_%m_%d-%H_%M_%S")
  log "Starting document merge process at ${start_time}"
  
  IFS=","
  while read -r last_name first_name; do
    
    while read holiday_special begin_date end_date min_percentage max_percentage; do
      report_filename=${first_name}_${last_name}_${holiday_special}.txt
      
      sed \
        -e "s/<First_Name>/${first_name}/g" \
        -e "s/<Last_Name>/${last_name}/g" \
	-e "s/<Holiday_Specials>/${holiday_special}/g" \
	-e "s/<Begin_Date>/${begin_date}/g" \
	-e "s/<End_Date>/${end_date}/g" \
	-e "s/<Min_Pct>/${min_percentage}/g" \
	-e "s/<Max_Pct>/${max_percentage}/g" \
	"${doc_merge_reports_template}" > "${doc_merge_reports_dir}"/"${report_filename}"
    done < "${doc_merge_conf_file}"
  done < "${doc_merge_customer_conf_file}"

  end_time=$(date +"%Y_%m_%d-%H_%M_%S")
  log "End document merge process at ${end_time}"

}


