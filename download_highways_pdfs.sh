#!/usr/bin/env bash
wget -r  -l1 -np -nc  --limit-rate=50k -A "*195[2-9]*.pdf"  http://libraryarchives.metro.net/DPGTL/Californiahighways 
wget -r  -l1 -np -nc  --limit-rate=100k -A "*196[0-2]*.pdf"  http://libraryarchives.metro.net/DPGTL/Californiahighways 

