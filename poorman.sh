#!/bin/bash

# summarize pstacks
# https://jira.cloudera.com/browse/CDH-72764?focusedCommentId=2065115&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-2065115

# e.g. cat pstack.txt | $0

awk '
  BEGIN { s = ""; } 
  /^Thread/ { print s; s = ""; } 
  /^\#/ { if (s != "" ) { s = s "," $4} else { s = $4 } } 
  END { print s }' | sort | uniq -c | sort -r -n -k 1,1
