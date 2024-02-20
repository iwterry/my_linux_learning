#!/bin/bash

source ~iwterry/project/config/config.txt

fallocate -l 500001 "${disk_monitor_test_file_txt}"

mv "${backup_to_dir}"/*.txt "${backup_from_dir}"

mkdir -p "${backup_and_delete_tmp_dir}"

touch "${backup_and_delete_tmp_dir}"/delete_me_{0..9}.txt
