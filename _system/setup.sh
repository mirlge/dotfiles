#!/usr/bin/env bash
# WARNING: This can be dangerous if used in certain ways!
echo 'WARNING: This can be dangerous if used in certain ways!'
echo
printf 'Are you sure you want to do this? (y/N) '
read -r danger_answer
if [ "$danger_answer" != "y" ]; then
	exit
fi

stow -t / keyd
