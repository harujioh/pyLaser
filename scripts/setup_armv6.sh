#!/bin/bash -e

# openFrameworks-template
# https://github.com/yuhki50/openFrameworks-template
#
# Copyright (c) yuhki50
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

# variables
of_version=v0.9.2
of_platform=linuxarmv6l
of_package_name=of_${of_version}_${of_platform}_release
of_url=http://openframeworks.cc/versions/${of_version}/${of_package_name}.tar.gz
working_dir=`mktemp -d`
script_dir=`dirname $0`

# function
usage_exit() {
  echo "Usage: `basename $0` -f [openFrameworks tar.gz file path]"
  exit 1
}

# parse option
while getopts f:h OPT
do
  case ${OPT} in
    f) tar_gz_file=${OPTARG}
      ;;
    h) usage_exit
      ;;
  esac
done

echo working directory: ${working_dir}

# process
if [ -e "${tar_gz_file}" ]; then
  echo tar.gz file: ${tar_gz_file}
  of_package_name=`echo ${tar_gz_file} | xargs basename -s .tar.gz`
  cp ${tar_gz_file} ${working_dir}/${of_package_name}.tar.gz
else
  curl ${of_url} -o ${working_dir}/${of_package_name}.tar.gz
fi

tar xvzf ${working_dir}/${of_package_name}.tar.gz -C ${working_dir}
rsync -av ${working_dir}/${of_package_name}/ ${script_dir}/../openFrameworks

echo Success!

