#!/bin/bash -e

# openFrameworks-template
# https://github.com/yuhki50/openFrameworks-template
#
# Copyright (c) yuhki50
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

# variables
of_version=v0.9.2
of_platform=osx
of_package_name=of_${of_version}_${of_platform}_release
of_url=http://openframeworks.cc/versions/${of_version}/${of_package_name}.zip
working_dir=`mktemp -d -t tmp`
script_dir=`dirname $0`

# function
usage_exit() {
  echo "Usage: `basename $0` -f [openFrameworks zip file path]"
  exit 1
}

# parse option
while getopts f:h OPT
do
  case ${OPT} in
    f) zip_file=${OPTARG}
      ;;
    h) usage_exit
      ;;
  esac
done

echo working directory: ${working_dir}

# process
if [ -e "${zip_file}" ]; then
  echo zip file: ${zip_file}
  of_package_name=`echo ${zip_file} | xargs basename -s .zip`
  cp ${zip_file} ${working_dir}/${of_package_name}.zip
else
  curl ${of_url} -o ${working_dir}/${of_package_name}.zip
fi

unzip ${working_dir}/${of_package_name}.zip -d ${working_dir}
rsync -av ${working_dir}/${of_package_name}/ ${script_dir}/../openFrameworks

echo Success!

