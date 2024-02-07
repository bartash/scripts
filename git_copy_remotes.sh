#!/usr/bin/env bash
# copy the remotes from a repo
git remote -v | awk '{printf "git remote add %s %s\n", $1, $2}' | grep -v origin | sort -u
