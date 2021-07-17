#!/bin/sh

# Requires Whitacker's Words (Latin dictionary), you can find it at https://github.com/mk270/whitakers-words

err() { echo "Usage :
    taglatin [OPTIONS] file(s)
You will be promted to give file(s) as command-line arguments if you have not already." && exit 1 ;}

file="$1"
output="$file-tagged"

cp "$file" "$output"

[ ! -f "$file" ] && echo "Provide a file to tag." && err

while read -r line; do
    for word in $line; do
        pos=$(words "$word" | grep -v \; | grep -v \] | grep -v ENTER | awk '{print $2}' | sort -u | xargs)
	sed -i "s/$word/$word\/\/$pos/g" "$output"
    done
done < "$file"
