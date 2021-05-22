#!/usr/bin/env bash

readonly source_file="$1"
readonly source_url="$2"
readonly extra_packages=( "${@:3}" )

if [ -f ${source_file} ]; then
   echo "File ${source_file} exists."
else
  echo "File ${source_file} does not exist."
  echo "Downloading it from ${source_url}${source_file}"
  zypper --non-interactive --no-gpg-checks install wget
  wget ${source_url}${source_file}
  zypper --non-interactive --no-gpg-checks install ${source_file}

  zypper --non-interactive --no-gpg-checks install puppet-agent

  ln -s /opt/puppetlabs/bin/puppet /usr/local/bin/puppet
  ln -s /opt/puppetlabs/bin/facter /usr/local/bin/facter
  ln -s /opt/puppetlabs/bin/hiera /usr/local/bin/hiera
fi

if [ ${#extra_packages[@]} -eq 0 ]; then
  echo "No extra packages installed"
else
  zypper --non-interactive --no-gpg-checks install ${extra_packages[@]}
  echo "Extra packages installed: ${extra_packages[@]}"
fi
echo -e "Installed puppet version: $(puppet --version)"
