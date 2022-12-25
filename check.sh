#!/bin/bash

# determine number of occurrences of most common label name
max_duplicate="$( find regexes -type f -print0 | xargs -0 -L1 basename | \
                     sort | uniq -c | sort -n | tail -n 1 | awk '{ print $1 }' )"

# print the duplicates
if [[ $max_duplicate -gt 1 ]]; then
    echo "Warning! The following labels have duplicate names:"

    (echo "count name";
     find regexes -type f -print0 | xargs -0 -L1 basename | \
         sort | uniq -c | sort -nr | egrep -iv "^ *1 " | head -n 5) | \
    column -t -s ' ' | while read line; do
                          echo "    $line";
                       done
fi

find regexes -type f -print0 | xargs -0 sha256sum | awk '{ print $1 }' | sort | uniq -c | egrep -iv "^ *1 "
