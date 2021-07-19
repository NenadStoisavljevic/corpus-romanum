#!/bin/sh

# Requires Whitacker's Words (Latin dictionary), you can find it at https://github.com/mk270/whitakers-words

err() { echo "Usage :
    taglatin [OPTIONS] file(s)
You will be promted to give file(s) as command-line arguments if you have not already." && exit 1 ;}

file="$1"
output="$file-tagged"

[ ! -f "$file" ] && echo "Provide a file to tag." && err

while read -r line; do
    last=${line##* }
    for word in $line; do
        pos=$(words "$word" | grep -v \; | grep -v \] | grep -v ENTER | awk '{print $2}' | sort -u | tr -d '\n')
        [ "$word" = "$last" ] && printf "%s\n" "$word" >> "$output" || printf "%s//%s " "$word" "$pos" >> "$output"
    done
done < "$file"
