#!/usr/bin/env bash
REFERENCE="HEAD^"
if [ $# -gt 0 ]; then
    REFERENCE=$1
fi
unameOut="$(uname -s)"
case "${unameOut}" in
    Darwin*)
    CLANG_FORMAT_HOME=/usr/local/Cellar/clang-format/14.0.6
    git diff -U0 --no-color $REFERENCE \
        | "$CLANG_FORMAT_HOME/share/clang/clang-format-diff.py" \
        -binary "$CLANG_FORMAT_HOME/bin/clang-format" -p1 -i;;
    Linux*)
        git diff -U0 --no-color $REFERENCE | clang-format-diff -p1 -i;;
    *)          echo "UNKNOWN:${unameOut}"
esac
