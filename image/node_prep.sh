#!/bin/bash
set -ex

locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8
echo '/root' > /etc/container_environment/HOME
packages='python build-essential'
