#!/usr/bin/env bash
#
# Find how many days it took each contributor to reach 100 commits

# number of commits
COMMITS=150
DAYS_IN_MONTH=30
MONTHS_IN_YEAR=12
# shellcheck disable=SC2066
IFS=
# I know there are 18 people with 150 commits
git shortlog -s -n  | head -18  | cut -c8- | while read -r user
do
  start=$(git log --pretty=format:"%ad" --date=format:'%Y-%m-%d'  --author="$user" | tail -"$COMMITS" | tail -1)
  start_year=$(git log --pretty=format:"%ad" --date=format:'%Y'   --author="$user" | tail  -"$COMMITS"  | tail -1)
  start_month=$(git log --pretty=format:"%ad" --date=format:'%m'  --author="$user" | tail -"$COMMITS"  | tail -1)
  start_days=$(git log --pretty=format:"%ad" --date=format:'%d'   --author="$user" | tail  -"$COMMITS" | tail -1)
  start_total=$(echo "((($start_year * $MONTHS_IN_YEAR) + $start_month) * $DAYS_IN_MONTH) + $start_days" | bc)

  end=$(git log --pretty=format:"%ad" --date=format:'%Y-%m-%d'  --author="$user" | tail -"$COMMITS"  | head -1)
  end_year=$(git log --pretty=format:"%ad" --date=format:'%Y'   --author="$user" | tail  -"$COMMITS"  | head -1)
  end_month=$(git log --pretty=format:"%ad" --date=format:'%m'  --author="$user" | tail  -"$COMMITS"  | head -1)
  end_days=$(git log --pretty=format:"%ad" --date=format:'%d'   --author="$user" | tail  -"$COMMITS" | head -1)
  end_total=$(echo "((($end_year * $MONTHS_IN_YEAR) + $end_month) * $DAYS_IN_MONTH) + $end_days" | bc)

  # compute number of days for 100 commits
  diff_days=$(echo "$end_total - $start_total" | bc)
  echo "$diff_days $user ($start to $end)"
done
