#!/bin/sh

# Requires Whitacker's Words (Latin dictionary), you can find it at https://github.com/mk270/whitakers-words

tags="ADJ:A
ADV:D
CONJ:C
INTERJ:I
NUM:M
PREP:P
PRON:O
SUFFIX:S
VPAR:R"

sub() {
    labels=""
    for arg in $@; do
        label=$(echo "$tags" | grep -w "$arg" | cut -d ':' -f 2)
        [ -z "$label" ] && labels="${labels}$arg" || labels="${labels}$label"
    done; printf "%s\n" "$labels"
}

err() { echo "Usage :
    taglatin [OPTIONS] file(s)
You will be prompted to give file(s) as command-line arguments if you have not already." && exit 1 ;}

file="$1"
output="$file-tagged"

[ ! -f "$file" ] && echo "Provide a file to tag." && err

echo "Tagging \"$file\"..."

while read -r line; do
    last=${line##* }
    for word in $line; do
        pos=$(words "$word" | grep -Ev '(;|])' | awk '{print $2}' | sort -u)
        label=$(sub "$pos")
        [ "$word" = "$last" ] && printf "%s//%s\n" "$word" "$label" >> "$output" || printf "%s//%s " "$word" "$label" >> "$output"
    done
done < "$file"
