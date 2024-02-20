#!/bin/bash

config_file=~iwterry/project/config/config.txt

source "${config_file}"
source "${local_functions}"
source "${doc_merge}"
source "${users_and_groups}"
source "${sales_report_aggregation}"
source "${sales_report_pivoting}"
source "${disk_monitor}"
source "${backup_and_delete}"
source "${search_and_replace}"
source "${filter_and_format}"
source "${utils}"

logging=true
init_logs_and_reports

current_date=$(date +%Y_%m_%d)
log "Current date: ${current_date}"
start_time=$(date +%H:%M:%S)
log "Start time: ${start_time}"

user=${USER}
log "User: ${user}"

arg_list=${@}
log "Argument list: ${arg_list}"

usage() {
  echo -e "Sample usage: ${0} -l -d <report_date> -t -r"
  echo -e "\t -l specifies the logging option. If present, logging occurs; otherwise, no logging occurs."
  echo -e "\t -d specifies the date option. <report_date> should be in the format 'YYYYMMDD'."
  echo -e "\t -t specifies the trim option to be run on some documents."
  echo -e "\t -r specifies the entire set of reports that need to be run."
}

################ Main Processing ##################

if [[ ${#} -ne 0 ]]; then
  logging=false
  while getopts ":ld:tr" opt_name ; do
    case ${opt_name} in
      l) logging=true ;;
      d)
	report_date=${OPTARG}
        validate_date ${report_date}
        log "Reports run date: ${report_date}"	
      ;;
      t) 
        delete_empty_lines_and_comments ${cleanup_dir}	      
      ;;
      r)
        document_merge
        list_users_and_groups
	sales_report_aggregation
	sales_report_pivoting
	disk_monitor
	backup_and_delete
	search_and_replace
	filter_and_format
      ;;
      :|\?)
        if [[ ${OPTARG} = "d" ]]; then
	  log "Error: argument missing for option 'd'"
        else
           log "Error: '${OPTARG}' is an invalid option"
	fi
	usage
	cleanup_and_exit 1
      ;;
    esac
  done

  shift $(( OPTIND - 1  ))

  report_compression

  report_copy
else
  usage
  cleanup_and_exit 1
fi

