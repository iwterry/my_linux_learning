#!/bin/bash

report_compression() {
  log "Starting report compression at $(date +'%Y_%m_%d-%H_%M%_%s')";
 
  find "${project_dir}" -type f -name "*.rpt" | while read report_filename; do
    log "Processing file: ${report_filename}"
    tar -c -z -f "${report_filename}.tar.gz" "${report_filename}" &> /dev/null

    if [[ ${?} -ne 0 ]]; then
      log "Failed to archive file ${report_filename}"
    fi
  done

  log "Finished report compression at $(date +'%Y_%m_%d-%H_%M%_%s')";
}

report_copy() {
  log "Starting report copy at $(date +'%Y_%m_%d-%H_%M%_%s')";

  find "${project_dir}" -type f -name "*.rpt" -exec dirname "{}" \; | sort -u |
    while read dir_name; do
      find "${dir_name}" -type f -name "*.tar.gz" \! -path "${dir_name}/backup/*" |
        while read filename; do
          mkdir -p "${dir_name}"/backup
	      
          log "Copying file ${filename} to directory ${dir_name}/backup"
          cp "${filename}" "${dir_name}"/backup
	      
          if [[ ${?} -ne 0 ]]; then
            log "Failed to copy file file ${filename} to directory ${dir_name}/backup"
          fi	
        done
    done 

  log "Finished report copy at $(date +'%Y_%m_%d-%H_%M%_%s')";
}
