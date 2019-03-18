#!/bin/bash
set -o pipefail

function ok()
{
	echo "  OK"
}

function fail()
{
	echo "  FAIL"
	exit 1
}

echo "Checking whether all services are running..."
services=`sv status /etc/service/*`
sv status /etc/service/*
status=$?
if [[ "$status" != 0 || "$services" = "" || "$services" =~ down ]]; then
	fail
else
	ok
fi

echo "Checking Node is installed and has the proper version..."
node=$(node --version )

if [[ $node == $1 ]]; then
	ok
else
	echo "Wrong version of Node installed! ${node}"
	fail
fi
