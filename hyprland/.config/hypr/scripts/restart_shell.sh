#!/usr/bin/env bash
scripts_dir="$(dirname "$0")"
eval "$scripts_dir/stop_shell.sh ${*:-all} && $scripts_dir/start_shell.sh ${*:-all}"
