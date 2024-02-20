#!/bin/bash

disk_monitor() {
  threshold_size=500000

  file_size=$(ls -l "${disk_monitor_test_file_txt}" | cut -d " " -f "5")

  log "Starting disk monitor process at $(date +'%Y_%m_%d-%H_%M_%S')"
  log "File size for disk monitor: ${file_size} bytes"
  
  if [[ ${file_size} -gt ${threshold_size} ]]; then
    log "Deleting file: ${disk_monitor_test_file_txt}"
    rm "${disk_monitor_file}" 2> /dev/null

    if [[ ${?} -ne 0 ]]; then
      log "The file was unable to be deleted"
    else
      log "The file was successfully deleted"
    fi  
  fi

  log "Finished disk monitor process at $(date +'%Y_%m_%d-%H_%M_%S')"
}
