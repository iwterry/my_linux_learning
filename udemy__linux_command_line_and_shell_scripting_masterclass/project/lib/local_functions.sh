#!/bin/bash

config_file=${project_dir}/config/config.txt
source ${config_file}

cleanup_and_exit() {
  exit ${1}
}

delete_empty_lines_and_comments() {
  for file in $1/cleanup_*.txt; do
    sed -i -e "/^[[:space:]]*$/d" -e "/^#/d" "${file}" 
    log "Claned up file: ${file}"
  done
}

init_logs_and_reports() {
  echo -n "" > ${log_file}
}

log() {
  if [[ ${logging} = true ]]; then
    echo -e "${@}\n" |& tee -a ${log_file}
  fi
}

validate_date() {
  date_reg_expr="^[12][[:digit:]]{3}-[[:digit:]]{2}-[[:digit:]]{2}$"

  [[ "${1}" =~ ${date_reg_expr} ]] && date -d $1 &> /dev/null

  if [[ ${?} -eq 1 ]]; then
    echo "Invalid date. Enter valid date in the format YYYY-MM-DD" >&2
    usage
    cleanup_and_exit 1
  fi
}
