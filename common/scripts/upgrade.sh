#!/usr/bin/env bash
HERE=$(dirname $0)
cd $HERE
./update.sh
./switch.sh
./cleanup.sh