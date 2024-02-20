#!/bin/bash


list_users_and_groups() {
  log "######## List Users and Groups Process #########"
  start_time=$(date +"%Y_%m_%d-%H_%M_%S")
  log "Started list users and groups process at ${start_time}"

  echo -n "" > "${users_and_groups_report}"
  
  for group_file in ${users_and_groups_dir}/server_*.group; do
    #server=$(basename "${group_file}" | cut -d "." -f "1" )
    server=$(basename "${group_file}" ".group" )
    echo -e "*************************\n" >> "${users_and_groups_report}"
    echo -e "Processing group file ${group_file} for server: ${server}\n" >> "${users_and_groups_report}"
    echo -e "*************************\n" >> "${users_and_groups_report}"
  
    awk '
      BEGIN { FS=":"; OFS=": "; print "Listing Users and their Groups\n" }
      ( $1 ~/^group/ ) { print $1, $4 "\n" }
    ' "${group_file}" >> "${users_and_groups_report}"
  done
  
  end_time=$(date +"%Y_%m_%d-%H_%M_%S")
  log "Completed list users and groups process at ${end_time}"
}
