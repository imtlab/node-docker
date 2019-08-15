#!/bin/bash
set -e
source /node_build/buildconfig
source /node_build/node_prep.sh
source /node_build/node_install
set -x

node_VERSION=10.16.3
node_DOWNLOAD_SHA256=2f0397bb81c1d0c9901b9aff82a933257bf60f3992227b86107111a75b9030d9

node_install
