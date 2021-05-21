#!/usr/bin/env bash

readonly source_file="$1"
readonly source_url="$2"
readonly extra_packages=( "${@:3}" )

if [ -f ${source_file} ]; then
   echo "File ${source_file} exists."
else
  echo "File ${source_file} does not exist."
  echo "Downloading it from ${source_url}${source_file}"
  yum -y install wget
  wget ${source_url}${source_file}
  rpm -Uvh ${source_file}

  yum -y install puppet-agent
fi

if [ ${#extra_packages[@]} -eq 0 ]; then
  echo "No extra packages installed"
else
  yum -y install ${extra_packages[@]}
  echo "Extra packages installed: ${extra_packages[@]}"
fi
echo -e "Installed puppet version: $(puppet --version)"
