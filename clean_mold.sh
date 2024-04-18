#!/usr/bin/env bash
# clean files left by mold linker
find | egrep /.mold-...... | xargs rm
