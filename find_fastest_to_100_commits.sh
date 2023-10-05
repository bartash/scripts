#!/usr/bin/env bash
#
# Find how many days it took each contributor to reach 100 commits

# shellcheck disable=SC2066
IFS=
# I know there are 33 people with 100 commits
git shortlog -s -n  | head -33  | cut -c8- | while read -r user
do
  start=$(git log --pretty=format:"%ad" --date=format:'%Y-%m-%d'  --author="$user" | tail -100 | tail -1)
  start_year=$(git log --pretty=format:"%ad" --date=format:'%Y'  --author="$user" | tail -100 | tail -1)
  start_month=$(git log --pretty=format:"%ad" --date=format:'%m'  --author="$user" | tail -100 | tail -1)
  start_days=$(git log --pretty=format:"%ad" --date=format:'%d'  --author="$user" | tail -100 | tail -1)
  start_total=$(echo "((($start_year * 12) + $start_month) * 30) + $start_days" | bc)
  end=$(git log --pretty=format:"%ad" --date=format:'%Y-%m-%d'  --author="$user" | tail -100 | head -1)
  end_year=$(git log --pretty=format:"%ad" --date=format:'%Y'  --author="$user" | tail -100 | head -1)
  end_month=$(git log --pretty=format:"%ad" --date=format:'%m'  --author="$user" | tail -100 | head -1)
  end_days=$(git log --pretty=format:"%ad" --date=format:'%d'  --author="$user" | tail -100 | head -1)
  end_total=$(echo "((($end_year * 12) + $end_month) * 30) + $end_days" | bc)
  # compute number of days for 100 commits
  diff_days=$(echo "$end_total - $start_total" | bc)
  echo "$diff_days $user ($start to $end)"
done