#!/bin/bash

#echo $1
for word in $1; do
    url=`echo $word | grep "\."`
    if [[ $url != "" ]]; then
        #curl "$url"
        nospace=`curl -L -s "$url" | tee 1 | grep -i -o -P "<title>[\n\s]*.*[\n\s]*</title>" | sed "s/<[^>]*>//g" | tr '\r' ' ' | tr '\n' ' '`
        # bash trims all whitespace when assigning variables
        echo $nospace
    fi
done;

