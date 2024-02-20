#!/bin/bash

backup_and_delete() {
  log "Starting backup and delete process at $(date +'%Y_%m_%d-%H_%M_%S')"

  num_files_to_move=$( ls -l "${backup_from_dir}"/*.txt 2> /dev/null | wc -l )

  if [[ num_files_to_move -eq 0 ]]; then
    log "No files to move"
  else
    mv "${backup_from_dir}"/*.txt "${backup_to_dir}"

    num_files_moved=$( ls -l "${backup_to_dir}"/*.txt | wc -l )

    if [[ num_files_to_move -eq num_files_moved ]]; then
      log "All files have been successfully backed up"
    else
      log "Failure backing up all files"
    fi
  fi

  if ( rm "${backup_and_delete_tmp_dir}"/*.txt 2> /dev/null ); then
    if ( rm -r "${backup_and_delete_tmp_dir}" 2> /dev/null ); then
      log "tmp directory successfully deleted"
    else
      log "Failure to delete tmp directory" 
    fi 
  fi
	  
  log "Finished backup and delete process at $(date +'%Y_%m_%d-%H_%M_%S')"
	
}
