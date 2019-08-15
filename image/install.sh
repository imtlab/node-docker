#!/bin/bash
set -e
source /node_build/buildconfig
set -x

/node_build/node_prep.sh

if [[ "$node10153" = 1 ]]; then /node_build/node10.15.3.sh; fi
if [[ "$node10163" = 1 ]]; then /node_build/node10.16.3.sh; fi

/node_build/cleanup.sh

