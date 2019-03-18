#!/bin/bash
set -e
source /node_build/buildconfig
source /node_build/node_prep.sh
source /node_build/node_install
set -x

node_VERSION=10.15.3
node_DOWNLOAD_SHA256=6c35b85a7cd4188ab7578354277b2b2ca43eacc864a2a16b3669753ec2369d52

node_install
