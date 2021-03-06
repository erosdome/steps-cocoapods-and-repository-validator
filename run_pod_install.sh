#!/bin/bash

THIS_SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${THIS_SCRIPTDIR}/_utils.sh"
source "${THIS_SCRIPTDIR}/_formatted_output.sh"


write_section_to_formatted_output "### Searching for podfiles and installing the found ones"

podcount=0
IFS=$'\n'
for podfile in $(find . -type f -name 'Podfile')
do
  podcount=$[podcount + 1]
  echo " (i) Podfile found at: ${podfile}"
  curr_podfile_dir=$(dirname "${podfile}")
  echo " (i) Podfile directory: ${curr_podfile_dir}"

  (cd "${curr_podfile_dir}" && pod install)
  if [ $? -ne 0 ]; then
    write_section_to_formatted_output "Could not install podfile: ${podfile}"
    exit 1
  fi
  echo_string_to_formatted_output "* Installed podfile: ${podfile}"
done
unset IFS
write_section_to_formatted_output "**${podcount} podfile(s) found and installed**"
