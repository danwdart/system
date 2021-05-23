#!/usr/bin/env bash
HERE=$(dirname $0)
$HERE/update.sh
$HERE/switch.sh
$HERE/cleanup.sh